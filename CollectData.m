function [  ] = CollectData( cpu1, ram1, temperature1, temperature2,...
    UpTime, processes, threads, HddTransfers, networkDownload,...
    networkUpload, MaxRAM, filename, index  )
%CollectData Summary of this function goes here
%   Detailed explanation goes here

    timestamp = char(datetime);    
    UpTimeValue = UpTime.NextValue();

    UpDays = floor(UpTimeValue/3600/24);
    UpHours = floor((UpTimeValue/3600) - (UpDays*24));
    UpMins = floor((UpTimeValue/3600 - UpDays*24-UpHours)*60);
    UpSecs = floor(((UpTimeValue/3600 - UpDays*24-UpHours)*60-UpMins)*60);
    
    excelData=cell(1,12);

    excelData{1} = timestamp(1:11);
    excelData{2} = timestamp(13:20);
    excelData{3} = [num2str(UpDays) ':' num2str(UpHours) ':'...
        num2str(UpMins) ':' num2str(UpSecs)];
    excelData{4} = cpu1.NextValue();
    excelData{5} = MaxRAM - ram1.NextValue();
    excelData{6} = processes.NextValue();
    excelData{7} = threads.NextValue();
    excelData{8} = HddTransfers.NextValue();
    excelData{9} = networkDownload.NextValue();
    excelData{10} = networkUpload.NextValue();
    excelData{11} = temperature1.NextValue()-273;
    excelData{12} = temperature2.NextValue()-273;
    
    xlsRange = ['A' num2str(index+1) ':L' num2str(index+1)];
    
    xlswrite(filename,excelData,xlsRange);
end