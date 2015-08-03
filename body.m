classdef body
    %   This class will define an individual person's body by parsing a 
    %   database of geometrical data such as bone length, insertions, muscle 
    %   sizes and so forth.
    %
    %   A second, standardized database will also be parsed which defines the
    %   musculoskeletal structure (joint, bone, muscle connections) which
    %   should be the same for all persons, but leaves the option for
    %   "custom skeletons" to play around.
        %   Detailed explanation goes here
    
    properties
    end
    
    methods
        % ***** Constructor *****
        function obj = body(individual_db, musculoskeletal_db)
            % parse in the databases to construct the class
        end
        
        function plotskele
            % generate a 3-D stick diagram of the skeleton in it's current
            % position
        end
        
        function listangles
            % list the angles of each joint in the current position
        end
    end
    
end

