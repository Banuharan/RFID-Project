
%% RFID Attendance Post-Processing Script
% This script processes Simulink RFID attendance output



% Use the below 3 lines as input in command window
% TagData.time = [1 5 9 13 17];
% TagData.signals.values = [101; 102; 103; 101; 104];
% TagData.signals.dimensions = 1;

%% CASE 1: If you ran simulation using RUN button (AttendanceLog exists)
if exist('AttendanceLog', 'var')

    rawData = AttendanceLog;

%% CASE 2: If you ran simulation using out = sim('modelname')
elseif exist('out', 'var')

    % Change 'test123' to your To Workspace variable name if different
    rawData = squeeze(out.Attendancedata).';

else
    error('No attendance data found. Run the Simulink model first.');
end

%% Remove empty rows (time = 0 & ID = 0)
rawData = rawData(rawData(:,2) ~= 0, :);

%% Extract final attendance (Marked == 1)
FinalAttendance = rawData(rawData(:,4) == 1, :);

%% Convert to table
AttendanceTable = array2table(FinalAttendance, ...
    'VariableNames', {'Time','TagID','Valid','Marked'});

%% Display result
disp('FINAL ATTENDANCE LIST');
disp(AttendanceTable);
