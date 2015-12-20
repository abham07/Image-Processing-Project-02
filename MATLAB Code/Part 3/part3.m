% BY: ABAD HAMEED
% ENGI4559: Digital Signals & Image Processcing
% PROF. R. Khoury
% DATE: November 26, 2015

%%%% PART 3: Running-Sum Filters %%%%

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
F = fft2(origImage);
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
title('Fourier Spectrum (Car)');
% Display Phase Angle
figure;
colormap(gray);
imagesc(Phase);
title('Phase Angle (Car)');

runningsum('car.png', 5, 5);
