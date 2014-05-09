function [ skin_depth ] = calculate_skin_depth( frequency )
%Calculates the skin depth for copper

global copper 
global permeability_air

skin_depth=sqrt(copper.resistivity/(pi*permeability_air*frequency)); %in m

end

