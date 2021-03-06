%% CMU-RI-Navlab: Recover real size of Stop Sign
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This project is conducted by Chenyang Zhu(chenyangcmu@gmail.com) under
% the instructions of Dr. Christoph Mertz. We are trying to recover the
% real size of stop signs form the video frames captured by a smartphone
% inside a car.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We will use ORB_SLAM to generate the 3D map, getting a 3D map points file. 
% This file will be input in this script.
% Add indexes for each Mappoint
% Give the keypoints the same index with their matching Mappoint
% Text file: the data part should have the same col num, which is easy to
% operate
% Mappointmatch format: ['Frame num, point num, Image index, timestamp, feature index, x, y']
%% Input: provide the location of sign in the image and camera parameters
% f: focal length;
% signpose: sign location in image;
% [xl,yl]: bounding box size which segments out the sign;
% scale: predicted slam_map scale, comuputed by the rescaling part
f=1200;
scale=36.5173141711;




%% Read all 3D point and 2D features
% Read data from txt file
% 3D points
fileID = fopen('Data1/MapPointsSave3.txt');
A = textscan(fileID,'%s %f %f %f',4,'Delimiter',':');
cf=double(A{2}); % current frame timestamp
cameracenterinW=[A{1,2}(4),A{1,3}(4),A{1,4}(4)];% camer center in world coordinate
B = textscan(fileID,'%d %d %f %f %f %f %f');
fclose(fileID);
Mappointmatch=[double(B{1}),double(B{2}),double(B{3}),double(B{4}),double(B{5}),double(B{6}),double(B{7})];
Map3DInd=find(Mappointmatch(:,6)==0);% all 3D map points index
Map3Dpoint=Mappointmatch(Map3DInd,:);
% 2D keypoints
currentframe=imread('frames/20170927141259704.png');
cfInd=find(Mappointmatch(:,4)==cf(3)); % All index of points viewed in current frame
cfkeypoint=Mappointmatch(cfInd,:); % current frame keypoints
figure
imshow(currentframe);
hold on;

%% Without detection input, handly specify stop sign bounding box
% Actually, in usage, its also not fussy to handly select the bounding box.
rect = getrect;
xmin=rect(1);
xmax=xmin+rect(3);
ymin=rect(2);
ymax=ymin+rect(4);
stopsign=currentframe(ymin:ymax,xmin:xmax);

%% Find 3D points of stop sign and distance between cc and sign
% find the keypoints contained in bounding box
xInd=find(xmin<cfkeypoint(:,6) & cfkeypoint(:,6)<xmax);
ycoor=cfkeypoint(xInd,:);
Ind=find(ymin<ycoor(:,7) & ycoor(:,7)<ymax);
signkey=ycoor(Ind,:); % 2D points of stop sign
plot(ycoor(Ind,6),ycoor(Ind,7),'r+');

sign3Dpoint=Map3Dpoint(signkey(:,2),:); % 3D points of stop sign
%figure
%scatter3(sign3Dpoint(:,3),sign3Dpoint(:,4),sign3Dpoint(:,5),'r.');

sign3Dmean=mean(sign3Dpoint);
disinW=sign3Dmean(5);
disccinW=cameracenterinW(3);
dis=disinW-disccinW;

%% Edge Detection: find the sign's pixel size
figure 
subplot(1,3,1)
imshow(stopsign);
signedge = edge(stopsign,'Sobel','horizontal');% edge detection
clsignedge = bwareaopen(signedge, 50); % clear small object in image

subplot(1,3,2)
imshow(signedge);
subplot(1,3,3)
imshow(clsignedge)

label=stopsign(:,1); %possible edge line position
for i=1:size(stopsign,1)
    Ind1=find(clsignedge(i,:)==1);
    if length(Ind1)>15 % find points more than 20, define as edge
        label(i)=1;
    else
        label(i)=0;
    end
end

edgeInd=find(label==1);
UpedgeInd=min(edgeInd);
BotedgeInd=max(edgeInd);
SignImSize=BotedgeInd-UpedgeInd;

%% Recover real size of sign
% Recover from triangulation
signsize=scale*dis*SignImSize/f








