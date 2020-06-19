bpath = 'X:\Ben\patchclamp\pcdh\09Jul19\';

for ii = 1:25
    load([bpath, '070919_cell7_tau.09Jul19.S1.E',num2str(ii),'.mat']);
    indiv_trace(ii,:) = traceData(10000:12000); 
  %figure
  plot (traceData);
end
mean_trace = mean(indiv_trace);


%% plotting
figure(4)
plot(indiv_trace', 'b'); hold on
plot(mean_trace, 'k', 'LineWidth', 3)

[val, idx] = min(mean_trace);

sliced_mean_trace = mean_trace(idx:idx+1000);
time = (0:1000)/1e1; % in ms

 
%  xlabel('')
% ylabel('pA')
% ylim ([-80 -50])
% ylim auto
xlim ([0 2000])
% title ('tau')
%  
%  
 

%% Fiting
[xData, yData] = prepareCurveData(time, sliced_mean_trace);

% Set up fittype and options.
ft = fittype( 'exp2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [-8.21595294491718 -0.0475591431832565 -81.0733526394519 5.51707258198172e-05];

% Fit model to data.
[fitresult, gof] = fit(xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'double exp fit' );
h = plot( fitresult, xData, yData );
legend( h, 'data', 'fit', 'Location', 'NorthEast' );
xlabel time
ylabel mmtr
grid on

%% calculating membrane time constant
mem_tau = -1/fitresult.b % in ms


