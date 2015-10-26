Pin_Number = 4; 
a = arduino(); 
% a = my arduino in all places

a.configureDigitalPin(Pin_Number, 'Output'); 
for blink = 1:5
    a.writeDigitalPin(Pin_Number,1); 
    pause(1); 
    a.writeDigitalPin(Pin_Number,1); 
    pause(1); 
end 

a.configureAnalogPin(Pin_Number, 'Input'); 

% Initialize Variables
readings = 750;  
times = zeros(readings, 1); 
analogVoltageIn = zeros(readings, 1); 

% Initialize a figure and Axes
figure; 
hold on; 
ylim([0,5]); 
title('Analog Voltage vs. Time'); 
ylabel('Analog Voltage (Volts)');
xlabel('Time (seconds)'); 
scatterPlot = scatter(NaN(readings,1),NaN(readings,1),200,'.k'); 

% Record and Display the Analog Voltage Readings in Real-Time

tic;
for r = 1:readings
    times(r) = toc; 
    analogVoltageIn(r) = a.readVoltage(Pin_Number); 
    scatterPlot.xData(r) = times(r); 
    scatterPlot.YData(r) = analogVoltageIn(r); 
end 
