% BY: ABAD HAMEED
% ENGI4559: Digital Signals & Image Processcing
% PROF. R. Khoury
% DATE: November 26, 2015

%%%% PART 2: Notch Filters %%%%

% Read original image
origImage = imread('car.png');
% Display Original Image
figure;
colormap(gray);
imagesc(origImage)
title('Original Image (Car)');

% Convert from uint8 to double for math
origImage = double(origImage);
% Fourier transform (inverse would be ifft2(F))
padCar = paddedsize(size(origImage));
F = fft2(origImage,padCar(1),padCar(2));
% Unshifted Fourier spectrum
Spectrum = sqrt( real(F).^2 + imag(F).^2 );
figure;
colormap(gray);
imagesc(1+log10(Spectrum));
title('Unshifted Fourier Spectrum (Padded Car)');
% Shift the spectrum, as per convention
SpectrumS = fftshift(Spectrum);
% Phase angle
Phase = atan2( imag(F), real(F) );
% Display Fourier Spectrum
figure;
colormap(gray);
imagesc(1+log10(SpectrumS));
title('Fourier Spectrum (Car)');
% Display Phase Angle
figure;
colormap(gray);
imagesc(Phase);
title('Phase Angle (Car)');

% Shift the spectrum back
%SpectrumSS = fftshift(SpectrumS);
% Compute the values of Fourier Transform
%F2 = SpectrumSS .* exp( sqrt(-1) * Phase );
% Perform the inverse DFT
% Note that rounding errors can leave a small
%  imaginary part (~10^-14) which we must discard
%reconstructed = real(ifft2(F2));
% Display the image
%figure;
%colormap(gray)
%imagesc(reconstructed)
%title('Reconstructed Image')

car=imread('car.png');
%Determine good padding for Fourier transform
PQ = paddedsize(size(car));
%Create Notch filters corresponding to extra peaks in the Fourier transform
H1  = notch('gaussian', PQ(1), PQ(2), 10, 60, 67);   %unshifted spec. top left
H2  = notch('gaussian', PQ(1), PQ(2), 10, 55, 1016); %u.spec bottom left
H3  = notch('gaussian', PQ(1), PQ(2), 10, 803, 74);  %u.spec top right
H4  = notch('gaussian', PQ(1), PQ(2), 10, 798, 1023);%u.spec bottom right
H5  = notch('gaussian', PQ(1), PQ(2), 10, 55, 354);
H6  = notch('gaussian', PQ(1), PQ(2), 10, 60, 730);
H7  = notch('gaussian', PQ(1), PQ(2), 10, 798, 360);
H8  = notch('gaussian', PQ(1), PQ(2), 10, 803, 736);
H9  = notch('gaussian', PQ(1), PQ(2), 10, 282, 74);
H10 = notch('gaussian', PQ(1), PQ(2), 10, 277, 1023);
H11 = notch('gaussian', PQ(1), PQ(2), 10, 576, 1016);
H12 = notch('gaussian', PQ(1), PQ(2), 10, 581, 67);

% Calculate the discrete Fourier transform of the image
F=fft2(double(car),PQ(1),PQ(2));
% Apply the notch filters to the Fourier spectrum of the image
FS_car = F.*H1.*H2.*H3.*H4.*H5.*H6.*H7.*H8.*H9.*H10.*H11.*H12;
% convert the result to the spacial domain.
F_car=real(ifft2(FS_car)); 
% Crop the image to undo padding
F_car=F_car(1:size(car,1), 1:size(car,2));
%Display the blurred image
%figure, imshow(F_car,[])
figure;
colormap(gray)
imagesc(F_car)
title('Gaussian Notch Filter (New)')
% Move the origin of the transform to the center of the frequency rectangle.
Fc=fftshift(F);
Fcf=fftshift(FS_car);
% use abs to compute the magnitude and use log to brighten display
S1=log(1+abs(Fc)); 
S2=log(1+abs(Fcf));
%figure, imshow(S1,[])
%figure, imshow(S2,[])
figure;
colormap(gray)
imagesc(S2)
title('Gaussian New Spectrum')
