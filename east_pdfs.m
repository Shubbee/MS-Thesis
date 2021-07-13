clear all
% load 'east_VEL'

load vel_filtered 
Z=FilterZ;

names=fieldnames(Z);

for i=[3,5,7]
    figure (2*i-1)
    
       X=histogram(Z.(names{i}));
       title(string(names{i}))
       xlabel('Value') 
       ylabel('Count')
       
       x1=X.BinEdges(1:end-1)+(X.BinWidth)/2;
       y1=(X.BinCounts/X.BinWidth)./length(Z.vel_mean);
           figure(2*i)
           plot(x1,y1)
           title(string(names{i}))
           xlabel('Value') 
           ylabel('Probability ')
           
end
