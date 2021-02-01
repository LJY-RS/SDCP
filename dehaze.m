function im_dehaze=dehaze(im)

rr = 15;
kk = 0.95;

RGB = double(im);            
dark=min(RGB,[],3);                         % dark channel
dark = minfilt2(dark, [15,15]);

A = airlight(RGB, dark);            % estimate atmospheric light

t = transmission(RGB, A, kk, rr);   % estimate transmission 
RGB_out = rmvove_haze(RGB,A,t);                % remove haze
im_dehaze=uint8(RGB_out);

im_dehaze=double(im_dehaze)/255;
R=im_dehaze(:,:,1);
G=im_dehaze(:,:,2);
B=im_dehaze(:,:,3);
percent=0.001;
%%
Image_out(:,:,1)=Auto_Tune(R, percent);
Image_out(:,:,2)=Auto_Tune(G, percent);
Image_out(:,:,3)=Auto_Tune(B, percent);

Image_out=Image_out.^0.8;
Image_out=uint8(Image_out*255);
im_dehaze=Image_out;



function t = transmission(RGB,A,k,r)

A = double(A);
R = RGB(:,:,1)/A(1);G = RGB(:,:,2)/A(2);B = RGB(:,:,3)/A(3);

I=min(RGB,[],3);
[m,n,c] = size(RGB);

N = boxfilter(ones(m,n),r);
u_r = boxfilter(R,r)./N;
u_g = boxfilter(G,r)./N;
u_b = boxfilter(B,r)./N;

Rs2=(R-u_r).^2;
Gs2=(G-u_g).^2;
Bs2=(B-u_b).^2;

s_r2=boxfilter(Rs2,r)./N;
s_g2=boxfilter(Gs2,r)./N;
s_b2=boxfilter(Bs2,r)./N;

sigma=sqrt((s_r2+s_g2+s_b2)./3);
mine = min(min(u_r-sigma,u_g-sigma),u_b-sigma);

t = 1-k*mine;
t(t>0.95) = 0.95; t(t<0.1) = 0.1;
t = guidedfilter(I,t,r,0.001);


function J = rmvove_haze(I,A,t)

J(:,:,1) = (I(:,:,1) - A(1))./t + A(1);
J(:,:,2) = (I(:,:,2) - A(2))./t + A(2);
J(:,:,3) = (I(:,:,3) - A(3))./t + A(3);

J(J>255)=255;
J(J<0)=0;



