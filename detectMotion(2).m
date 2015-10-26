
    %% Motion Detection Function
% This function determines if motion is occurring in real-time. It may
% require calibration depending on environment lighting and what motion
% events you wish to capture.
% 
% * SPAN refers to the number of previous voltage measurements that will be
% analyzed to detect motion. The sample rate of the analog voltage pin is
% approximately 30-35 Hz, so 15 readings is approximately 1/2 a second.
% 
% * THRESHOLD refers to the minimum value for each calculated parameter for
% a span of readings that will be considered motion. The minimum voltage
% difference between analog voltage readings is 0.0049 Volts, so it is
% useful to relate the thresholds to this value.
    
    function motionValues = detectMotion(time,voltage)
        motionValues = zeros(length(time),3);
        
        % Halfspan
        halfspan = 7;
        
        % Thresholds
        stdThreshold = 3*.0049;
        diffThreshold = (halfspan*2+1)*.0049;
        slopeThreshold = .05;
        
        for rd = halfspan+1:length(voltage)-halfspan
            motionValues(rd,1) = std(voltage(rd-halfspan:rd+halfspan))/stdThreshold;
            motionValues(rd,2) = sum(abs(diff(voltage(rd-halfspan:rd+halfspan))))/diffThreshold;
            motionValues(rd,3) = abs(getSlope(time(rd-halfspan:rd+halfspan),voltage(rd-halfspan:rd+halfspan)))/slopeThreshold;
        end
    end
