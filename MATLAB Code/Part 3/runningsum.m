function runningsum(picture, LX, LY)

%read image
image = imread(picture);

%Convert from uint8 to double for math
image = double(image);
F = fft2(image);

%Fourier spectrum
Spectrum = sqrt( real(F).^2 + imag(F).^2 );
%Shift the spectrum, as per convention
SpectrumS = fftshift(Spectrum);
%Phase angle
Phase1 = atan2( imag(F), real(F) );

for x = 1: size(image,1)
    for y = 1: size(image,2)
        if (x <= LX + 1 && y <= LY + 1)
            RSFilter(x,y) = 255;
        else
            RSFilter(x,y) = 0; 
        end 
    end        
end

RSFilterFourier = fft2(RSFilter);
RSFilterSpectrum = sqrt( real(RSFilterFourier).^2 ...
    + imag(RSFilterFourier).^2 );

%Shift the spectrum, as per convention
RSFilterSpectrumS = fftshift(RSFilterSpectrum);

%Display Fourier Transform of Filter
figure;
colormap(gray);
imagesc(RSFilter);
title('Running Sum Filter');

figure;
colormap(gray);
imagesc(1+log10(RSFilterSpectrumS));
title('Running Sum Filter Spectrum');

%Phase angle
%Phase2 = atan2( imag(RSFilterFourier), real(RSFilterFourier) );
filtered_spectrumS = RSFilterSpectrumS.*SpectrumS;
filtered_spectrumSS = fftshift(filtered_spectrumS);

%Compute the values of Fourier Transform
F2 = filtered_spectrumSS.*exp(sqrt(-1)* Phase1 );
%Perform the inverse DFT
filtered_image = real(ifft2(F2));

figure;
colormap(gray);
imagesc(filtered_image);
title('Filtered Image');

figure;
colormap(gray);
imagesc(1+log10(filtered_spectrumSS));
title('Filtered Spectrum');

end
