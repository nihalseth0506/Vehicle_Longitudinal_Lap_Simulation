%% Track Definition

% Track segments: [length (m), radius (m)]
% radius = Inf → straight

track.segments = [
    300   Inf
    150   90
    300   Inf
    150   50
    250   Inf
    100   -66
    180   Inf
    120   40
];

track.ds = 1; % Distance resolution [m]

% Generate distance and curvature
s = [];
kappa = [];

for i = 1:size(track.segments,1)
    L = track.segments(i,1);
    R = track.segments(i,2);

    s_seg = 0:track.ds:L;

    if isempty(s)
         s = s_seg;
    else
         s = [s, s(end) + s_seg(2:end)];
    end

    if isinf(R)
        kappa_seg = zeros(size(s_seg));
    else
        kappa_seg = ones(size(s_seg)) / R;
    end

    if isempty(kappa)
        kappa = kappa_seg;
    else
        kappa = [kappa, kappa_seg(2:end)];
    end

end

track.s = s;
track.kappa = kappa;
track.totalLength = s(end);
