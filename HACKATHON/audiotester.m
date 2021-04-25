clc
close all
clear
%--------------------------------------------------------------------------
%recording my voice and setting that as the sample we want to use%
%--------------------------------------------------------------------------
myVoice = audiorecorder;

 %Define callbacks to show when
 %recording starts and completes.
 myVoice.StartFcn = 'disp(''Start speaking.'')';
 myVoice.StopFcn = 'disp(''End of recording.'')';
% 
userin1=input('lowpassband?(>0)')
userin2=input('highpassband?(>0) prepare to record btw')
% 
 record(myVoice, 10);
 pause(10)
 dirty=getaudiodata(myVoice)

Fs=100000
%[dirty,Fs] = audioread('music.wav');%for audio files
 clear sound

    x = dirty;  %# freq. sweep from 0-500 over 2 sec.
    step=ceil(20*Fs/1000);    %# one spectral slice every 200 ms
    window=ceil(100*Fs/1000); %# 1000 ms data window
    specgram(x, 2^nextpow2(window), Fs, window, window-step);
    
 boosted0 = lowpass(x,userin1,Fs);%filter design
 boosted = highpass(boosted0,userin2,Fs);%filter design
fvtool(boosted0)

% plot(boosted)
hold off

    y = boosted;  %# freq. sweep from 0-500 over 2 sec.
    step=ceil(20*Fs/1000);    %# one spectral slice every 200 ms
    window=ceil(100*Fs/1000); %# 1000 ms data window
    specgram(y, 2^nextpow2(window), Fs, window, window-step);
sound(dirty)
pause(10)
sound(boosted)
pause(10)
clear sound