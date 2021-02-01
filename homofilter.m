function Ihmf_2=homofilter(I)
I = im2double(I);
I = log(1 + I);
M = 2*size(I,1) + 1;
N = 2*size(I,2) + 1;

sigma = 10;

[X, Y] = meshgrid(1:N,1:M);
centerX = ceil(N/2); 
centerY = ceil(M/2); 
gaussianNumerator = (X - centerX).^2 + (Y - centerY).^2;
H = exp(-gaussianNumerator./(2*sigma.^2));
H = 1 - H; 
H = fftshift(H);

If = fft2(I, M, N);
Iout = real(ifft2(H.*If));
Iout = Iout(1:size(I,1),1:size(I,2));
Ihmf_2 = exp(Iout) - 1;

% alpha = 0.09; 
% beta = 1.01;
% Hemphasis = alpha + beta*H;
% 
% If = fft2(I, M, N);
% Iout = real(ifft2(Hemphasis.*If));
% Iout = Iout(1:size(I,1),1:size(I,2));
% 
% Ihmf_2 = exp(Iout) - 1;