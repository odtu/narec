clc;
clear all
%All dimensions in mm

%Transformer specifications
f_switching = 16; %Switching frequency
Operating_temp = 110;
Bmax = 1.1; %Maximum operating flux density (T)
Jmax = 4; %Primary maximum current density (A/mm2)
primary.fill_factor = 0.6; %Excluding the outer insulation or the insulation between HV-LV side
secondary.fill_factor = 0.5; %Excluding the outer insulation or the insulation between HV-LV side

primary.voltage = 16e3;
primary.current = 100;
secondary.voltage = 160e3;
secondary.current = primary.voltage*primary.current / secondary.voltage;

%Core Cross Section
core.thickness = 50;
core.depth = core.thickness; % Square profile core


primary.N_turns = round( primary.voltage / ((2*pi/sqrt(2))*f_switching*Bmax*core.depth*core.thickness*1e-6));
secondary.N_turns = round(primary.N_turns * secondary.voltage/primary.voltage);

turn_ratio = secondary.N_turns/primary.N_turns;    %Secondary-to-primary Step-up transformer


primary.coil_area = primary.current/Jmax; %copper cross section area mm2
primary.winding_area = primary.coil_area * primary.N_turns / primary.fill_factor; 

secondary.coil_area = secondary.current/Jmax; %copper cross section area mm2
secondary.winding_area = secondary.coil_area * secondary.N_turns / secondary.fill_factor; 


%Insulation Dimensions
primary.inner_insulation = 10; % LV insulation between winding and core
primary.outer_insulation = 10; % LV last layer of insulation between winding and air
primary.gap_between_secondary = 50; % horizontal gap between LV and HV side

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

%Winding aspect ratio
primary.winding_aspect_ratio = 3; % height to width ratio. 1 means square winding

primary.winding_width = round(sqrt(primary.winding_area/primary.winding_aspect_ratio));
primary.winding_height = round(primary.winding_width*primary.winding_aspect_ratio);

primary.total_height = primary.winding_height + 2*primary.outer_insulation;
primary.total_width = primary.winding_width + primary.outer_insulation + primary.inner_insulation;

%Assume the height of primary and secondary are equal
secondary.total_height = primary.total_height;
secondary.winding_height = secondary.total_height - 2*secondary.outer_insulation;
secondary.winding_width = round(secondary.winding_area/secondary.winding_height);
secondary.total_width = secondary.winding_width + secondary.outer_insulation + secondary.inner_insulation;


%Core Gap - Volume - Mass
core.horizontal_gap = 0.2*core.thickness + primary.total_width + primary.gap_between_secondary + secondary.total_width;
%0.2 for gap between round isolation and square core, (sqrt(2)-1)/2
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
core.density = 7.35; % Material: Vitroperm  g/cm3
core.volume = core.depth * ((core.height * core.width) - (core.horizontal_gap * core.vertical_gap));
core.mass = core.volume * core.density/1e6; % Kg



%Coil Resistance
primary.winding_Rin = core.thickness/sqrt(2) + primary.inner_insulation;
primary.winding_Rout = primary.winding_Rin + primary.winding_width;
primary.winding_Rmean = 0.5*(primary.winding_Rin + primary.winding_Rout);

secondary.winding_Rin = core.thickness/sqrt(2) + secondary.inner_insulation;
secondary.winding_Rout = secondary.winding_Rin + secondary.winding_width;
secondary.winding_Rmean = 0.5*(secondary.winding_Rin + secondary.winding_Rout);




