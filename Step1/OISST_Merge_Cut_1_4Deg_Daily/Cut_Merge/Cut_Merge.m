clc
clear

for i = 1:20
    file{i} = strcat("C:\Users\lv299\OneDrive\STF_Paper\Subtropical-Front-Modeling-Code\Step1\OISST_Raw\oisst-avhrr-v02r01_",num2str(2003+i),".nc");
end

%%
lon = ncread(file{1},'lon');
lat = ncread(file{1},'lat');

%%
sst_04_23 = [];
    
for i = 1:20 
    sst_04_23 = cat(4, sst_04_23, ncread(file{i}, 'sst', [1,160,1,1],[Inf,82,1,Inf]))   ;
    disp(i)
end
%%
sst_04_23_3d = squeeze(sst_04_23);

%%
lat_cut = ncread(file{1},'lat', [160],[82]);
timearray = datetime(2004,1,1):caldays(1):datetime(2023,12,31);


%%
dates = [];
for i = 1:20
    dates = cat(1,dates, ncread(file{i},'time'));
end
%%
time_array = datetime(1978,1,1)+caldays(dates)