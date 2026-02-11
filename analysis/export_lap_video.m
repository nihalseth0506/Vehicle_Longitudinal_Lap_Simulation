%% Setup paths and run simulation
addpath(genpath(pwd));

simOut = sim('vehicle_longitudinal');

%% Extract logged data
s_log    = simOut.s_log;
v_log    = simOut.v_log;
Fbrake   = simOut.Fbrake_log;
lapDone  = simOut.lap_done_log;
t        = simOut.tout;

lap_idx = find(diff(lapDone) == 1, 1, 'first');
if isempty(lap_idx)
    lap_idx = length(t);
end

s_log  = s_log(1:lap_idx);
v_log  = v_log(1:lap_idx);
Fbrake = Fbrake(1:lap_idx);
t      = t(1:lap_idx);

gear_log = double(simOut.gear_log);
gear_log = gear_log(1:lap_idx);

%% Build track geometry
trackXY = track_geometry(track);

x_track = trackXY.x;
y_track = trackXY.y;

track_width = 12; % meters

nx = -sin(trackXY.psi);  % normal vector x
ny =  cos(trackXY.psi);  % normal vector y

x_left  = x_track + track_width/2 * nx;
y_left  = y_track + track_width/2 * ny;

x_right = x_track - track_width/2 * nx;
y_right = y_track - track_width/2 * ny;

%% Interpolate car state along track
x_car   = interp1(trackXY.s, x_track, s_log, 'linear', 'extrap');
y_car   = interp1(trackXY.s, y_track, s_log, 'linear', 'extrap');
psi_car = interp1(trackXY.s, trackXY.psi, s_log, 'linear', 'extrap');

%% Normalize speed for coloring
v_min = min(v_log);
v_max = max(v_log);
v_norm = (v_log - v_min) / (v_max - v_min);

%% Create figure
figure('Color','w');
plot(x_left,  y_left,  'k', 'LineWidth', 2); hold on;
plot(x_right, y_right, 'k', 'LineWidth', 2);

fill([x_left; flipud(x_right)], ...
     [y_left; flipud(y_right)], ...
     [0.7 0.7 0.7], 'EdgeColor','none');


car_plot = plot(x_car(1), y_car(1), 'o', ...
    'MarkerSize', 8, ...
    'MarkerFaceColor', 'b', ...
    'MarkerEdgeColor', 'b');

arrow_length = 10;

car_arrow = quiver( ...
    x_car(1), y_car(1), ...
    arrow_length*cos(psi_car(1)), ...
    arrow_length*sin(psi_car(1)), ...
    0, 'r', 'LineWidth', 2);

speed_text = text(x_car(1), y_car(1), '', ...
    'FontSize', 10, 'FontWeight', 'bold');

axis equal;
grid on;
xlabel('X [m]');
ylabel('Y [m]');
title('2D Lap Simulation with Speed & Braking Visualization');

%% Speed color legend (manual colorbar)
colormap(jet);
cb = colorbar;
cb.Label.String = 'Normalized Speed';
clim([0 1]);

%% Animation parameters
playback_speed = 1.0;   % smaller = slower animation
pause_min = 0.01;

%% Animate
% Finer time grid
t_fine = linspace(t(1), t(end), 5*length(t));

% Interpolate distance and signals in time
s_fine   = interp1(t, s_log, t_fine);
v_fine   = interp1(t, v_log, t_fine);
F_fine   = interp1(t, Fbrake, t_fine);

% Now map distance to geometry (this preserves track consistency)
x_fine   = interp1(trackXY.s, x_track, s_fine, 'linear', 'extrap');
y_fine   = interp1(trackXY.s, y_track, s_fine, 'linear', 'extrap');
psi_fine = interp1(trackXY.s, trackXY.psi, s_fine, 'linear', 'extrap');
gear_fine = interp1(t, gear_log, t_fine, 'previous');

v_norm_fine = (v_fine - v_min) / (v_max - v_min);

% Create video
video_name = 'results/02_Lap_Animation.mp4';
vWriter = VideoWriter(video_name, 'MPEG-4');
vWriter.FrameRate = 15;
open(vWriter);
set(gcf,'Position',[100 100 1920 1080])

for i = 2:length(t_fine)

    car_color = [v_norm_fine(i), 0, 1 - v_norm_fine(i)];

    if F_fine(i) > 1
        edge_color = 'k';
    else
        edge_color = car_color;
    end

    set(car_plot, ...
        'XData', x_fine(i), ...
        'YData', y_fine(i), ...
        'MarkerFaceColor', car_color, ...
        'MarkerEdgeColor', edge_color);

    set(car_arrow, ...
        'XData', x_fine(i), ...
        'YData', y_fine(i), ...
        'UData', arrow_length*cos(psi_fine(i)), ...
        'VData', arrow_length*sin(psi_fine(i)));

    set(speed_text, ...
        'Position', [x_fine(i)+2, y_fine(i)+2], ...
        'String', sprintf('%.1f m/s | G%d', v_fine(i), round(gear_fine(i))));

    drawnow limitrate;
    
    % capture frame
    frame = getframe(gcf);
    writeVideo(vWriter, frame);

    pause((t_fine(i)-t_fine(i-1))/playback_speed);
end

close(vWriter);
disp('Video saved successfully.');