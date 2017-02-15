% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

clc;
clear;

filename = 'CPU_Log.xlsx';
SecondsToLog = 300; %1 Hour
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

garbage1=UpTime.NextValue();
garbage2=HddTransfers.NextValue();
garbage3=networkDownload.NextValue();
garbage4=networkUpload.NextValue();
garbage5=cpu1.NextValue();

t = timer('Period', 1, 'TasksToExecute', SecondsToLog, 'ExecutionMode', 'fixedRate');
t.BusyMode = 'queue';
t.TimerFcn = @(~,~)CollectData( cpu1, ram1, temperature1, temperature2,...
        UpTime, processes, threads, HddTransfers, networkDownload,...
        networkUpload, MaxRAM, filename, t.TasksExecuted  );
start(t);