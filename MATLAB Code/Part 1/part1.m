% BY: ABAD HAMEED
% ENGI4559: Digital Signals & Image Processcing
% PROF. R. Khoury
% DATE: November 26, 2015

%%%% PART 1: Lowpass & Highpass Filters %%%%

% Read original image
imagereal = imread('lenna.png');
% Display Original Image
figure;
colormap(gray);
imagesc(imagereal)
title('Original Image (Lenna)');

% Convert from uint8 to double for math
imagereal = double(imagereal);
% Fourier transform (inverse would be ifft2(F))
F = fft2(imagereal);
% Fourier spectrum
Spectrum = sqrt( real(F).^2 + imag(F).^2 );
% Shift the spectrum, as per convention
SpectrumS = fftshift(Spectrum);
% Phase angle
Phase = atan2( imag(F), real(F) );
% Display Fourier Spectrum
figure;
colormap(gray);
imagesc(1+log10(SpectrumS))
title('Fourier Spectrum (Lenna)');
% Display Phase Angle
figure;
colormap(gray);
imagesc(Phase);
title('Phase Angle (Lenna)');

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

% LOW-PASS FILTER APPLICATION
LPF=imread('lenna.png');
%Determine good padding for Fourier transform
PQ = paddedsize(size(LPF));
%Create an Ideal Lowpass filter 5% the width of the Fourier transform
%D1 = PQ(1);   % Test to see D1 = one side length of image (eg. 1024 of padded image)
D0 = 0.05*PQ(1);
%H = lpfilter('ideal', PQ(1), PQ(2), D0);
%H = lpfilter('btw', PQ(1), PQ(2), D0);
H = lpfilter('gaussian', PQ(1), PQ(2), D0);
% Calculate the discrete Fourier transform of the image
LPF_DFT=fft2(double(LPF),size(H,1),size(H,2));
% Apply the lowpass filter to the Fourier spectrum of the image
LPFS_lenna = H.*LPF_DFT;
% convert the result to the spacial domain.
LPF_lenna=real(ifft2(LPFS_lenna)); 
% Crop the image to undo padding
LPF_lenna=LPF_lenna(1:size(LPF,1), 1:size(LPF,2));
%Display the blurred image
%figure, imshow(LPF_lenna, [])
figure;
colormap(gray);
imagesc(LPF_lenna);
%imshow(LPF_lenna, []);
title('Gaussian Low-Pass Filter');
% REDUCED IMAGE FOR IDEAL LPF EXPERIMENT
%lenna_reduced=imresize(LPF_lenna, 0.2);
%figure;
%colormap(gray);
%imagesc(lenna_reduced);
%title('Reduced LPF Image');

%idealfilter('lenna.png', 51.2);
%bandpass('lenna.png', 51.2);

% HIGH-PASS FILTER APPLICATION
HPF=imread('lenna.png');
%Determine good padding for Fourier transform
PQ = paddedsize(size(HPF));
%Create an Ideal Lowpass filter 5% the width of the Fourier transform
%D1 = PQ(1);   % Test to see D1 = one side length of image (eg. 1024 of padded image)
D0 = 0.05*PQ(1);
%H = hpfilter('ideal', PQ(1), PQ(2), D0);
%H = hpfilter('btw', PQ(1), PQ(2), D0);
H = hpfilter('gaussian', PQ(1), PQ(2), D0);
% Calculate the discrete Fourier transform of the image
HPF_DFT=fft2(double(HPF),size(H,1),size(H,2));
% Apply the highpass filter to the Fourier spectrum of the image
HPFS_lenna = H.*HPF_DFT;
% convert the result to the spacial domain.
HPF_lenna=real(ifft2(HPFS_lenna)); 
% Crop the image to undo padding
HPF_lenna=HPF_lenna(1:size(HPF,1), 1:size(HPF,2));
%Display the blurred image
%figure, imshow(LPF_lenna, [])
figure;
colormap(gray);
imagesc(HPF_lenna);
title('Gaussian High-Pass Filter');

subGaussian = imagereal + HPF_lenna;
figure;
colormap(gray);
imagesc(subGaussian);
title('Sharp Image (Original + GHPF)');
% REDUCED IMAGE FOR IDEAL HPF EXPERIMENT
%lenna_reduced=imresize(subGaussian, 0.4);
%figure;
%colormap(gray);
%imagesc(lenna_reduced);
%title('Reduced HPF Image');
