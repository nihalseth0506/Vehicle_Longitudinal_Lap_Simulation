function trackXY = track_geometry(track)
% Generates 2D track centerline from curvature profile

s = track.s;
kappa = track.kappa;

N = length(s);

x = zeros(N,1);
y = zeros(N,1);
psi = zeros(N,1);   % heading angle

for i = 2:N
    ds = s(i) - s(i-1);
    psi(i) = psi(i-1) + kappa(i) * ds;   % heading update
    x(i) = x(i-1) + ds * cos(psi(i));
    y(i) = y(i-1) + ds * sin(psi(i));
end

x = x - linspace(0, x(end), length(x))';
y = y - linspace(0, y(end), length(y))';


trackXY.x = x;
trackXY.y = y;
trackXY.s = s;
trackXY.psi = psi;
end
