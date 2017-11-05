function [] = eph_examples()
% This file contains a few examples of simple matlab uses. Each example and the 
% associated functions are contained in the subsections below.
% 
% ______________________________
% Engineering Peer Helpers 2016

% each of these lines calls a function below
% which takes no inputs and produces no outputs
% i.e. function [] = function_name()
% comment out any of the functions to skip them

%sines;         % topics: vectors, loops, plotting
%cointoss;      % topics: vectors, loops, random numbers, plotting, drawnow
%fibonacci;     % topics: functions, logic, log plots, axes handles, legends
%discoveringpi; % topics: vectors, loops, logic, random, drawnow, keyboard

% ------------------------------------------------------------------------------
% plotting sinusoids

function [] = sines()
% constants
phase = pi/2;
% vector: elements must be the same type (e.g. numbers)
t = 0:0.01:5;
% 2-element vector: the magnituds of each sine
M = [1,3];

% Next, the output for each parameter set will be calculated 3 different ways
% The 1st method is easiest to understand
% The 2nd method is a good balance
% The 3rd method is fastest

% Method 1: element wise
S1 = zeros(size(t));
for i = 1:numel(t);
  % Compute the sine using teach element of t: t(i)
  % the required values are passed as input arguments
  % and the function returns the pressure as an output argument.
  S1(i) = M(1).*sin(2*pi*t(i) + phase);
end

% Method 2: vector wise (all at once!)
% note the (.*), (./) and (.^) notation:
% these operations can be applied to all elements of the vector V simultaneously
% the (.) is not necessary for adding (+) or subtracting (-)
S2 = M(2).*sin(2*pi*t + phase);

% plot the results
figure;
hold on;
plot(t,S1,'b'); % plot in blue
plot(t,S2,'r'); % plot in red
% add a legend 'north-west' = 'nw' (top right)
% using the 2-element cell corresponding to each line we drew
names = {'System 1','System 2'};
legend(names,'location','nw');
title('Some lovely sines');
xlabel('time (s)');
ylabel('output (moots)');

% ------------------------------------------------------------------------------
% coin toss live plot

function [] = cointoss()

% initialize the variables
N = 2000;              % total number of tosses
heads = 0;             % number of heads so far
pheads = zeros([N,1]); % probability of heads vs time.

% initialize the axis
figure;
hold on;
title('Law of Averages: Coin Toss Edition');
xlim([0,N]);            ylim([0.3,0.7]);
xlabel('Coin Tosses');  ylabel('Heads Proportion');

% simulate the tosses and plot the results (live update)
for t = 1:N
  % flip the coin, update the cumulative proportion of heads
  % (there are other ways of doing this!)
  % rand(N) draws an array sized NxN of random numbers between 0 and 1
  heads     = heads + round(rand(1));
  pheads(t) = heads / t;
  % update the plot every 10 tosses
  if mod(t,10) == 0;
    cla;         % clear the axis
    hold on;     % allow us to plot twice or more
    plot([0,N],[0.5,0.5],'k:');  % plot a black dotted line at 0.5
    plot(1:t,pheads(1:t));       % plot the cumulative probability of heads
    drawnow;     % this renders the figure immediately
    pause(0.01); % this waits 0.01s so we can see what's happening
                 % don't leave this in if you just want the final result!
                 % try commenting out drawnow; and pause(0.01); - much faster
  end
end

% ------------------------------------------------------------------------------
% fibonacci testing

function [] = fibonacci()
N = 10000; % max number to test

% initialize the figure
figure;
% resize the figure:
% figresize is a function below, not a native matlab function
figresize(gcf,[980,420]);

% regular x:y plot
% store a handle to the axes so we can plot on it again
ax(1) = subplot(1,2,1);
plot(1:N,1:N);
xlabel('N'); ylabel('N');

% semi-logarithmic plot in x only
% neat result:
% frequency of numbers is ~linear in log space
ax(2) = subplot(1,2,2);
semilogx(1:N,1:N);
xlabel('N (log space)'); ylabel('N');

% run through the values and plot stem on both plots if we find a fibonacci
% there are other (faster) ways of doing this!
for n = 1:N
  if isfibonacci(n)
    hold(ax(1),'on');
    stem(n,n,'r','parent',ax(1));
    hold(ax(2),'on');
    stem(n,n,'r','parent',ax(2));
  end
end
% add some legends using the axes handles
legend(ax(1),'Numbers','Fibonacci Numbers');
legend(ax(2),'Numbers','Fibonacci Numbers');

function [isfib] = isfibonacci(num)
% neat identity:
% one or both of Q1 and Q2 must be perfect (integer) squares
% then num is a fibonacci number
Q1 = 5*(num.^2) + 4;
Q2 = 5*(num.^2) - 4;
% || is logical or
% && is logical and
% | and & (singles) can be use for vector operations
% similar to (*) vs (.*)
if (issquare(Q1) || issquare(Q2))
  isfib = 1;
else
  isfib = 0;
end

function [issq] = issquare(num)
root = round(sqrt(num));
if ((root*root) == num)
  issq = 1;
else
  issq = 0;
end

% ------------------------------------------------------------------------------
% discovering pi

function [] = discoveringpi()

N     = 500000;     % number of samples
batch = 1000;       % samples per update
allin = nan([N,1]); % logical: is sample in unit circle?

% initializing the figure
figure;
hold on;
axis('equal');
xlim([-1,+1]); ylim([-1,+1]);
xlabel('X');   ylabel('Y');
title('Estimating \pi');
% the text estimate in the middle of the figure
h = text(-.7,0,'\pi = yum','fontsize',30,'buttondownfcn',@clickfun);

for i = 1:N/batch
  
  % generate random coordinates on the interval [-1,+1]
  xb = 2*rand([batch,1]) - 1;
  yb = 2*rand([batch,1]) - 1;
  
  % check which are in the unit circle
  in = isinunitcircle(xb,yb);
  
  % estimate pi
  allin((i-1)*batch+1:i*batch) = in;
  estpi = estimatepi(allin);
  
  % plot the new points
  plot(xb( in),yb( in),'r.','markersize',1);
  plot(xb(~in),yb(~in),'b.','markersize',1);
  
  % update the estimate of pi
  set(h,'string',['\pi = ',num2str(estpi)]);
  uistack(h,'top');
  
  % refresh
  drawnow; pause(0.01);
end
fprintf(['Congratulations!\n',...
         'You made it to the end.\n',...
         'Your reward: you''re now stuck in this script.\n',...
         'To escape, type: "CTRL+C".\n',...
         'But maybe stop to check out the variables using "whos" first.\n']);
keyboard

function [in] = isinunitcircle(x,y)
% single point to test (Method 1)
if numel(x) == 1
  if ((x^2) + (y^2)) < 1
    in = 1;
  else
    in = 0;
  end
% better: vectorized (Method 2)
else
  % This method is much faster, and works for vectors of coordinates;
  % it is just more difficult to understand.
  % We return the result of the logical expression directly, avoiding if/else.
  in = ((x.^2) + (y.^2)) < 1;
end

function [estpi] = estimatepi(in)
% estimate pi from the ratio of points
% in the circle vs in the square
% pi*r^2   #(x,y) in O
% ------ = ------------
%  4*r^2   #(x,y) in []
estpi = 4*mean(in(~isnan(in)));

% ------------------------------------------------------------------------------
% miscellaneous functions

function [] = figresize(h,fsize)
% resizes the current figure while maintaining roughly the same position.
cfpos    = get(h,'position');
sizediff = fsize-cfpos(3:4);
pos      = [cfpos(1:2)-sizediff/2,fsize];
set(h,'position',pos);

function [] = clickfun(varargin)
web('www.youtube.com/watch?v=dQw4w9WgXcQ','-browser');


