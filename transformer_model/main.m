clc;
clear all

%% Transformer specifications
%All dimensions in mm

frequency = 2000; %Operating frequency
primary.voltage = 3e3;
rated_power = 6.5e6; % 6.5 MVA transformer pf=1
secondary.voltage = 300e3;

primary.N_turns = 5;

%% Flux Current Insulation
Bmax = 1.1; %Maximum operating flux density (T)
Jmax = 4; %Primary maximum current density in the copper (A/mm2)
operating_temp = 110; %C

%Insulation
% Insulation Dimensions
primary.insulation_between_coils = 1; %Insulation thickness between two adjacent coils
primary.inner_insulation = 10; % LV insulation between winding and core
primary.outer_insulation = 10; % LV last layer of insulation between winding and air

primary.gap_between_secondary = 50; % horizontal gap between LV and HV side

secondary.insulation_between_coils = 5; %Insulation thickness between two adjacent coils
secondary.inner_insulation = 20; % HV insulation between winding and core
secondary.outer_insulation = 20; % HV last layer of insulation between winding and air
%{
                                       +----------------+
                                       |
                                       |
                    Outer Insulation   |
                                       +               +----+
                         ^             |               |
                         |             |               |
               +---------|-------------+               +-----------------------+
               |         +             |               |                       |
               |  +-----------------+  |               |  +-----------------+  |
               |  |                 |  |               |  |                 |  |
               |  |                 |  |               |  |                 |  |
               |  |                 |  |   CORE        |  |                 |  |
               |  |    Coil(+)      |  |               |  |   Coil (-)      |  |
               |  |                 |  |               |  |                 |  |
               |  |                 |  |               |  |                 |  |
            ^  |  +-----------------+  |               |  +-----------------+  |
 Insulation +  |                       |               |                       |
 Thickness  v  +-----------------------+               +-----------------------+
                                       |               |
                                       +               +
                                       |               +-----+
                                       |
                                       |
                                       |
                                       +--------------------------+
%}

%% Transformer calculations
primary.current = rated_power/primary.voltage; 
secondary.current = primary.voltage*primary.current / secondary.voltage;

secondary.N_turns = primary.N_turns*secondary.voltage/primary.voltage;
turn_ratio = secondary.N_turns/primary.N_turns;    %Secondary-to-primary Step-up transformer

%% Constants
global copper core permeability_air

core.density = 7.35; % Material: Vitroperm  g/cm3

copper.resistivity = 1.68e-8; %copper resistivity(Ohm.m) at 20 C
copper.temp_coefficient = 0.003863; % K^-1 temperature coefficient for resistivity 
permeability_air=4*pi*1e-7;

%% Calculate Core Dimensions
core.cross_section = primary.voltage / ((2*pi/sqrt(2))*frequency*Bmax*primary.N_turns); %in m^2

%Assuming square cross section
core.thickness = ceil(sqrt(core.cross_section)*1e3); %in mm
core.depth = core.thickness; % Square profile core

%% Winding dimensions

%Primary Foil coil height and thickness
[primary.coil_height, primary.coil_thickness]=primary_coil_dimensions(frequency, primary.current, Jmax);

primary.winding_width = primary.N_turns * (primary.coil_thickness+primary.insulation_between_coils);
primary.winding_Rin = core.thickness/sqrt(2) + primary.inner_insulation;
primary.mean_coil_length = 2*pi*(primary.winding_Rin + 0.5*primary.winding_width);
primary.Rout = primary.winding_Rin + primary.winding_width + primary.outer_insulation;

primary.total_height = primary.coil_height + 2*primary.outer_insulation;

%Secondary
[secondary.coil_diameter, secondary.coil_area]=primary_coil_dimensions(frequency, secondary.current, Jmax);
%Dowell's Porosity Factor functions to be added


secondary.winding_width = 200; %Degisecek!!!!
secondary.winding_Rin = core.thickness/sqrt(2) + secondary.inner_insulation;
%secondary.mean_coil_length = 2*pi*(secondary.winding_Rin + 0.5*primary.winding_width);
secondary.Rout = secondary.winding_Rin + secondary.winding_width + secondary.outer_insulation;
%Assume the height of primary and secondary are equal
secondary.total_height = primary.total_height;
secondary.winding_height = secondary.total_height - 2*secondary.outer_insulation;
%secondary.winding_width = round(secondary.winding_area/secondary.winding_height);


%% Core Gap - Volume - Mass
core.horizontal_gap = primary.Rout + secondary.Rout + primary.gap_between_secondary - core.thickness;
core.vertical_gap = primary.total_height;
core.height = core.vertical_gap + 2 * core.thickness;
core.width = core.horizontal_gap + 2 * core.thickness;
%{
                                         / 
                                        / Depth
                                       /      
        +-----------------------------+
        |                             |     ^
        |                             |     |
        |     +-----------------+     |     |
        |     |                 |     |     |
        |     |                 |     |     |
        |     |                 |     |     |
        |     |                 |     |     + height
        |     |                 |     |     |
        |<-+->|Thickness        |     |     |
        |     |                 |     |     |
        |     +-----------------+     |     |
        |                             |     |
        |                             |     |
        +-----------------------------+     v

        <-------------+--------------->
                  Width  
%}
%Calculate Core Volume
core.volume = core.depth * ((core.height * core.width) - (core.horizontal_gap * core.vertical_gap));
core.mass = core.volume * core.density/1e6; % Kg

%% Coil Resistance

%Get AC resistance (including eddy losses)
primary.R_ac = get_AC_resistance( primary.mean_coil_length, primary.coil_height, primary.coil_thickness, primary.N_turns, frequency);


%DC Resistance
%primary.dc_resistance = (primary.mean_coil_length * primary.N_turns / primary.coil_area)*1e3*(copper.resistivity*(1+(operating_temp-20)*copper.temp_coefficient));
%secondary.dc_resistance = (secondary.mean_coil_length * secondary.N_turns / secondary.coil_area)*1e3*(copper.resistivity*(1+(operating_temp-20)*copper.temp_coefficient));
%%

