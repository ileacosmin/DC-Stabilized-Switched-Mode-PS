ku=0.5;
Uref=12;
U2=12;
L=0.78e-3;
C=0.176;
Rs=2.4;
A=8;


Hf=tf(1,[L*C L/Rs 1])*tf(1,2*A); % the process

bodemag(Hf, 'k'); hold on; % bodemag draws only the magnitude plot

sigma = 0.15; % choose the desired overshoot to meet the specifications
z = abs(log(sigma)) / sqrt (pi^2 + log(sigma)^2) % compute damping ratio
A1 = 1/(4*sqrt(2)*z^2) % compute the distance A, see fig from 2.1 in CE lab5

A_tf = tf(A1,1); % write it likes this such that bodemag sees it as a tf element
bodemag(A_tf, '--b'); hold on; % see where A is with respect to Hf, Hd must go through A at wf. Do we move up or down? (Hint: down)

Adb = mag2db(A1)
wf = 2; % corner frequency computed as 1/0.5, because Tf is 0.5

modulHf = 3.5/( wf*sqrt(0.5^2*wf^2 + 1) ) % I computed it here, but you can also read it from Bode at frequency 2rad/s
modulHfdB = 20*log10(modulHf) % mag2db(modulHf)

VrdB = modulHfdB - Adb % the sign is minus because we move the plot downwards, such Hf intersects A at the corner frequency
Vr = 10^(-VrdB/20) % db2mag(-VrdB)

Hd = Vr * Hf % compute open loop system

bodemag(Hd, 'r'); legend('Hf', 'A', 'Hd')

wt = 86; % read this from Bode, it's the frequency where Hd is 0dB

% check the specs - they're all good! P controller is ok!
wn = 2*z*wt;
tr = 4/z/wn
cv = wn/2/z

% let's check again the specs on the step response
Ho = Hd/(1+Hd)
figure;
step(Ho)
