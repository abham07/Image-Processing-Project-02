% IDEAL HPF MESH
HHPF_ideal=fftshift(hpfilter('ideal', 512, 512, 50));
figure, meshc(HHPF_ideal(1:10:512,1:10:512));
colormap([0 0 0]);
axis off;
grid off;
axis([0 50 0 50 0 1]);
%figure, imshow(HHPF_ideal);

% BUTTERWORTH HPF MESH
HHPF_btw=fftshift(hpfilter('btw', 512, 512, 50));
figure, meshc(HHPF_btw(1:10:512,1:10:512));
colormap([0 0 0]);
axis off;
grid off;
axis([0 50 0 50 0 1]);
%figure, imshow(HHPF_btw);

% GAUSSIAN HPF MESH
HHPF_gauss=fftshift(hpfilter('gaussian', 512, 512, 50));
figure, meshc(HHPF_gauss(1:10:512,1:10:512));
colormap([0 0 0]);
axis off;
grid off;
axis([0 50 0 50 0 1]);
%figure, imshow(HHPF_gauss);
