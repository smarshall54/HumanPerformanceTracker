classdef lift
    %LIFT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        joints                  % - which joints are involved in the lift
        jointrom                % - through what ROM does this lift move each
        %       joint, and in which planes?
        tempo                   % - how long (in seconds) does it take to do
                                %       the concentric, hold, eccentric,
                                %       hold portions of the lift (array of
                                %       4 numbers)
        weight
    end
    
    methods
        % ***** Constructor *****
        function obj = lift(jointlist,jointromlist,tempoarray,weightin)
            if ~exist('jointlist')
                error('Instantiate some Joints!');
            else
                obj.joints = jointlist;
            end
            if ~exist('jointromlist')
                error('Input how much ROM this lift covers for each joint!');
            else
                obj.jointrom = jointromlist;
            end
            
            if ~exist('tempoarray')
                obj.tempo = [1,0,1,0];
            else
                obj.tempo = tempoarray;
            end
            if ~exist('weightin')
                obj.weight=100;
            else
                obj.weight = weightin;
            end
        end
        
        function execute(lift,plots)
            % this function executes the lift through full ROM.
            % you can tell it which plots to output.
            flex_amount = lift.jointrom;
            
            % Here is what I am confused about.
            % "joints" is a list of all the joints used in this lift. each
            % item in the list is the name of an object in the joint class.
            %
            % 
            pos = lift.joints.flex([0,0,0],lift.jointrom(1)); % only works for joints lists 1 item long... need to fix
            
            
            
            Wmuscle=0 % initialize variable
            degstep = 1; % how fine should the resolution be?
                            % in the future, bring this out as a property
                            % in a superclass ("resolution parameters")
            tempo = obj.tempo(1);  % number of seconds it takes to contract the full ROM.
                                   %    I will have to differentiate between 
                                   %    Concentric / Eccentric work later on.
            machine=1; % we are using a machine that keeps the force constant.
                       % this should be deleted when this function
                       % is generalized. it is only relevant to the "leg
                       % curl" test case.
                       
            theta = knee.standing_sag : -degstep : knee.standing_sag-flex_amount;
            theta = lift.jointlist(1).flex([0,0,0],lift.jointrom(1))
            
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
                tau_weight(i) = tibia.length*lift.weight*sind(phi(i));
                Fmuscle(i) = (tibia.length).*(lift.weight*sind(phi(i)))/(ham.distal_insertion.*sind(thetaprime(i)))
                if i>1
                    Wmuscle = Wmuscle+((lmuscle(i)-lmuscle(i-1))*Fmuscle(i));
                end
            end
            
            elongation = max(lmuscle) - min(lmuscle);
            
            plot(theta,Fmuscle)
            hold on
            
        end
        
        
    end
    
end

