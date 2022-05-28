classdef EEGAnalyzer < handle
    %EEGANALYZER
    %

    properties
        Inlet;
        PRaw;
        PFft;
        FFT;
        DataStack = [];

    end

    methods
        function obj = EEGAnalyzer(inlet,fftHandlerInstance)
            %EEGANALYZER Construct an instance of this class
            %   Detailed explanation goes here
            obj.Inlet = inlet;
%             obj.PHRaw = SubplotHandler(subplot(2,2,1), 'Average of Raw Data', 'time[ms]', 'EEG[mV]', [-4 4]);
%             obj.PHFft = SubplotHandler(subplot(2,2,2), 'Single-Sided Amplitude Spectrum', 'f[Hz]', '|P1(f)|', [0 2]);
            obj.PRaw = registerSubplot([2,1,1], 'Raw Data', 'time[ms]', 'EEG[mV]', [-5 5]);
            obj.PFft = registerSubplot([2,1,2], 'Single-Sided Amplitude Spectrum', 'f[Hz]', '|P1(f)|', [0 2]);
            obj.FFT = fftHandlerInstance;
        end

        function tearDown(obj)
            %METHOD1 tear down
            %   Detailed explanation goes here
            obj.Inlet.close_stream();
            close;
        end

        function analyzePeriod(obj, duration)
            timerId = tic;
            [vec,ts] = obj.Inlet.pull_chunk();
            if size(ts,1) == 0
                return
            end
            vec(:,5) = [];
            data = transpose(mean(vec,2));
            obj.DataStack = horzcat(obj.DataStack, data);
            if length(obj.DataStack) > obj.FFT.SampleCnt
                obj.DataStack = obj.DataStack(1, length(obj.DataStack)-obj.FFT.SampleCnt+1:length(obj.DataStack));
            end

            obj.PRaw.XData = ts;
            obj.PRaw.YData = data;

            % FFT
            if length(obj.DataStack) == obj.FFT.SampleCnt
                [f, P1] = obj.FFT.getSpectrum(obj.DataStack);
%                 obj.PHFft.update(f,P1);
                obj.PFft.XData = f;
                obj.PFft.YData = P1;
            end
            drawnow;

            elapsed = toc(timerId);
            if duration > elapsed
                pause(duration - elapsed);
            else
%                 warning('analyze took too long time. (%.3fs)', elapsed);
            end
        end
    end
end