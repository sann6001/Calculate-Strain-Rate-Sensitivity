clear all;
T=[0:10:300];             %temperature range
dF=T*0.0462+8.776;        %activation energy vs. temperature
dV=0.0013.*T.*T+0.023.*T+9;      %activation volume vs. temperature
CRSSb=0.0063.*T.*T-2.4.*T+295.6; %CRSS of basal slip vs. temperature 
CRSSp=0.00334.*T.*T-1.288.*T+183.4;   %CRSS of prism slip vs. temperature

for i=1:length(T)
    [m(i),n(i)] = calc_SRS(T(i),dV(i),dF(i),CRSSb(i)) ;
end

errorbar(T,m,n);
