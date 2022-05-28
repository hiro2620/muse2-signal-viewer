classdef EEGAnalyzer < handle
    %EEGANALYZER
    %   
    
    properties
        Inlet;
        PHRaw;
    end
    
    methods
        function obj = EEGAnalyzer(inlet)
            %EEGANALYZER Construct an instance of this class
            %   Detailed explanation goes here
            obj.Inlet = inlet;
            obj.PHRaw = PlotHandler("raw data (avg)");
        end
        
        function tearDown(obj)
            %METHOD1 tear down
            %   Detailed explanation goes here
            obj.Inlet.close_stream()
        end
        
        function analyzePeriod(obj, duration)
            [vec,ts] = obj.Inlet.pull_chunk();
            if size(ts,1) == 0
                return
            end
            vec(:,5) = [];
%             disp(vec);
%             disp(ts);
            obj.PHRaw.update(ts,transpose(mean(vec,2)));
            pause(duration);
        end
    end
end

