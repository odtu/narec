function [ N_primary, N_secondary ] = number_of_turns(frequency, V_primary, V_secondary, Bmax, core_thickness )
%Determines the number of turns

N_primary = round( V_primary / ((2*pi/sqrt(2))*frequency*Bmax*(core_thickness)^2*1e-6));
N_secondary = round( V_secondary / ((2*pi/sqrt(2))*frequency*Bmax*(core_thickness)^2*1e-6));;



end


