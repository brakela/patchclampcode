
filename = '081919_cell10_70mV.19Aug19.S1.E2'

% data = load (['/home/idl/Downloads/ben/', filename, '.mat']);
%data = load (['X:\Ben\patchclamp\pcdh\16Aug19\', filename, '.mat']);
data = load (['C:\Users\USER\Documents\ben\19Aug19\', filename, '.mat']);

[b,a] = butter(2, 2*[1, 500]/1e4, 'bandpass');
[bb,aa] = butter(2, 2*[59, 61]/1e4, 'stop');
[bbb,aaa] = butter(2, 2*[270, 290]/1e4, 'stop');
filt_trace = filtfilt(bbb, aaa, filtfilt(bb, aa, filtfilt(b,a, data.traceData(:, 1))));

figure(1)
time = (1 : length(filt_trace))/10;
plot(time, data.traceData(:, 1), 'b'); hold on
plot(time, filt_trace, 'k')
xlabel('time (ms)')
legend('raw', 'filtered')

%
 
%axis([0 60000 -50 100])




% Getting standard deviation of 1 s data
figure(2)
for ind= 0:59
    time=ind*1e4+1 : (ind+1)*1e4;
    plot(time/1e4, filt_trace(time));
    std(filt_trace(time))
%     techthresh_3= (mean(ans))*3
   techthresh_3_5= (mean(ans))*3.5
   % techthresh_4= (mean(ans))*4
    pause;
end
prompt = 'Enter the standard deviation: ';
std_thr = str2double(input(prompt,'s'));








% Detect events
events = find(filt_trace <= -std_thr);
event_ind = [1;find(diff(events)>1)];

figure(8)
time = (1 : length(filt_trace))/10; 
plot(time, filt_trace, 'k'); hold on
plot(events/10, filt_trace(events), 'r.')
xlabel('cleartime (ms)')
%axis([0 60000 -100 100])



axis([0 60000 -100 100])

% 
% 
% % 
% % figure(4)
% % event_info = [];
% % opts.Default = 'Yes';
% % opts.Interpreter = 'tex';
% % plotflag = 0; % 1 to plot or 0 not to plot
% % 
% % for ii = 1 : length(event_ind)-1
% %     inx = max(events(event_ind(ii)+1)-1e3, 1) : min(events(event_ind(ii+1))+1e3, length(filt_trace));
% %     tt = inx/10;
% %     sig = filt_trace(inx);
% % %     figure(4)
% %     clf
% %     plot(tt, sig, 'b'); hold on
% %     [min_val, col] = min(filt_trace(events(event_ind(ii))+1:events(event_ind(ii+1))));
% %     plot(time(events(event_ind(ii))+col), min_val, 'r.')
% %     plot(tt, -std_thr*ones(1,length(tt)), 'g')
% %     xlabel('time (ms)')
% %     
% %     quest = 'Is this an event?';
% %     answer = questdlg(quest,'Including event',...
% %                   'Yes','No', opts);
% %     if strcmp(answer, 'Yes') == 1
% %         ss = filt_trace(max(1, events(event_ind(ii))+col-20):events(event_ind(ii))+col);
% %         ind_min = find(ss<0.1*min_val);
% %         ind_max = find(ss>0.9*min_val);
% %         rise_time = (ind_max(end)-ind_min(1))/10;
% %         [fitres, gof] = exp_tau(filt_trace(events(event_ind(ii))+col:min(events(event_ind(ii))+col+1e3, length(filt_trace))), plotflag);
% %         event_info = [event_info; time(events(event_ind(ii))+col), min_val, rise_time, -fitres.a];
% %     end
% % 
% % end
% 
% % save(['/nas/data1/Ben/patchclamp/pcdh/20Aug19/', filename, 'event_info.mat'], 'event_info', 'event_ind')
% 
% save(['X:\Ben\patchclamp\pcdh\122118\', filename, 'event_ind.mat'], 'event_ind')
