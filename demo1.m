clc;clear;close all

I=imread('data1/16.png');   
I_hf=HF(I);                          %homomorphic filtering
img_dehazed=dehaze(I_hf);           %dehazing
figure;imshow([I,img_dehazed],[]);



