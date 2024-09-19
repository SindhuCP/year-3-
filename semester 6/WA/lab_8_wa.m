%lab 8 binomial array and N element array with N=5 and alpha =0 plot the HPBW
n=5;
d=0.5;
psi_h=acos(2*((0.5)^(1/(n-1)))-1)*180/pi;
hpbw_in_psi_plane=2*psi_h
psi=-2*pi:0.001:2*pi;
AF=((1+cos(psi))/2).^((n-1)/2);

plot(psi*180/pi,AF);
figure;
title("Psi plot");
theta=linspace(0,pi,1000);
psi_eq=2*pi*d*cos(theta);
AF_x=((1+cos(psi_eq))/2).^((n-1)/2);
polarplot(theta-pi/2,abs(AF_x));
k=2*pi;
theta1=acosd(psi_h/((k*d)*(180/pi)));
theta2=acosd(-psi_h/((k*d)*(180/pi)));
HBPW_in_theta=theta2-theta1