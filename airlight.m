function A = airlight(im, dark)

darkord = sort(dark(:),'descend');

num_pixels = ceil(0.001*length(darkord));
num_pixels     = min(num_pixels,10);
num_pixels	   = max(num_pixels,50);

threshold = darkord(num_pixels);

mask = dark >= threshold;

for c = 1:size(im,3)
    channel = im(:,:,c);
    candidates(:,c) = channel(mask);
    
end

candidatesI = 0.299*candidates(:,1) + 0.587*candidates(:,2) + 0.114*candidates(:,3);
[maxv,idx] = max(candidatesI);
A = candidates(idx,:);