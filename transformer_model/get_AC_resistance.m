function [ R_ac ] = get_AC_resistance( Lmean, height, thickness, Nturns, frequency)
%Calculate AC resistance in a foil-type conductor (for primary winding)
%all dimensions are in mm

%   Dowell's Equations from:
%Irma Villar. Multiphysical characterization of medium-frequency power electronic transformers. 
%Phd dissertation, École Polytechnique Federale de Lausanne, 2010.

skin_depth=calculate_skin_depth(frequency);


delta = thickness*1e-3/skin_depth;

sigma1=(sinh(2*delta)+sin(2*delta))/(cosh(2*delta)-cos(2*delta));

sigma2=(sinh(delta)-sin(delta))/(cosh(delta)+cos(delta));

%calculate resistance
copper.resistivity = 1.68e-8; %copper resistivity(Ohm.m) at 20 C

%dimensions are in mm convert to m
copper.resistivity = 1.68e-8; %copper resistivity(Ohm.m) at 20 C

R_ac= copper.resistivity*(Lmean*1e-3)/(height*1e-3*skin_depth)*Nturns*(sigma1 + (2/3)*(Nturns^2-1)*sigma2); %in Ohms


end

