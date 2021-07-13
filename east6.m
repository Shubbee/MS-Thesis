%clear all

% Reading Data:
load east_data6;
lb=1;
ub=250000;
data=data6(1:ub,:);

load tideinfo;
lat=zeros(lb,ub);
lon=zeros(lb,ub);

% Find bad data
  ind=find(cell2mat(data(1,5:14))~=-999.999)';
  ff=f(ind);
  name_input=name(ind,:);

% Segregation of variables within data and Remove bad data:

 for a=1:size(data,1)
       
       amp(1,:)=cell2mat(data(a,4+ind));
%        phase(a,:)=cell2mat(data(a,14+ind));
       lat(a)=data{a,3}';
       lon(a)=data{a,2}';

 end
 
% Define zeros array
  zer=zeros(size(amp));
  
%% TIDE HEIGHTS:


% %Define tidal constituent input
%   tidecon=zeros(size(data,1));
%  
%   for a=1:size(data,1)       
%       tidecon(a)={[amp.series(a,1:end)' zer(a,1:end)' phase.series(a,1:end)' zer(a,1:end)']};
%   end
% 
tyr_nonleap(1,:)=(datenum((2015),1,1):1/24/2:datenum((2016),1,1))';   
% 
% %Create time series
% 
%     for j=1:size(data,1)       % For all location: lats
%                 
%         %Tidal prediction    
%         z_pred_nonleap(j,:) =t_predic(tyr_nonleap,name_input,ff,cell2mat(tidecon(j)),'latitude',lat(j));
%         
%         %Stats for non leap year
%         z_mean(j)= mean(z_pred_nonleap(j,:));
%         z_mode(j)= mode(z_pred_nonleap(j,:));
%         z_median(j)=median(z_pred_nonleap(j,:));
%         z_std(j)=std(z_pred_nonleap(j,:));
%         z_max(j)=max(z_pred_nonleap(j,:));
%         z_1pEx(j)=prctile(z_pred_nonleap(j,:),99);
%         z_10pEx(j)=prctile(z_pred_nonleap(j,:),90);
%         
%     end
   

%% VELOCITY STATISTICS:

%Create velocity time series:

% vel_mean =zeros(1,ub);
% vel_mode= zeros(1,ub);
% vel_median=zeros(1,ub);
% vel_std=zeros(1,ub);
% vel_max=zeros(1,ub);
% vel_1pEx=zeros(1,ub);
% vel_10pEx=zeros(1,ub);

power_density=zeros(1,ub);

  for j=1:ub
    
    %Assign velocity constituents from the database:
    major(1,:)=cell2mat(data(j,24+ind))';
    minor(1,:)=cell2mat(data(j,34+ind))';
    inc_series(1,:)=data(j,44+ind)';
    pha_u_series(1,:)=cell2mat(data(j,54+ind))';   
      
   %Define tidal constituent input
   tidecon_v(1)={[major(1,1:end)' zer(1,1:end)' minor(1,1:end)' zer(1,1:end)' cell2mat(inc_series(1,:))' zer(1,1:end)' pha_u_series(1,1:end)' zer(1,1:end)']}; 
   v_pred(1,:)=t_predic(tyr_nonleap,name_input,ff,cell2mat(tidecon_v(1)),'latitude',lat(j)); 
        u(1,:)=real(v_pred(1,:));  
        v(1,:)=imag(v_pred(1,:));  
        vel(1,:)=(abs(u(1,:)).^2+abs(v(1,:)).^2).^.5;
                 
        %Velocity Stats for non leap year:
        
%         vel_mean(j)= mean(vel(1,:));
%         vel_mode(j)= mode(vel(1,:));
%         vel_median(j)=median(vel(1,:));
%         vel_std(j)=std(vel(1,:));
%         vel_max(j)=max(vel(1,:));
%         vel_1pEx(j)=prctile(vel(1,:),99);
%         vel_10pEx(j)=prctile(vel(1,:),90);
        rho=1020;
        vel_cubed(1,:)=(vel(1,:)).^3;
        power(1,:)=.5*rho.*vel_cubed(1,:);
        power_density(j)=mean(power(1,:));
      
  end

% Data Visualisation:
    
    %Mean Velocity Scatterplot
%     figure(6)
%     pointsize=10;
%     scatter(lon,lat,pointsize,vel_mean(1,:),'filled');
%     legend()
%     xlabel('longitude')
%     ylabel('latitude')
    
%     %Mode
%     figure(2)
%     pointsize=50;
%     scatter(lon,lat,pointsize,vel_mode(1,:),'filled')
%     legend()
%     xlabel('longitude')
%     ylabel('latitude')
%     
%     %Median
%     figure(3)
%     pointsize=50;
%     scatter(lon,lat,pointsize,vel_median(1,:),'filled')
%     legend()
%     xlabel('longitude')
%     ylabel('latitude')
%     
%     %Max
%     figure(4)
%     pointsize=50;
%     scatter(lon,lat,pointsize,vel_max(1,:),'filled')
%     legend()
%     xlabel('longitude')
%     ylabel('latitude')
%     
%     %vel_1pEx
%     figure(5)
%     pointsize=50;
%     scatter(lon,lat,pointsize,vel_1pEx(1,:),'filled')
%     legend()
%     xlabel('longitude')
%     ylabel('latitude')
%    
%     %vel_10pEx
%     figure(6)
%     pointsize=50;
%     scatter(lon,lat,pointsize,vel_10pEx(1,:),'filled')
%     legend()
%     xlabel('longitude')
%     ylabel('latitude')
%     
%     %vel_std
%     figure(7)
%     pointsize=50;
%     scatter(lon,lat,pointsize,vel_std(1,:),'filled')
%     legend()
%     xlabel('longitude')
%     ylabel('latitude')
%     
    %power_density
    figure(8)
    pointsize=50;
    scatter(lon,lat,pointsize,power_density(1,:),'filled')
    legend()
    xlabel('longitude')
    ylabel('latitude')



