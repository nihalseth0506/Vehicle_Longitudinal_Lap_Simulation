% Run simulation
simOut = sim('vehicle_longitudinal');

% Extract logged data
s       = simOut.s_log;
v       = simOut.v_log;
vmax    = simOut.vmax_log;
Fbrake  = simOut.Fbrake_log;
lapTime = simOut.lap_time_log;
lapDone = simOut.lap_done_log;
t       = simOut.tout;

% Find lap completion
lap_idx = find(diff(lapDone) == 1, 1, 'first');
if isempty(lap_idx)
    lap_idx = length(s);
end

s       = s(1:lap_idx);
v       = v(1:lap_idx);
vmax    = vmax(1:lap_idx);
Fbrake  = Fbrake(1:lap_idx);
lapTime = lapTime(1:lap_idx);

figure('Color','w','Position',[100 100 1400 700])

% 1 Speed vs Distance
subplot(2,3,1)
plot(s,v,'LineWidth',1.8); hold on
plot(s,vmax,'--','LineWidth',1.5)
title('Speed Profile')
xlabel('Distance [m]')
ylabel('Speed [m/s]')
legend('Vehicle','Limit')
grid on

% 2 Brake
subplot(2,3,2)
plot(s,Fbrake,'LineWidth',1.8)
title('Braking Force')
xlabel('Distance [m]')
ylabel('Force [N]')
ylim([0 17000])
grid on

% 3 Gear
subplot(2,3,3)
stairs(s,gear(1:lap_idx),'LineWidth',1.8)
title('Gear Selection')
xlabel('Distance [m]')
ylabel('Gear')
ylim([0 7])
grid on

% 4 Speed vs Time
subplot(2,3,4)
plot(t(1:lap_idx),v,'LineWidth',1.8)
title('Speed vs Time')
xlabel('Time [s]')
ylabel('Speed [m/s]')
grid on

% 5 Distance vs Time
subplot(2,3,5)
plot(t(1:lap_idx),s,'LineWidth',1.8)
title('Distance vs Time')
xlabel('Time [s]')
ylabel('Distance [m]')
grid on

% 6 Lap summary
subplot(2,3,6)
axis off
text(0.1,0.7,['Lap Time: ', num2str(lap_time_value),' s'],'FontSize',14,'FontWeight','bold')
text(0.1,0.5,['Max Speed: ', num2str(max(v)),' m/s'],'FontSize',12)
text(0.1,0.3,['Max Brake: ', num2str(max(Fbrake)),' N'],'FontSize',12)

set_param('vehicle_longitudinal','ZoomFactor','FitSystem')

print('-svehicle_longitudinal','-dpng','-r300','results/01_System_Architecture.png')
print('-svehicle_longitudinal','-dpdf','results/01_System_Architecture.pdf')



