
freq_range=[400:50:5e3]; 

[H,T]=arrayfun(@(x) primary_coil_dimensions(x,2167,4), freq_range);

copper.resistivity = 1.68e-8; %copper resistivity(Ohm.m) at 20 C
permeability_air=4*pi*1e-7;
skin_depth=sqrt(copper.resistivity./(pi.*permeability_air.*freq_range)).*1000; %in mm

plot(freq_range, T, freq_range,skin_depth, 'LineWidth',1)
xlabel('Frequency (Hz)')
ylabel('Thickness (mm)')
grid on
text(3600,0.8,'Skin depth')
text(3000,1.8,'Foil Coil Thickness')

set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize', [4 2.8]);
set(gcf,'PaperPosition',[0 0 4 2.8]);
set(gcf,'PaperPositionMode','Manual');
set(get(gca,'xlabel'),'FontSize', 12);
set(get(gca,'ylabel'),'FontSize', 12);
set(get(gca,'title'),'FontSize', 12);
set(gca,'FontSize',10);

print(gcf,'-dpdf','-r150','primary_thickness.pdf');

%Coil Height
plot(freq_range, H,'LineWidth',1)
xlabel('Frequency (Hz)')
ylabel('Height (mm)')
grid on


set(gcf,'PaperUnits','inches');
set(gcf,'PaperSize', [4 2.8]);
set(gcf,'PaperPosition',[0 0 4 2.8]);
set(gcf,'PaperPositionMode','Manual');
set(get(gca,'xlabel'),'FontSize', 12);
set(get(gca,'ylabel'),'FontSize', 12);
set(get(gca,'title'),'FontSize', 12);
set(gca,'FontSize',10);

print(gcf,'-dpdf','-r150','primary_height.pdf');


