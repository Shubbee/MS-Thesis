D = 'C:\Users\shubh\Desktop\Thesis\east_data';
S = dir(fullfile(D,'east_vel*.mat'));
C = cell(1,numel(S));
Z = load(fullfile(D,S(1).name));
F = fieldnames(Z);
for k = 2:numel(S)
    T = load(fullfile(D,S(k).name));
    for n = 1:numel(F)
        Z.(F{n}) = cat(2, Z.(F{n}), T.(F{n})); % pick suitable dimension.
    end
end

save(fullfile(D,'east_VEL.mat'),'Z')

