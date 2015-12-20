% IDEAL LPF MESH
HLPF_ideal=fftshift(lpfilter('ideal', 512, 512, 50));
figure, meshc(HLPF_ideal(1:10:512,1:10:512))
colormap([0 0 0])
axis off
grid off
axis([0 50 0 50 0 1])
%figure, imshow(HLPF_ideal)

% BUTTERWORTH LPF MESH
HLPF_btw=fftshift(lpfilter('btw', 512, 512, 50));
figure, meshc(HLPF_btw(1:10:512,1:10:512))
colormap([0 0 0])
axis off
grid off
axis([0 50 0 50 0 1])
%figure, imshow(HLPF_btw)

% GAUSSIAN LPF MESH
HLPF_gauss=fftshift(lpfilter('gaussian', 512, 512, 50));
figure, meshc(HLPF_gauss(1:10:512,1:10:512))
colormap([0 0 0])
axis off
grid off
axis([0 50 0 50 0 1])
%figure, imshow(HLPF_gauss)
