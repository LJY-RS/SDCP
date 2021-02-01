clc;clear;close all

I=imread('data2/21.png');
img_dehazed=dehaze(I);           %dehazing
figure;imshow([I,img_dehazed],[]);



