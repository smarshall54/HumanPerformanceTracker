classdef joint
    %JOINT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        rom                 % Array representing ROM of this joint in the 
                            % Saggital, Transverse, and Horizontal planes.
                            % Format: rom = [sag,trans,horz];
        standing_pos        % Array representing the starting angles of 
                            % this joint in the 3 planes. The "rest
                            % position" is defined as a "standing" person.
                            % standing_pos =
                            % [sag_start,trans_start,horz_start];
        bone_a              % 
        bone_b              % 
        angle_res           % resolution returned when joint flexes in deg
    end
    
    methods
        
        % ***** Constructor *****
        function obj = joint(bonea,boneb,romin,standpos,angleres)
            
            % set default ROMs if none provided
            if ~exist('rom')
                obj.rom = [180,180,180];
            else
                obj.sag_rom = rom;
            end
            
            if ~exist('standpos')
                obj.standing_pos = [0,0,0];
            else
                obj.standing_pos = standpos;
            end
            
            if isstr(bonea)&&isstr(boneb)
                obj.bone_a = bonea;
                obj.bone_b = boneb;
            else
                error('Value must be the name of a bone')
            end        
            if ~exist('angle_res')
                obj.angle_res = 1; % default to 1 degree.
            else
                obj.angle_res = angleres;
            end
            
        end
        
        % flexion
        function [joint_angle] = flex(joint, start_pos, travel)
            
            joint_angle = start_pos : -joint.angle_res : start_pos-travel;
            
        end
        
        % extension
        function [new_sag, new_trans, new_horz] = extend(joint, start_angle_sag, start_angle_trans, start_angle_horz, sag_travel, trans_travel, horz_travel)
            
            new_sag = min(start_angle_sag + sag_travel,joint.sag_rom);
            new_trans = min(start_angle_trans + trans_travel,joint.trans_rom);
            new_horz = min(start_angle_horz + horz_travel,joint.horz_rom);
            
        end
    end
    
end

