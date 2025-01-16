clc
clear

for i = 1:20
    file{i} = strcat("C:\Users\lv299\OneDrive\STF_Paper\Subtropical-Front-Modeling-Code\Step1\OISST_Raw\oisst-avhrr-v02r01_",num2str(2003+i),".nc");
end

file20201231 =  "C:\Users\lv299\OneDrive\STF_Paper\Subtropical-Front-Modeling-Code\Step1\OISST_Raw\oisst-avhrr-v02r01.20201231.nc";

%%
lon = ncread(file{1},'lon');
lat = ncread(file{1},'lat');

%%
sst_04_19 = [];
    
for i = 1:16 
    sst_04_19 = cat(4, sst_04_19, ncread(file{i}, 'sst', [1,160,1,1],[Inf,82,1,Inf]))   ;
    disp(i)
end
%%
sst_21_23 = [];

for i = 18:20
    sst_21_23 = cat(4,sst_21_23, ncread(file{i}, 'sst', [1,160,1,1],[Inf,82,1,Inf]));
    disp(i)
end

sst_20 = cat(4, ncread(file{17}, 'sst', [1,160,1,1],[Inf,82,1,Inf]), ncread(file20201231, 'sst', [1,160,1,1],[Inf,82,1,Inf]));



%%
sst_04_23 = cat(4, sst_04_19, sst_20,sst_21_23);
sst_04_23_3d = squeeze(sst_04_23);

%%
lat_cut = ncread(file{1},'lat', [160],[82]);
timearray = datetime(2004,1,1):caldays(1):datetime(2023,12,31);
%%
time = linspace(1,7305,7305);
%%
file_output = "OISST_1_4Deg_daily.nc";

nccreate(file_output, 'sst', 'Dimensions',{'lon' 1440 'lat' 82 'time' 7305});
nccreate(file_output, 'lat', 'Dimensions', {'lat' 82});
nccreate(file_output, 'lon', 'Dimensions',{'lon', 1440});
nccreate(file_output, 'time', 'Dimensions',{'time' 7305});

ncwrite(file_output, 'lat', lat_cut);
ncwrite(file_output, 'lon', lon);
ncwrite(file_output, 'time', time);
ncwrite(file_output, 'sst', sst_04_23_3d);



