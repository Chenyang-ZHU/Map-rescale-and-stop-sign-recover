fileID = fopen('MapPointsSave.txt','r');
formatSpec = '%f';
sizeA = [3 Inf];
A = fscanf(fileID,formatSpec,sizeA);
A=A';
A=min(A,15);
figure
scatter3(A(:,1),A(:,2),A(:,3),'r.');