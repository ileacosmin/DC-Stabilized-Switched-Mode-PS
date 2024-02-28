%% A
clear all; close all
U1=220
U2=12
I2=5
% A.1.2.1
P2=U2*I2
% A.1.2.2
niutr=0.86
Pg=P2/2*((niutr+1)/niutr)
% A.1.2.3
J=3
Sfe=1.2*sqrt(Pg*(1+niutr)/(J*niutr))
% A.1.2.5
I1=Pg/U1
% A.1.2.6
R2N=U2/I2
% A.1.2.7
R2=1/100*R2N
% A.1.2.8
R1=0.5/100*(U1/I1)
% A.1.2.9
R2star=R2+R1*(U2/U1)^2
% A.2
% A.2.2.2
Umax21=sqrt(2)*U2
Ustarmax21=2.12*U2

I2dc=1.5*0.7*I2
rd=0.12
k=2
Ip=(sqrt(2)*U2)/(R2star+k*rd)
Cf=18.75*1e-3
deltat=(R2star+k*rd)*Cf
% A.3
pi=67/100;
po=10/100;
RSN=U2/I2
% A.3.2
q=pi/po
% A.3.2.2
Rrt=R2star+k*rd
% A.3.2.3
Cfstar=1600*q*(Rrt+RSN)/Rrt/RSN;
Cfstar=Cfstar*1e-6
Rr=Rrt
% A.3.2.4
deltaUd=0.75;
Eo=1.41*U2-k*deltaUd
% A.3.2.5
R0=RSN;
kr=Rr/R0
C0=Cfstar;
wCR=314*C0*R0
% from table 7 
ku=0.65
% A.3.2.5
CfstarStar=wCR/314/R0

%
C=(Cfstar+CfstarStar)/2


%% B
% B1a
% 1)
miu=0.5
% 2)
RSN
% 3)
Udc=ku*sqrt(2)*U2
% 4)
Udcmax=sqrt(2)*U2
% 5)
Vo=miu*Udc
% 6)
Io=Vo/RSN
% 7)
deltaIL=0.2*Io
% 8)
deltaVo=2/100*Vo
% 9)
fc=20*1e3

% 1.
L=(Udcmax-Vo)*miu/fc/deltaIL
% 2.
C_2=(deltaIL*miu)/fc/deltaVo
% alegem tranzistorul


Utranzistor=2*sqrt(2)*U2
Itranzistor=1.5*Io

Udioda=1.25*Udcmax
Idioda=1.5*Io


Rs=RSN;
% the reference voltacge
Rsd=Rs-0.2*Rs;
Rsd2=Rs-0.2*Rs;
%% C P
A=8;
C=C_2;
L2=L*10;
H=tf(1,[L2*C L2/Rs 1]);
Hol=1/2/A*sqrt(2)*ku*U2*H;
figure
rlocus(Hol)
kp=9.34;
kr=0.2;
Hd=Hol*kp;
Hcl=Hd/(1+Hd);


%% C Pi

Ti=1/432;
kc=6.06;
Hc= kc* (1+tf(1,[Ti 0]));
HolPI=1/2/A*sqrt(2)*ku*U2*H*Hc;
[numPI, denPI]=tfdata(Hc);
numPI=numPI{1,1};
denPI=denPI{1,1};
figure
rlocus(HolPI);
Hcl=HolPI/(1+HolPI);

%%

sim("model_perturb_output.slx");
t=ans.tout;
yout=ans.ScopeData{1}.Values
ref=ans.ScopeData{2}.Values
figure
plot(t,yout.Data);
hold on
plot(t,ref.Data);
legend('Output','Refrence')
title ('Scope Data'); grid; shg;



t=ans.tout;
yout=ans.ScopeData1{1}.Values
ref=ans.ScopeData1{2}.Values
figure
plot(t,yout.Data);
hold on
plot(t,ref.Data);
legend('Output','Refrence')
title ('Scope Data'); grid; shg;
%%
sim("model_perturb_output.slx");

t=ans.tout;
yout=ans.ScopeData3{1}.Values
yout2=ans.ScopeData3{2}.Values
ref=ans.ScopeData3{3}.Values
figure
plot(t,yout.Data);
hold on
plot(t,yout2.Data);
hold on
plot(t,ref.Data);
legend('OutputWithPerturb','Output','Ref')
title ('Scope Data'); grid; shg;
%%
sim("model_perturb_output.slx");

t=ans.tout;
yout=ans.ScopeData4{1}.Values
yout2=ans.ScopeData4{2}.Values
ref=ans.ScopeData4{3}.Values
figure
plot(t,yout.Data);
hold on
plot(t,yout2.Data);
hold on
plot(t,ref.Data);
legend('OutputWithPerturb','Output','Ref')
title ('Scope Data'); grid; shg;
