clc;
clear;

filename = 'CPU_Log.xlsx';
MaxRAM = 8192; %MBytes

%https://www.experts-exchange.com/questions/26646616/C-get-current-CPU-usage-Memory-usage-Disk-usage.html
cpu1 = System.Diagnostics.PerformanceCounter;
cpu1.CategoryName = 'Processor';
cpu1.CounterName = '% Processor Time';
cpu1.InstanceName = '_Total';

ram1 = System.Diagnostics.PerformanceCounter('Memory','Available MBytes');
temperature1 = System.Diagnostics.PerformanceCounter('Thermal Zone Information','Temperature','\_TZ.TZS0');
temperature2 = System.Diagnostics.PerformanceCounter('Thermal Zone Information','Temperature','\_TZ.TZS1');
UpTime = System.Diagnostics.PerformanceCounter('System','System Up Time');
processes = System.Diagnostics.PerformanceCounter('System','Processes');
threads = System.Diagnostics.PerformanceCounter('System','Threads');
HddTransfers = System.Diagnostics.PerformanceCounter('PhysicalDisk','Disk Bytes/sec','_Total');
networkDownload = System.Diagnostics.PerformanceCounter('Network Interface','Bytes Received/sec','Intel[R] Dual Band Wireless-AC 3160');
networkUpload = System.Diagnostics.PerformanceCounter('Network Interface','Bytes Sent/sec','Intel[R] Dual Band Wireless-AC 3160');

excelData=cell(1,12);
garbage1=UpTime.NextValue();
garbage2=HddTransfers.NextValue();
garbage3=networkDownload.NextValue();
garbage4=networkUpload.NextValue();
garbage5=cpu1.NextValue();

for i=1:10
    timestamp = char(datetime);
%     disp(cpu1.NextValue());
%     disp(temperature1.NextValue());
%     disp(temperature2.NextValue());
%     disp(UpTime.NextValue());
%     disp(processes.NextValue());
%     disp(threads.NextValue());
%     disp(HddTransfers.NextValue());
%     disp('*****************************************');
    
    UpTimeValue = UpTime.NextValue();

    UpDays = floor(UpTimeValue/3600/24);
    UpHours = floor((UpTimeValue/3600) - (UpDays*24));
    UpMins = floor((UpTimeValue/3600 - UpDays*24-UpHours)*60);
    UpSecs = floor(((UpTimeValue/3600 - UpDays*24-UpHours)*60-UpMins)*60);

    excelData{1} = timestamp(1:11);
    excelData{2} = timestamp(13:20);
    excelData{3} = [num2str(UpDays) ':' num2str(UpHours) ':' num2str(UpMins) ':' num2str(UpSecs)];
    excelData{4} = cpu1.NextValue();
    excelData{5} = ram1.NextValue();
    excelData{6} = processes.NextValue();
    excelData{7} = threads.NextValue();
    excelData{8} = HddTransfers.NextValue();
    excelData{9} = networkDownload.NextValue();
    excelData{10} = networkUpload.NextValue();
    excelData{11} = temperature1.NextValue();
    excelData{12} = temperature2.NextValue();
    
    xlsRange = ['A' num2str(i+1) ':L' num2str(i+1)];
    
    xlswrite(filename,excelData,xlsRange);
    pause(1);
end;