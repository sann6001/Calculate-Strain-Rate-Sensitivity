%calculate SRS of a slip system at given set of parameters
%Yi Xiong
%University of Oxford
%Oct 2019
%using the slip law developed by Dunne et al
%https://doi.org/10.1016/j.ijplas.2006.10.013
function [m,n]=calc_SRS(TempC, dV, dF, tauC)
b=2.95E-4;  %burger vector micrometres
rohm=5.0;  %micrometre^2
v=1E+11;        % Hz
k=1.38E-23*1E12;      % pJ/K
deltaV = dV*b^3;  % unit b^3 
deltaF = dF*1E-20*1E12;   %pJ
A=rohm*v*b^2*exp(-deltaF/(k*(TempC+273)));
B=deltaV/(k*(TempC+273));
tau = [tauC:1:tauC+350];         %define the range of tau
gammaDot=A*sinh(B*(tau-tauC));   %calculate shear strain rate
    for j=1:length(gammaDot)   
        if gammaDot(j)>=0.0000001     %lower bound of strain rate 
            break
        end
    end
    for k=1:length(gammaDot)
        if gammaDot(k)>=0.00001       %upper bound of strain rate
            break
        end
    end
gd=gammaDot(j:k);
t_range=tau(j:k);

lograte=log10(abs(gd));          %log scale both shear strain rate and shear stress
logstress=log10(t_range);

Const = fitlm(lograte,logstress,'Linear');        %liner fitting
m = Const.Coefficients.Estimate(2);               %gradient to represent the strain rate sensitivity exponent
n = Const.Coefficients.SE(2);                     %fitting error