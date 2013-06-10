function rms = rootms(x)
    N = length(x);
    rms = sqrt(sum(x.* conj(x))/N);
end

