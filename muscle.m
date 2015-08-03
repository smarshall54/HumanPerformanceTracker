classdef muscle
    %MUSCLE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %% Insertions
        distal_head             % bone that the proximal head inserts on
                                %   used to calculare elongation when joint
                                %   moves
        distal_insertion        % distance from joint point-of-rotation to 
                                %   muscle inserstion. used to calc.
                                %   elongation
        proximal_head           % bone that the proximal head inserts on
        proximal_insertion      % distance from joint point-of-rotation to 
                                %   muscle inserstion. used to calc.
                                %   elongation
        proximal_joint          %
        distal_joint
        
        %% 
        cross_section           % cross-sectional area of this muscle
                                %   relative to the largest in the body.
                                %   [0.0,1.0]
        rel_capil               % relative capillarization of this muscle
                                %   compared to untrained
        rel_mitodens            % relative mitochondrial density of this 
                                %   muscle compared to untrained
        fibertype               % Ratio of TI to TII fibers (T1:Total)
        innervation             % Amount of neural training
    end
    
    methods
        function obj = muscle(csarea,dins)
            if isnumeric(csarea)&&isnumeric(dins)
                obj.cross_section = csarea;
                obj.distal_insertion = dins;
            else
                error('Value must be numeric')
            end
        end
        
        function relforce = forceload(obj,amount)
            relforce = amount / obj.cross_section;
        end
        
        function distance = elongate(obj,amount)
            distance = amount;
        end
        
%         function work = fatigue(obj)
%             work = elongate.obj * relforce;   cant call fatigue without
%             asking for the same inputs as forceload and elongate
%         end
    end
    
end

