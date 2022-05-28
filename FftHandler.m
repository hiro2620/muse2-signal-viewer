classdef FftHandler < handle
    %FFTPARAM Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Fs
        SampleCnt
    end

    methods
        function obj = FftHandler(Fs,SampleCnt)
            %FFT Construct an instance of this class
            %   Detailed explanation goes here
            obj.Fs = Fs;
            obj.SampleCnt = SampleCnt;
        end

        function [f, P1] = getSpectrum(obj, rawData)
            % https://jp.mathworks.com/help/matlab/ref/fft.html
            L = obj.SampleCnt;
            Y = fft(rawData);
            P2 = abs(Y/L);
            P1 = P2(1:L/2+1);
            P1(2:end-1) = 2*P1(2:end-1);
            f = obj.Fs * (0 : (L/2)) / L;
        end
    end
end

