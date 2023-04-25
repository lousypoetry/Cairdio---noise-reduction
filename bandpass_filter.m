% Define the directory where the audio files are stored
directory = 'C:\Users\Jade\Cairdio\challenge-2016\classification-of-heart-sound-recordings-the-physionet-computing-in-cardiology-challenge-2016-1.0.0\validation';

% Get a list of all the files in the directory
fileList = dir(fullfile(directory, '*.wav'));

% Create a new MATLAB data structure
audioStruct = struct();

% Define the filter parameters
lowCutoffFrequency = 100;  % Hz
highCutoffFrequency = 200; % Hz
filterOrder = 4;

% Loop over the audio files and read each file
for i = 1:length(fileList)
    % Construct the file path
    filePath = fullfile(directory, fileList(i).name);
    
    % Read the audio data and sample rate from the file
    [audioData, sampleRate] = audioread(filePath);
    
    % Create the bandpass filter
    [b, a] = butter(filterOrder, [lowCutoffFrequency/(sampleRate/2), highCutoffFrequency/(sampleRate/2)], 'bandpass');
    
    % Apply the bandpass filter to the audio data
    filteredAudioData = filtfilt(b, a, audioData);
    
    % Add the audio data and sample rate fields to the structure
    audioStruct(i).audioData = filteredAudioData;
    audioStruct(i).sampleRate = sampleRate;
end

% Save the structure to a file
save('myAudioData.mat', 'audioStruct');
