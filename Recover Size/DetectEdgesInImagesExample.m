%% Detect Edges in Images
% This example shows how to detect edges in an image using both the Canny
% edge detector and the Sobel edge detector.
%%
% Read image and display it.

% Copyright 2015 The MathWorks, Inc.
load stopsign.mat;
figure
subplot(2,2,1);
imshow(stopsign);

%%
% Apply both the Sobel and Canny edge detectors to the image and display
% them for comparison.
signedge = edge(stopsign,'Sobel','horizontal');
clsignedge = bwareaopen(signedge, 50); % clear small object in image
subplot(2,2,3)
imshow(signedge);
subplot(2,2,4)
imshow(clsignedge)

label=stopsign(:,1);
for i=1:size(stopsign,1)
    Ind1=find(clsignedge(i,:)==1);
    if length(Ind1)>20
        label(i)=1;
    else
        label(i)=0;
    end
end
edgeInd=find(label==1);
UpedgeInd=min(edgeInd);
BotedgeInd=max(edgeInd);
SignImSize=BotedgeInd-UpedgeInd;





