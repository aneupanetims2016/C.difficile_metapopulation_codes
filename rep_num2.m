clear all
close all
clc
f=0.1; phi=0.06; beta1c=0.00000045; beta1d=0.00000045; beta2c=0.00024;
beta2d=0.00024; beta3c=0.000225; beta3d=0.000225;

N2=160; K2=200; q1= 0.93; delta1=0.0022; N3=1000; K3=1260; q2=0.75;
delta2=0.02; q3=0.92; delta3=0.1; d1=1/(78.5*365); d2=0.0008; d3=0.02;
zeta=0.033; epsilon=0.1; rho=0.8; S1u=236378; S2u= 110; S3u=671;
v=0; h=0; eta=0; p=0;

m12=(1-N2/K2)*(1-q1)*delta1;
m13=(1-N3/K3)*q1*delta1;
m21= q2*delta2+(N3/K3)*(1-q2)*delta2;
m23= (1- N3/K3)*(1-q2)*delta2;
m31= q3*delta3+(N2/K2)*(1-q3)*delta3;
m32=(1- N2/K2)*(1-q3)*delta3;
Q1=(d1+zeta+f*phi)+m13+m12;
Q2 =(d1+zeta/(1-h)+(1-eta)*f*phi)+m13+m12;
Q3=(d2+zeta+f*phi)+m23+m21;
Q4=(d2+zeta/(1-h)+(1-eta)*f*phi)+m23+m21;
Q5=(d3+zeta+f*phi)+m31+m32;
Q6=(d3+zeta/(1-h)+(1-eta)*f*phi)+m31+m32;
P1=(d1+epsilon*rho)+m12+m13;
P2= (d2+epsilon*rho)+m21+m23;
P3= (d3+epsilon*rho)+m31+m32;

V1 = [Q1, 0, -(1-v)*m21, 0,  -(1-v)*m31, 0;...
       0, Q2, 0, -v*m21, 0, -v*m31;...
       -m12, 0, Q3, 0, -(1-v)*m32, 0;...
    0, -m12, 0, Q4, 0, -(1-v)*m32;...
    -m13, 0, -v*m23, 0, Q5, 0;...
    0, -m13, 0, -v*m23, 0, Q6];

V3 = [-f*phi, 0, 0, 0, 0, 0 ; 0, f*phi*(eta-1), 0, 0, 0, 0;...
    0, 0,  -f*phi,  0, 0, 0; 0, 0, 0, f*phi*(eta-1), 0, 0;...
    0, 0, 0, 0, -f*phi, 0;  0, 0, 0, 0, 0, f*phi*(eta-1)];

V4 =[ P1, 0, -(1-v)*m21, 0, -(1-v)*m31, 0;...
     0, P1, 0, -v*m21, 0, -v*m31;...
    -m12, 0, P2,  0,  -(1-v)*m32 0;...
     0, -m12, 0, P2, 0, -v*m32;...
    -m13, 0, -(1-v)*m23, 0, P3, 0;...
   0, -m13, 0, -v*m23, 0, P3];

A = [beta1c*(1-v)*S1u, beta1c*(1-v)*S1u, 0, 0, 0, 0;...
    (1-p)*beta1c*v*S1u,(1-p)* beta1c*v*S1u, 0, 0,0, 0,;...
      0, 0, beta2c*(1-v)*S2u, beta2c*(1-v)*S2u,  0, 0;...
     0,0, (1-p)*beta2c*v*S2u, (1-p)*beta2c*v*S2u, 0, 0;...
     0, 0, 0, 0,beta3c*(1-v)*S3u, beta3c*(1-v)*S3u ;...
     0, 0, 0, 0,(1-p)*beta3c*v*S3u, (1-p)*beta3c*v*S3u];
 
B = [beta1d*(1-v)*S1u, beta1d*(1-v)*S1u, 0, 0, 0, 0;...
     (1-p)* beta1d*v*S1u, (1-p)*beta1d*v*S1u, 0, 0, 0, 0;...
     0, 0,beta2d*(1-v)*S2u, beta2d*(1-v)*S2u,  0, 0;...
    0, 0,(1-p)* beta2d*v*S2u,(1-p)* beta2d*v*S2u, 0,  0;...
    0, 0, 0, 0,beta3d*(1-v)*S3u, beta3d*(1-v)*S3u ;...
    0, 0, 0, 0, (1-p)*beta3d*v*S3u,(1-p)* beta3d*v*S3u ];

V1_inv=inv(V1);
V4_inv=inv(V4);
H= (A-(B* V4_inv*V3))*V1_inv;
R_0= max((eig(H))) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reproduction number of community, SNF, and hospital
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R_com= (S1u/Q1)*(beta1c+ (f*phi*beta1d/P1))
R_snf= (S2u/Q2)*(beta2c+ (f*phi*beta2d/P2))
R_hos= (S3u/Q3)*(beta3c+ (f*phi*beta3d/P3))




