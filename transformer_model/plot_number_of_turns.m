clc;
%_range=[400:50:5e3]; 
thickness_range=[100:10:400];
frequency = 2000;
V_primary = 3e3;
V_secondary = 300e3;
Bmax=1.1;

[N_primary_500,N_secondary_500]=arrayfun(@(x,y) number_of_turns(500,V_primary,V_secondary, Bmax,x), thickness_range);
[N_primary_1k,N_secondary_1k]=arrayfun(@(x,y) number_of_turns(1e3,V_primary,V_secondary, Bmax,x), thickness_range);
[N_primary_2k,N_secondary_2k]=arrayfun(@(x,y) number_of_turns(2e3,V_primary,V_secondary, Bmax,x), thickness_range);
[N_primary_5k,N_secondary_5k]=arrayfun(@(x,y) number_of_turns(5e3,V_primary,V_secondary, Bmax,x), thickness_range);


plot(thickness_range, N_primary_500,thickness_range, N_primary_1k,thickness_range, N_primary_2k,thickness_range, N_primary_5k, 'LineWidth',1)
xlabel('Core Thickness(mm)')
ylabel('Primary Number of Turns')
ylim([0 30])
xlim([100 400])
grid on
text(320,13,'500Hz')
text(250,11,'1kHz')
text(200,9,'2kHz')
text(150,6,'5kHz')
%text(3000,1.8,'Foil Coil Thickness')

set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize', [4 2.8]);
set(gcf,'PaperPosition',[0 0 4 2.8]);
set(gcf,'PaperPositionMode','Manual');
set(get(gca,'xlabel'),'FontSize', 12);
set(get(gca,'ylabel'),'FontSize', 12);
set(get(gca,'title'),'FontSize', 12);
set(gca,'FontSize',10);

print(gcf,'-dpdf','-r150','primary_Nturns_freq.pdf');


plot(thickness_range, N_secondary_500,thickness_range, N_secondary_1k,thickness_range, N_secondary_2k,thickness_range, N_secondary_5k, 'LineWidth',1)
xlabel('Core Thickness(mm)')
ylabel('Secondary Number of Turns')
grid on
ylim([0 3000])
text(320,1300,'500Hz')
text(250,1100,'1kHz')
text(200,900,'2kHz')
text(150,600,'5kHz')
%text(3000,1.8,'Foil Coil Thickness')

set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize', [4 2.8]);
set(gcf,'PaperPosition',[0 0 4 2.8]);
set(gcf,'PaperPositionMode','Manual');
set(get(gca,'xlabel'),'FontSize', 12);
set(get(gca,'ylabel'),'FontSize', 12);
set(get(gca,'title'),'FontSize', 12);
set(gca,'FontSize',10);

print(gcf,'-dpdf','-r150','secondary_Nturns_freq.pdf');

%% Effect of frequency with a core thickness of 180mm

frequency_range=[400:50:5e3]; 
%thickness=200;
V_primary = 3e3;
V_secondary = 300e3;
Bmax=1.1;

[N_primary_150,N_secondary_150]=arrayfun(@(x) number_of_turns(x,V_primary,V_secondary, Bmax,150), frequency_range);
[N_primary_200,N_secondary_200]=arrayfun(@(x) number_of_turns(x,V_primary,V_secondary, Bmax,200), frequency_range);
[N_primary_250,N_secondary_250]=arrayfun(@(x) number_of_turns(x,V_primary,V_secondary, Bmax,250), frequency_range);
[N_primary_300,N_secondary_300]=arrayfun(@(x) number_of_turns(x,V_primary,V_secondary, Bmax,300), frequency_range);


plot(frequency_range, N_primary_150,frequency_range, N_primary_200,frequency_range, N_primary_250,frequency_range, N_primary_300, 'LineWidth',1)
xlabel('Frequency (Hz)')
ylabel('Primary Number of Turns')
grid on
ylim([0 30])
text(2800,12,'150mm')
text(1600,11,'200mm')
text(1200,9,'250mm')
text(900,4,'300mm')
%text(3000,1.8,'Foil Coil Thickness')

set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize', [4 2.8]);
set(gcf,'PaperPosition',[0 0 4 2.8]);
set(gcf,'PaperPositionMode','Manual');
set(get(gca,'xlabel'),'FontSize', 12);
set(get(gca,'ylabel'),'FontSize', 12);
set(get(gca,'title'),'FontSize', 12);
set(gca,'FontSize',10);

print(gcf,'-dpdf','-r150','primary_Nturns_core.pdf');

plot(frequency_range, N_secondary_150, frequency_range, N_secondary_200,frequency_range, N_secondary_250,frequency_range, N_secondary_300, 'LineWidth',1)
xlabel('Frequency (Hz)')
ylabel('Secondary Number of Turns')
grid on
ylim([0 3000])
text(2800,1200,'150mm')
text(1600,1100,'200mm')
text(1200,900,'250mm')
text(900,400,'300mm')
%text(3000,1.8,'Foil Coil Thickness')

set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize', [4 2.8]);
set(gcf,'PaperPosition',[0 0 4 2.8]);
set(gcf,'PaperPositionMode','Manual');
set(get(gca,'xlabel'),'FontSize', 12);
set(get(gca,'ylabel'),'FontSize', 12);
set(get(gca,'title'),'FontSize', 12);
set(gca,'FontSize',10);

print(gcf,'-dpdf','-r150','secondary_Nturns_core.pdf');
