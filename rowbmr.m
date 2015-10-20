function [ bmr,paceburn ] = rowbmr(age,weight,watts)
%ROWBMR Summary of this function goes here
%   Detailed explanation goes here

if age<=17
    bmr = 17.7*weight + 657
elseif age<=29 && age>=18
    bmr = 15.1*weight + 692
elseif age<=59 && age>=30
    bmr = 11.5*weight + 893
elseif age<=74 && age>=60
    bmr = 11.9*weight + 700
elseif age>=75
    bmr = 8.4*weight + 821
end

hourlyrate = bmr/24;



end

