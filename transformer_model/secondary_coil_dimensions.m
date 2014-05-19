function [ diameter, conductor_area ] = secondary_coil_dimensions(input_current, Jmax )
%Determines the dimensions of the secondary coil, circular single conductor
%is assumed

surface_area=input_current/Jmax;

%Available circular conductor area sizes 
%from the international standards
available_sizes = [0.5, 0.75, 1, 1.5, 2.5, 4, 6, 10, 16, 25, 35, 50, 70, 95, 120, 150, 185]; %mm^2

%limit for skin effect can be added later

%choose the conductor area closest to available size
[~, id] = min(abs(available_sizes - surface_area));

conductor_area=available_sizes(id); %mm^2
diameter=2*sqrt(conductor_area/pi); %conductor diameter in mm

end

