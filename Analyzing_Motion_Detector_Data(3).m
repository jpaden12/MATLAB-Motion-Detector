

    
function Analyze_Motion_Detector_Data(sensorTime,analogVoltage)


%% Use post-recording algorithms to detect motion
% Using the complete set of recorded data, these algorithms look at past
% and future readings to determine if the current reading indicates motion.

figure;
hold on;
ylim([0,5]);
title('Post-Recording Motion Detection');
ylabel('Analog Voltage (Volts)');
xlabel('Time (seconds)');
scatterPlot = scatter(sensorTime,analogVoltage,46,zeros(length(sensorTime),3),'.');

halfspan = 7;
detectorResults = zeros(length(sensorTime),3);

% Apply various motion detection methods
StandardDeviationMethod(sensorTime,analogVoltage);
DifferenceMethod(sensorTime,analogVoltage);
SlopeMethod(sensorTime,analogVoltage);

% Calculate an overall motion number for each point. The motion number for
% a point contains information regarding which calculation methods showed
% motion at that point.
motionNumber = sum(detectorResults.*repmat([1,2,4],length(sensorTime),1),2);

% Display useful information regarding the motion numbers
for pt = 1:length(sensorTime)
    switch motionNumber(pt)
        case 0
            % No Motion (marker remains black)
        case {1,2,3}
            % Standard Deviation and/or Difference Motion, No Slope Motion
            scatterPlot.CData(pt,:) = [0,1,1]; % set marker to cyan
        case 4
            % Only Slope Motion
            scatterPlot.CData(pt,:) = [0,1,0]; % set marker to green
        otherwise
            % Any other combination of Motion detected
            scatterPlot.CData(pt,:) = [1,0,0]; % set marker to red
    end
end


%% Standard Deviation method
    function StandardDeviationMethod(time,voltage)
        motionValue = zeros(length(time),1);
        threshold = 3*.0049;
        for r = halfspan+1:length(voltage)-halfspan
            motionValue(r) = std(voltage(r-halfspan:r+halfspan))/threshold;
            detectorResults(r,1) = motionValue(r)>1;
        end
    end


%% Difference method
    function DifferenceMethod(time,voltage)
        motionValue = zeros(length(time),1);
        threshold = (halfspan*2+1)*.0049;
        for r = halfspan+1:length(voltage)-halfspan
            motionValue(r) = sum(abs(diff(voltage(r-halfspan:r+halfspan))))/threshold;
            detectorResults(r,2) = motionValue(r)>1;
        end
    end


%% Slope method
    function SlopeMethod(time,voltage)
        motionValue = zeros(length(time),1);
        threshold = .05;
        for r = halfspan+1:length(voltage)-halfspan
            motionValue(r) = abs(getSlope(time(r-halfspan:r+halfspan),voltage(r-halfspan:r+halfspan)))/threshold;
            detectorResults(r,3) = motionValue(r)>1;
        end
    end


end

    
