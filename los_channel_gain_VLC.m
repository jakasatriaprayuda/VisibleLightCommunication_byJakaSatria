function [H,d,phi]=los_channel_gain_VLC(psi_hf,XT,YT,ZT,XR,YR,ZR,FOV,Ar,index)

m = -log(2)/log(cosd(psi_hf)); %lambertian Half Power;
d = sqrt(((XR-XT).^2)+((YR-YT).^2)+((ZR-ZT).^2)); %Distance Propagation
h = abs(ZR-ZT); %heigh between Tx and Rx
phi = acosd(h./d); %Angle of lamp
G_con = (index^2)./(sind(FOV))^2; %Gain concentrator
H =(m+1).*(cosd(phi).^m).*Ar.*G_con./(2.*pi.^d); %Hlos

end