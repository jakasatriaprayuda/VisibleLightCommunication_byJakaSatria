clc; clear; close all;
%% Room Dimension

L=5; P=5; T=3; %Spec of Room
n_grid = 25; %Interval
XT=0; X=linspace(-L/2,L/2,n_grid); %Koor X
YT=0; Y=linspace(-P/2,P/2,n_grid); %Koor Y
[XR ,YR] = meshgrid(X,Y); %Koor XY in 3 Dimension
ZT = 3; ZR = .8; %Koor Z

%% Tx Component

psi_hf = 60; %Angle of Radiation LED, 
Ptx = 50; %Power in mW
N_LED = 64;
Ptot = Ptx*N_LED; %Total Power
B = 1e9; %Bitrate 1 Gbps

%% Rx Component

FOV = 70;
Ar = 1e-4; %Area photodetector
index = 1.45; %Index bias
R = 0.55; %Responsitivity PD
q = 1.6e-19; %Elektron Charge

%% HLOS

[H,d,phi] = los_channel_gain_VLC(psi_hf,XT,YT,ZT,XR,YR,ZR,FOV,Ar,index);

%% Receive Power

Pr = Ptot.*H; %Power in mW
Prw = Pr./1000; %Power in W
Pr_dbm = 10.*log10(Prw);

%% SNR

Ib = 202e-6;
No = 2*q*Ib; %Noise equivalent

SNR =((R.^2).*(Prw.^2))./(B.*No);
SNRdb=10.*log10(SNR);

%% BER

BERnrz = 0.5.*erfc(SNR./sqrt(2));
BERrz = 0.5.*erfc(0.5.*sqrt(SNR));

%% Output

figure (1);
surfc(X,Y,SNRdb);
c=colorbar('southoutside');
c.Label.String='Power Receive (dB)';
grid on;
xlabel('Width');
ylabel('Length');
zlabel('SNRdb');
title('SNR in Room');