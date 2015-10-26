
%% Lighting Condition Descriptor Function
% This function associates a descriptive string to the real-time lighting
% condition. By calibrating and adding to the basic lighting conditions
% used below, you can create a function that returns a useful assessment of
% the environment you are monitoring motion in.
    function lightStr = getLightingCondition(voltages)
        if voltages(end) > 4
            lightStr = 'Bright';
        elseif voltages(end) > 3
            lightStr = 'Dim';
        elseif voltages(end) > 1.5
            lightStr = 'Very Dim';
        else
            lightStr = 'Dark';
        end
    end
