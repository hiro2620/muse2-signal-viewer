classdef MocLslInlet < handle
    %MOCLSLINLET Summary of this class goes here
    %   Detailed explanation goes here




    
    
    properties
        LastRequestedTime
    end

    methods
        function obj = MocLslInlet()
            %MOCLSLINLET Construct an instance of this class
            %   Detailed explanation goes here
            obj.LastRequestedTime = 0;
        end

        function z = wave(~, t)
%             z = sin(10*t) + 2*sin(20*t) + sin(30*t) + 2*sin(50*t) + sin(70*t);
            z = sin(10*t) + 2*sin(20*t) + sin(30*t) + 2*sin(50*t) + sin(70*t) + (rand-0.5);
        end

        function open_stream(~, ~)

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
%             waitTimeMS = fix(rand * 1000);
%             pause(waitTimeMS / 1000);
            timeNow = posixtime(datetime('now')) * 1000;
            PERIOD = 4;

            timestamps = [];
            chunk = [];

            if obj.LastRequestedTime > 0
                timeStart = floorMul(obj.LastRequestedTime, PERIOD);
                timeEnd = ceilingMulOpen(timeNow, PERIOD);
%                 disp(timeStart);
                timestamps = zeros(1, (timeEnd - timeStart)/PERIOD + 1);
                chunk = zeros((timeEnd - timeStart)/PERIOD + 1, 5);
                idx = 1;
                for t = timeStart:PERIOD:timeEnd
                    timestamps(1, idx) = t;
                    for j = 1:4
                        chunk(idx, j) = obj.wave(t);
                    end
                    idx = idx + 1;
                end
            end
            obj.LastRequestedTime = timeNow;
        end
    end
end

