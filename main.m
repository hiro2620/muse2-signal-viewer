addpath(genpath('./liblsl-Matlab'));
addpath(genpath('./util'));

STREAM_NAME = 'PetalStream2';
EXIT_KEY_CODE_NAME = 'ESCAPE';
ANALYZE_INTERVAL = 0.1; %[s]

MUSE_SAMPLING_RATE = 256;
FFT_TIME_WINDOW = 2.0; %[s]

initKeyInput;

exitKeyCode = KbName(EXIT_KEY_CODE_NAME);
% inlet = initInlet(STREAM_NAME);
inlet = MockLslInlet(MUSE_SAMPLING_RATE);
samplingCnt = fix(FFT_TIME_WINDOW * MUSE_SAMPLING_RATE);
if mod(samplingCnt, 2) == 1
%     warning("sampling count should be an even number");
      samplingCnt = samplingCnt + 1;
end
analyzer = EEGAnalyzer(inlet, FftHandler(MUSE_SAMPLING_RATE, samplingCnt));
fprintf("Press %s to terminate...\n", EXIT_KEY_CODE_NAME);
inlet.open_stream();

try
    while true
        analyzer.analyzePeriod(ANALYZE_INTERVAL);
        if checkKeyInput(exitKeyCode)
            break
        end
    end

catch ME
    analyzer.tearDown;
    rethrow(ME);
end

analyzer.tearDown;

