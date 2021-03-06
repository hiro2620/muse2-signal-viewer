function inlet = initInlet(streamName)

%% instantiate the library
disp('Loading the library...');
lib = lsl_loadlib();

% resolve a stream...
disp('Resolving an EEG stream...');
% result = {};
% while isempty(result)
%     result = lsl_resolve_byprop(lib,'name',[streamName '_eeg']);
% end

result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','EEG'); end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving data...');

end

