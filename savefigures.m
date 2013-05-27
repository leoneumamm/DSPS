options = {};
N = 1;
if exist('Pxx','var')
    options{N} = 'Pxx';
    N = N + 1;
end
if exist('Pxx_AR','var')
    options{N} = 'Pxx_AR';
    N = N + 1;
end