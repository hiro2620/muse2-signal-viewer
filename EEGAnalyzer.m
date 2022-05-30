classdef EEGAnalyzer < handle
    %EEGANALYZER
    %

    properties
        Inlet;
        PRaw;
        PFft;
        FFT;
        Fig;
        DataStack = [];

    end

    methods
        function obj = EEGAnalyzer(inlet,fftHandlerInstance)
            %EEGANALYZER Construct an instance of this class
            %   Detailed explanation goes here
            obj.Inlet = inlet;
%             obj.PHRaw = SubplotHandler(subplot(2,2,1), 'Average of Raw Data', 'time[ms]', 'EEG[mV]', [-4 4]);
%             obj.PHFft = SubplotHandler(subplot(2,2,2), 'Single-Sided Amplitude Spectrum', 'f[Hz]', '|P1(f)|', [0 2]);
            obj.Fig = figure;
            obj.PRaw = SubplotHandler( ...
                obj.Fig, ...
                [2,1,1], ...
                'Raw Data', ...
                'time[ms]', ...
                'EEG[mV]', ...
                [0 500] ...
            );
            obj.PFft = SubplotHandler( ...
                obj.Fig, ...
                [2,1,2], ...
                'Single-Sided Amplitude Spectrum', ...
                'f[Hz]', ...
                '|P1(f)|', ...
                [0 10] ...
            );
            obj.FFT = fftHandlerInstance;
        end

        function tearDown(obj)
            %METHOD1 tear down
            %   Detailed explanation goes here
            obj.Inlet.close_stream();
            close(obj.Fig);
        end

        function analyzePeriod(obj, duration)
            timerId = tic;
            [vec,ts] = obj.Inlet.pull_chunk();
%             disp(size(vec));
%             disp(size(ts));
            if size(ts,2) == 0
                return
            end
%             disp(size(vec));
%             disp(size(ts));
            vec(5,:) = [];
%             data = transpose(mean(vec,2));
            data = mean(vec,1);
            obj.DataStack = horzcat(obj.DataStack, data);
            if length(obj.DataStack) > obj.FFT.SampleCnt
                obj.DataStack = obj.DataStack(1, length(obj.DataStack)-obj.FFT.SampleCnt+1:length(obj.DataStack));
            end

            obj.PRaw.update(ts, data);

            % FFT
            if length(obj.DataStack) == obj.FFT.SampleCnt
                [f, P1] = obj.FFT.getSpectrum(obj.DataStack);
%                 obj.PHFft.update(f,P1);
                obj.PFft.update(f, P1);
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