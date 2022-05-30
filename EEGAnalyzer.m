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
            obj.Fig = figure;
            obj.PRaw = SubplotHandler( ...
                obj.Fig, ...
                [2,1,1], ...
                'Raw Data', ...
                'time[ms]', ...
                'EEG[mV]', ...
                [0 0], ...
                [0 500] ...
            );
            obj.PFft = SubplotHandler( ...
                obj.Fig, ...
                [2,1,2], ...
                'Single-Sided Amplitude Spectrum', ...
                'f[Hz]', ...
                '|P1(f)|', ...
                [0 100], ...
                [0 120] ...
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
            if size(ts,2) == 0
                pause(duration);
                return
            end
%             disp(size(vec));
%             disp(size(ts));
            vec(5,:) = [];
            data = mean(vec,1);
            obj.DataStack = horzcat(obj.DataStack, data);

            dslen = size(obj.DataStack, 2);
            if dslen > obj.FFT.SampleCnt
                obj.DataStack = obj.DataStack(1, dslen-obj.FFT.SampleCnt+1:dslen);
            end

            obj.PRaw.update(ts, data);

            % FFT
            if size(obj.DataStack, 2) == obj.FFT.SampleCnt
                [f, P1] = obj.FFT.getSpectrum(obj.DataStack);
                obj.PFft.update(f, P1);
            end
            drawnow;

            elapsed = toc(timerId);
            if duration > elapsed
                pause(duration - elapsed);
            else
                warning('analyze took too long time. (%.3fs)', elapsed);
            end
        end
    end
end