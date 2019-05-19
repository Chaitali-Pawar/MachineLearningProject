%% Method1
clear all
close all
clc;
nTrial=96;
nSub=24;
nEvent=2;
nCh=58;
nT=70;
X_w_temp=[];
X_wo_temp=[];
X_w=[];
X_wo=[];

X=zeros(11136,70);
ctr=0;
for k = 1:nSub
    if k ==16
        continue
    end
    filename = sprintf('ActiveTouch_64_s%d_allpwr.mat',k);
    File_struct = load(filename);
    Cell = File_struct.Allpwr;
    ctr=0;
    for i=1:nCh
        W_Ch1 = Cell{1,i};
        Avg_PSD_Ch1= squeeze(mean(W_Ch1(12:30,:,:)))';
        X_w_temp(ctr*nTrial+1:nTrial*i,:)=Avg_PSD_Ch1;
        %size(Avg_PSD_Ch1);
        ctr=ctr+1;
    end
    X_w=vertcat(X_w,X_w_temp);
    

    ctr=0;
    for i=1:nCh
        W_Ch1 = Cell{2,i};
        Avg_PSD_Ch1= squeeze(mean(W_Ch1(12:30,:,:)))';
        X_wo_temp(ctr*nTrial+1:nTrial*i,:)=Avg_PSD_Ch1;
        ctr=ctr+1;
    end
    X_wo=vertcat(X_wo,X_wo_temp);
    

end

X=vertcat(X_w,X_wo);


nSub=23;
Ch_Matrix=zeros(4416,70);
ctr=0;
y=zeros(4416,1);
y(2208:end,1)=1;

for j=1:nCh
    Ch_Matrix=[];
    mnew1=[];
    mnew2=[];
    ctr=0;
    for i=1:(2*nSub)
       start_idx=((i-1)*nCh*nTrial+1)+(96*(j-1));
       end_idx=start_idx+nTrial-1;

       start_ch_idx=nTrial*ctr+1;
       end_ch_idx=start_ch_idx+nTrial-1;
       Ch_Matrix(start_ch_idx:end_ch_idx,:)=X(start_idx:end_idx,:);
       ctr=ctr+1;
    end    
    ch_name=sprintf('Ch_%d.mat',j);
    save(ch_name,'Ch_Matrix','y');
    
end
