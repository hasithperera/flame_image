
function [indx] = find_cross(signal,thresh,side)
%   FIND_CROSS Summary of this function goes here
%   finds the intersection of two lines
%   designed to only handel curves with two intersectios

[max_sig,max_indx] = max(signal);
[min_1,min_indx] = min(signal(max_indx:end));
temp_prof = abs(signal - thresh);

if (side==1)
    [min_1,min_indx] = min(temp_prof(max_indx:end));
    indx = min_indx + max_indx-1;
else
     [min_1,min_indx] = min(temp_prof(1:max_indx));
     indx = min_indx;
end

end

