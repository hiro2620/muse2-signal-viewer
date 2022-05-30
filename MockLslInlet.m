classdef MockLslInlet < handle
    %MOCLSLINLET Summary of this class goes here
    %   Detailed explanation goes here

    properties
        SamplingInterval;
        LastRequestedTime = 0;
        StartTime;
    end

    methods
        function obj = MockLslInlet(samplingRate)
            %MOCLSLINLET Construct an instance of this class
            %   Detailed explanation goes here
            obj.SamplingInterval = 1000 / samplingRate;
        end

        function z = wave(~, t)
%             z = sin(10*t) + 2*sin(20*t) + sin(30*t) + 2*sin(50*t) + sin(70*t);
            z = 50 * (sin(2*pi*10*t) + 2*sin(2*pi*20*t) + sin(2*pi*30*t) + 2*sin(2*pi*50*t) + sin(2*pi*70*t) + 1.5 * (rand-0.5)) + 300;
        end

        function open_stream(obj, ~)
            obj.StartTime = posixtime(datetime('now')) * 1000;
        end

        function close_stream(~, ~)
        end

        function [chunk,timestamps] = pull_chunk(obj)
            % Pull a chunk of numeric samples and their timestamps from the inlet.
            % [ChunkData,Timestamps] = pull_chunk()
            %
            % This function obtains a chunk of data from the inlet; the chunk contains all samples
            % that have become available since the last chunk/sample was requested. Note that the
            % result may be empty. For each returned sample there is also a timestamp being
            % returned.
            %
            % Out:
            %   ChunkData : The chunk contents; this is a MxN matrix with one column per returned
            %               sample (and as many rows as the stream has channels).
            %
            %   Timestamps : A vector of timestamps for the returned samples.
            timeNow = posixtime(datetime('now')) * 1000 - obj.StartTime;
            interval = obj.SamplingInterval;

            timestamps = zeros(1,0);
            chunk = zeros(5,0);

            if obj.LastRequestedTime > 0
                timeStart = floorMul(obj.LastRequestedTime, interval);
                timeEnd = ceilingMulOpen(timeNow, interval);
%                 disp(timeStart);
                timestamps = zeros(1, (timeEnd - timeStart)/interval + 1);
                chunk = zeros(5, (timeEnd - timeStart)/interval + 1);
                idx = 1;
                for t = timeStart:interval:timeEnd
                    timestamps(1, idx) = t;
                    for j = 1:4
                        chunk(j, idx) = obj.wave(t/1000);
                    end
                    idx = idx + 1;
                end
            end
            obj.LastRequestedTime = timeNow;
        end
    end
end

