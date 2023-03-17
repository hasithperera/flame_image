
function [indx] = find_cross(signal,thresh,side,debug)
%   FIND_CROSS Summary of this function goes here
%   finds the intersection of two lines
%   designed to only handel curves with two intersectios

[max_sig,max_indx] = max(signal);
[min_1,min_indx] = min(signal(max_indx:end));
temp_prof = abs(signal - thresh);

if ~exist('debug','var')
     % third parameter does not exist, so default it to something
     debug = 0;
end


if (side==1)
    [min_1,min_indx] = min(temp_prof(max_indx:end));
    indx = min_indx + max_indx-1;
else
%      [min_1,min_indx] = min(temp_prof(1:max_indx));
% handel up to 3 crossing points
% fix for the original implimentation due to multiple crossings
% 3/17/23 - ahe

     [~,indx_t] = sort(temp_prof(1:max_indx));
     [indx_t2,~] = sort(indx_t(1:6));
     indx = indx_t2(1);
end

if (debug==1)
   fprintf("Debug mode\n")
   plot(signal,'o')
   hold on 
   plot(thresh*ones(size(temp_prof)))
   plot(indx,signal(indx),'o')
end

end