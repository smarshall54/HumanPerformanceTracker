%function instantiate_muscles

clear all


%% instantiate some body parts!
% instantiate some muscles
pec_major = muscle(25,0.25); % relative cross sections and distal insertion lengths
quad = muscle(75,0.0);
ham = muscle(60,0.16);

% instantiate a simple joint
knee = joint('femur','tibia', [140,0,0],[180,0,0]);

% and 2 bones that create it
femur = bone(1) % length = 1 meter
tibia = bone(0.75) 

% now define a lift
legcurl = lift(['knee'],[140],[1,0,1,0]);


relforce = pec_major.forceload(50)
dist = pec_major.elongate(3)
work = relforce*dist;


%% Do a Leg Curl (calculate static at halfway point)
flex_amount = [72,0,0];
weight = 500; % in Newtons. (1 lb = 4.448 N)

pos = knee.flex(knee.standing_pos,legcurl.jointrom);

% for static calculations of the leg curl, assume theta is at the midway
% point in the movement, that is, theta=standingposition + ROM/2
theta = knee.standing_pos - flex_amount/2;

% Calculate interesting parameters of the leg curl.
lmuscle = sqrt(tibia.length^2+ham.distal_insertion^2);
thetaprime = asind(femur.length.*sind(theta)./lmuscle);

phi = theta-90;  % assume the fibia is parallel to earth
% torque_weight must == -torque_muscle
%   torque = dist*Force*sin(angle)
tibia.length
ham.distal_insertion
tau_weight = tibia.length*weight*sind(phi)
Fmuscle = (tibia.length).*(weight*sind(phi))/(ham.distal_insertion.*sind(thetaprime))

%% Do a Leg Curl (calculate at multiple steps and plot Force

flex_amount = 105;
weight = 500; % in Newtons. (1 lb = 4.448 N)

Wmuscle=0 % initialize variable
degstep = 1; % how fine should the resolution be?
tempo = 4; % number of seconds it takes to contract the full ROM.
           %    I will have to differentiate between Concentric / Eccentric
           %    work later on.
machine=1; % we are using a machine that keeps the force constant.
theta = knee.standing_pos - flex_amount/2;

for i=1:1:length(theta)
  
% Calculate interesting parameters of the leg curl.
lmuscle(i) = sqrt(femur.length^2+ham.distal_insertion^2 - 2*ham.distal_insertion*femur.length*cosd(theta(i)));
thetaprime(i) = asind((femur.length./lmuscle(i))*sind(theta(i)));


if machine==0
phi(i) = theta(i)-90;  % assume the fibia is parallel to earth.
                       %    this assumes a "dumb" leg curl where the angle
                       %    of the load changes. on a machine this angle is
                       %    forced to always be 90* by cable routing.
else
    phi(i)=90;
end
% torque_weight must == -torque_muscle
%   torque = dist*Force*sin(angle)
tau_weight(i) = tibia.length*weight*sind(phi(i));
Fmuscle(i) = (tibia.length).*(weight*sind(phi(i)))/(ham.distal_insertion.*sind(thetaprime(i)))
if i>1
    Wmuscle = Wmuscle+((lmuscle(i)-lmuscle(i-1))*Fmuscle(i));
end
end

elongation = max(lmuscle) - min(lmuscle);

plot(theta,Fmuscle)
hold on

%% now do it using the class!



legcurl.execute


%end
