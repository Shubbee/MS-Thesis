clear all

load east_VEL

A=find(Z.vel_mean>.5);
names=fieldnames(Z);
FilteredZ=zeros(10,length(A));

for i=1:10
    
    Y=Z.(string(names{i}));
    FilteredZ=Y(A);
    FilterZ.(string(names{i}))=FilteredZ;
end
