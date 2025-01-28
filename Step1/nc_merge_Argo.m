clc
clear

%%
file = "C:\Users\lv299\OneDrive\STF_Paper\Subtropical-Front-Modeling-Code\Step1\Argo_Raw\RG_ArgoClim_Temperature_2019.nc";
CLIMATOLOGY = ncread(file,"ARGO_TEMPERATURE_MEAN");
sstlong = ncread(file, "ARGO_TEMPERATURE_ANOMALY")+CLIMATOLOGY;
%%
lon = ncread(file, "LONGITUDE");
lat = ncread(file, "LATITUDE");
pres = ncread(file, "PRESSURE");
time = linspace(1,240,240);
%%
[~, zero_index] = min(abs(lon - 360));
lon = circshift(lon, -zero_index);
lon_new = mod(lon - 360, 360);

sstlong = circshift(sstlong, -zero_index, 1);



%%
test = sst19_23(:,:,8,11);



%%
fileList = {};
for i = 1:5
    for j = 1:12
        if j < 10
    fileList{j+(i-1)*12} = strcat("C:\Users\lv299\OneDrive\STF_Paper\Subtropical-Front-Modeling-Code\Step1\Argo_Raw\RG_ArgoClim_",num2str(2018+i),"0",num2str(j),"_2019.nc");
        disp(i)
        else if j >9
    fileList{j+(i-1)*12} = strcat("C:\Users\lv299\OneDrive\STF_Paper\Subtropical-Front-Modeling-Code\Step1\Argo_Raw\RG_ArgoClim_",num2str(2018+i),num2str(j),"_2019.nc");        
    end
    end
end
end
%%

for i = 1:60
    sst19_23(:,:,:,i) = ncread(fileList{i},"ARGO_TEMPERATURE_ANOMALY") + CLIMATOLOGY;
    disp(i)
end
sst19_23 = circshift(sst19_23, -zero_index, 1);

%%
sst = cat(4,sstlong,sst19_23);

%% 
filename = "Argo_Merge_04_23_1_Deg.nc";

nccreate(filename,'sst','Dimensions',{'lon' 360 'lat' 145 'pres' 58 'time' 240});
nccreate(filename,'lat','Dimensions',{'lat' 145});
nccreate(filename,'lon','Dimensions',{'lon' 360});
nccreate(filename,'pres','Dimensions',{'pres' 58});
nccreate(filename,'time','Dimensions',{'time' 240});
ncwrite(filename,'lat',lat);
ncwrite(filename,'lon',lon_new);
ncwrite(filename,'sst',sst);
ncwrite(filename,'time',time);
ncwrite(filename,'pres',pres);
ncdisp(filename);

