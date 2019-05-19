clear all;
close all;
clc;

load('PSD.mat');     % EEG data set
load('chName.mat');  % channels
load('tFrames.mat'); % time point

events         = {'With'; 'Without'};   
bandName = {'Theta'; 'Alpha'; 'Beta'; 'Gamma'};

PSD(:,:,:,:,12)=[];
PSD(:,:,:,:,15)=[];
%PSD=PSD(:,[1:2],3,:,:);


[nEvent nCh nFreq nT, nSub] = size(PSD)
PSDavg = squeeze(mean(PSD,5));

PSDw=zeros(24,70);
PSDwo=zeros(24,70);
y=zeros(48,1);
y(25:end)=1;
ctr=0;
for b=1:nFreq
    for ch=1:nCh
        for i=1:nSub
        PSDw(i,:)=squeeze(PSD(1,ch,b,:,i));
        PSDwo(i,:)=squeeze(PSD(2,ch,b,:,i));
        end
    PSD1=[PSDw;PSDwo];    
    ch_name=sprintf('Ch_%d.mat',ch);
    save(ch_name,'PSD1','y');
    end
    pause;
end
