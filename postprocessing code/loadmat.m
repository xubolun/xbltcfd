function[loaddata] = loadmat(fnameh)
% dump the data in .mat files into workspace

fname = sprintf('%s%s%s','results/',fnameh,'.mat');

rslt_data = load(fname);

name = fieldnames(rslt_data);

nstr = char(name);

strtname = char(who('rslt_data'));

Vname = sprintf('%s%s%s',strtname, '.',nstr);

loaddata = eval(Vname);
end