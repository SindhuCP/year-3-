% lab 6 wa 04.03.2024

clc;
clear all;
close all;
w=input('enter the value of wavelength=');
K=2*pi/w;
l=input('enter the value of dipole length=');
eta=120*pi; %free space
x=0:0.01:2*pi;
I=input('enter the value of current=');
v=eta*(((K*I*l)/(4*pi)).^2)*sin(x).^2; %calculating S for finite length
%and lamda/2 dipole 
% for short you give l less than the lambda but not too small
%v=eta*(((K*I*l).^2)/(32*(pi.^2)*(l.^2)))*sin(x).^2; %for hertiazian
figure(1);
polar(x,v);
E=(cos((K*l.*cos(x))/2)-cos(K*l/2))./sin(x); % calculating the Finite length ka E field 
figure(2);
polar(x,abs(E));
H=E/eta;
figure(3);
polar(x,abs(H));

