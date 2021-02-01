function out = HF(I)

[m,n,c]=size(I);
I = padarray(I,[100,100],'symmetric');

r=I(:,:,1);
br=max(max(r));
ar=min(min(r));

g=I(:,:,2);
bg=max(max(g));
ag=min(min(g));

b=I(:,:,3);
bb=max(max(b));
ab=min(min(b));

rhmf=homofilter(r);
brhf=max(max(rhmf));
arhf=min(min(rhmf));

ghmf=homofilter(g);
bghf=max(max(ghmf));
aghf=min(min(ghmf));

bhmf=homofilter(b);
bbhf=max(max(bhmf));
abhf=min(min(bhmf));


rhmf=double(ar)+double(((br-ar)./(brhf-arhf)))*(rhmf-arhf);
ghmf=double(ag)+double(((bg-ag)./(bghf-aghf)))*(ghmf-aghf);
bhmf=double(ab)+double(((bb-ab)./(bbhf-abhf)))*(bhmf-abhf);


I_hf(:,:,1)=uint8(rhmf);
I_hf(:,:,2)=uint8(ghmf);
I_hf(:,:,3)=uint8(bhmf);
out=I_hf(101:m+100,101:n+100,:);