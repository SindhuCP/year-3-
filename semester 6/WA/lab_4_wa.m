% exp 4
clc;
close all;
clear all;
X=-pi/2:.01:pi/2;
u=(cos (X).*cos(6.*X)).^2;
polar(X,u)
% to calculate the power radiated
Prad = dblquad(@(x,y)(((cos (x)).*(cos(6.*x))).^2).*sin(x), 0, pi, 0, 2*pi);
disp('Power Radiated=');
disp(Prad);
% to cal the hpbw
for angle=(-pi/2):0.00001:0
U=(cos (angle).*cos(6.*angle)).^2;
if (U>=(max(u))/2-0.01) && (U<=(max(u))/2+0.01)
theta1=angle;
end
end
theta1=theta1*180/pi;
for angle=0:0.00001:pi/2
U=(cos (angle).*cos(6.*angle)).^2;
if (U>=((max(u))/2)-0.001) && (U<=((max(u))/2)+0.001)
theta2=angle;
end
end
theta2=theta2*180/pi;
theta=abs(theta1)+abs(theta2);
disp('HPBW=');
disp(theta);
%for FNBW
for angle=0:0.00001:(pi/2)
U=(cos (angle).*cos(6.*angle)).^2;
if (U>=(min(u))/2-0.001) && (U<=(min(u))/2+0.001)
theta3=angle;
break;
end
end
theta3=theta3*180/pi;
for angle=(-pi/2):0.00001:0
U=(cos (angle).*cos(6.*angle)).^2;
if (U>=(min(u))/2-0.01) && (U<=(min(u))/2+0.01)
theta4=angle;
end
end
theta1=theta1*180/pi;
theta4=theta4*180/pi;
theta=abs(theta3)+abs(theta4);
disp('FNBW=');
disp(theta);


% clc;
% close all;
% clear all;
% 
% % Define the range of angles
% X = -pi/2:.01:pi/2;
% 
% % Calculate the radiation pattern with additional lobes
% num_lobes = 6; % Number of additional lobes
% u = (cos(X).*cos(num_lobes.*X)).^2;
% 
% % Plot the polar radiation pattern
% polar(X,u)
% 
% % Calculate the power radiated
% Prad = dblquad(@(x,y)(((cos(x)).*(cos(num_lobes.*x))).^2).*sin(x), 0, pi, 0, 2*pi);
% disp('Power Radiated=');
% disp(Prad);
% 
% % Calculate the HPBW
% [theta1, theta2] = calculate_HPBW(X, u);
% HPBW = abs(theta1) + abs(theta2);
% disp('HPBW=');
% disp(HPBW);
% 
% % Calculate the FNBW
% [theta3, theta4] = calculate_FNBW(X, u);
% FNBW = abs(theta3) + abs(theta4);
% disp('FNBW=');
% disp(FNBW);
% 
% % Function to calculate HPBW
% function [theta1, theta2] = calculate_HPBW(X, u)
%     for angle = -pi/2:0.00001:0
%         U = (cos(angle).*cos(6.*angle)).^2;
%         if (U >= (max(u))/2-0.01) && (U <= (max(u))/2+0.01)
%             theta1 = angle;
%         end
%     end
%     theta1 = theta1 * 180 / pi;
%     
%     for angle = 0:0.00001:pi/2
%         U = (cos(angle).*cos(6.*angle)).^2;
%         if (U >= ((max(u))/2)-0.001) && (U <= ((max(u))/2)+0.001)
%             theta2 = angle;
%         end
%     end
%     theta2 = theta2 * 180 / pi;
% end
% 
% % Function to calculate FNBW
% function [theta3, theta4] = calculate_FNBW(X, u)
%     for angle = 0:0.00001:(pi/2)
%         U = (cos(angle).*cos(6.*angle)).^2;
%         if (U >= (min(u))/2-0.001) && (U <= (min(u))/2+0.001)
%             theta3 = angle;
%             break;
%         end
%     end
%     theta3 = theta3 * 180 / pi;
%     
%     for angle = -pi/2:0.00001:0
%         U = (cos(angle).*cos(6.*angle)).^2;
%         if (U >= (min(u))/2-0.01) && (U <= (min(u))/2+0.01)
%             theta4 = angle;
%         end
%     end
%     theta4 = theta4 * 180 / pi;
% end
% 
