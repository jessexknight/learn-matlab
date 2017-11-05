function [] = eph_plottingprettily()
% This file demonstrates a few ways of manipulating plot and figure
% appearances in MATLAB.
% 
% ______________________________
% Engineering Peer Helpers 2016

% -------------------------------------------------------------------------
% load some sample data to work with
X = load('fisheriris.mat');
I = im2double(imread('rice.png'));
% parse some of the data for later
xx = X.meas(:,1);
yy = X.meas(:,2);
zz = X.meas(:,3);

figure(1); % initialize a figure (not necessary)

% -------------------------------------------------------------------------
% subplot 1
a(1) = subplot(1,3,1);  % first of 3 subplots (1 vertical x 3 horizontal); keep a handle to the axes: a(1)
p = plot(X.meas,'--');   % plot the raw data as dotted lines; keep a handle to the plot: p
set(p,'linewidth',2)    % edit another plot property, the size of the points, using p
title('Raw Data','fontsize',30,'fontname','Times New Roman'); % title the plot
set(a(1),'fontname','Times New Roman');                    % change the font of the axes to match
set(a(1),'xcolor','r','ycolor',[0.2,0.2,0.2]);             % color the x axis red and y axis dark gray
xlabel('Data Point (#)'); ylabel('Freature Value (au)');   % label the axes
legend({'Feature 1','Feature 2','Feature 3','Feature 4'}); % add a legend

% -------------------------------------------------------------------------
% subplot 2
a(2) = subplot(1,3,2);        % second of 3 subplots; keep a handle
p = plot3(xx,yy,zz,'o');      % plot 3 of the features in 3D as unconnected points
set(p,'markersize',10);       % edit size of the points properties
set(p,'markerfacecolor','k'); % fill in all points with a black centre
title('First 3 Features','fontsize',30,'fontname','Times New Roman'); % title the plot
xlabel('Feature 1 (x)');
ylabel('Feature 2 (y)');
zlabel('Feature 3 (z)');
grid('on');

% -------------------------------------------------------------------------
% subplot 3
a(3) = subplot(1,3,3);     % third of 3 subplots; keep a handle
surf(I,'facecolor','interp','edgecolor','interp');
colormap(jet);
colorbar;
title('Unrelated Image as Surface','fontsize',20,'fontname','Times New Roman'); % title the plot
zlim([-5,6]);        % expand the z-axis range to 
xlim([1,size(I,1)]); % tighten the x-axis range to fit exactly
ylim([1,size(I,1)]); % tighten the y-axis range to fit exactly
set(a(3),'xtick',[],'yticklabel',[]); % remove the x lines altogether and just the y number labels

% -------------------------------------------------------------------------
% position the axes
set(a(1),'position',[0.05,0.10,0.3,0.8]); % hand-position the axes
set(a(2),'position',[0.40,0.10,0.3,0.8]); % hand-position the axes
set(a(3),'position',[0.75,0.2,0.15,0.6]); % hand-position the axes
% positions: relative to the figure size; decimals from 0 to 1.
%            order: [left edge x, bottom edge y, width in x, height in y]
% note: it is good practice to create all your subplots, then move them around
%       because if they overlap during initialization, one may dissappear

% -------------------------------------------------------------------------
% figure properties
set(gcf,'position',[50,50,1200,600],'color',[0.7,0.7,0.8],...
        'ButtonDownFcn',...
        @(~,~,~)(eval('!start chrome "https://www.youtube.com/watch?v=dQw4w9WgXcQ"')));

disp('FIGURE PROPERTIES:');
get(gcf) % print out editable figure properties
disp('AXES PROPERTIES:');
get(gca) % print out editable axes properties (can have multiple axes per figure)
disp('PLOT PROPERTIES:');
get(p) % print out editable plot properties (can have multiple plots per axes)


