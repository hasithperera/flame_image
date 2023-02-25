% close all
% clear all

%% starage paths

img_data = "C:\Users\remote\Desktop\Susith_data\-7.00 KV\";
blank_data = "C:\Users\remote\Desktop\Susith_data\1.blank\";

%% read the images-flame,blank.
im_blank = imread(strcat(blank_data,"blank _00023.jpg"));
imgray2 = imread(strcat(img_data,'-7_00002.jpg'));
% 
% %% subtract Images
imgDiff = abs(imgray2 - im_blank);


% 
I = imgaussfilt(imgDiff,2);
% 
box = [737 1361 353 1296];
roi = I(box(3):box(4),box(1):box(2));

% imagesc(roi)
% colormap jet
% colorbar()
% 
% 
% figure()
% % width - calc test
% sig = sum(roi);

% height - calculation
sig = sum(roi');

baseline = mean(sig(end-100:end));
% plot(sig)
% hold on
s1 = sig-baseline;
plot(s1,'.-')
hold on
low_thresh = .1;
high_thresh = .2;

[max_sig,max_indx] = max(s1);

low_flame_lim = max_sig * low_thresh;
max_flame_lim = max_sig * high_thresh;
 
yy = ones(800,1);

plot(1:800,yy*low_flame_lim)
plot(1:800,yy*max_flame_lim)

i_l = find_cross(s1,low_flame_lim,1);
plot(i_l,s1(i_l),'o','LineWidth',4);
 
i_h = find_cross(s1,max_flame_lim,0);
plot(i_h,s1(i_h),'o','LineWidth',4);

fprintf('%d,%d\n',i_l,i_h)


figure(2)

imagesc(roi)
colormap jet
hold on 

xx = 1:size(roi,1);
plot(xx,i_l*ones(size(xx)),'white','Linewidth',3)
plot(xx,i_h*ones(size(xx)),'white','Linewidth',3)
