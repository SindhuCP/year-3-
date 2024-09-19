%exp 5
clc;
close all;
clear all;
% to plot the waveform
N=input('Enter the value of N:');
X=-pi/2:.01:pi/2;
u=((cos (X)).^N);
polar(X,u)
% to calculate the power radiated
Prad = dblquad(@(x,y)(((cos (x)).^N).*sin(x)), 0, pi/2, 0, 2*pi);
disp('Power Radiated=');
disp(Prad);
% to cal the hpbw
for angle=(-pi/2):0.0001:0
U=(cos (angle)).^N;
if (U>=(max(u))/2-0.01) && (U<=(max(u))/2+0.01)
theta1=angle;
end
end
for angle=0:0.0001:pi/2
U=(cos (angle)).^N;
if ((U>=(max(u))/2-0.001) && (U<=(max(u))/2+0.001))
theta2=angle;
end
end
theta1=theta1*180/pi;
theta2=theta2*180/pi;
theta=abs(theta1)+abs(theta2);
D=(4*pi*max(u))/Prad;
D_K=(41253)/(theta^2);
D_T_P=(72815)/(2*theta^2);
disp(D);
disp (D_K);
disp(D_T_P);
