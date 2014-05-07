function [ height, thickness ] = primary_coil_dimensions(frequency, input_current, J )
%Determines the dimensions of the primary foil coil

surface_area=input_current/J;

copper.resistivity = 1.68e-8; %copper resistivity(Ohm.m) at 20 C
permeability_air=4*pi*1e-7;

skin_depth=sqrt(copper.resistivity/(pi*permeability_air*frequency))*1000; %in mm


%Available foil coil thicknesses (add more if necessary)
available_sizes = [0.5, 1, 1.6, 2, 2.25, 3.15, 4, 5, 6, 8]; %mm

%Thickness should be less than 1.5 x skin depth
max_thickness = skin_depth*1.5;

%choose the thickness closest to available size
[~, id] = min(abs(available_sizes - max_thickness));

thickness=available_sizes(id); %mm
height=round(surface_area/thickness);

end

