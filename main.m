addpath(genpath('./liblsl-Matlab/bin'));
addpath(genpath('./util'));

clear;

STREAM_NAME = 'PetalStream2';
EXIT_KEY_CODE_NAME = 'ESCAPE';
ANALYZE_INTERVAL = 0.5; %[s]

MuseSamplingRate = 256;

initKeyInput;

exitKeyCode = KbName(EXIT_KEY_CODE_NAME);
% inlet = initInlet(STREAM_NAME);
inlet = MocLslInlet();
analyzer = EEGAnalyzer(inlet);

fprintf("Press %s to terminate...\n", EXIT_KEY_CODE_NAME);
inlet.open_stream();
while true
    analyzer.analyzePeriod(ANALYZE_INTERVAL);
    if checkKeyInput(exitKeyCode)
        break
    end
end

analyzer.tearDown;

