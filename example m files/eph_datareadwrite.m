function [] = eph_datareadwrite()
% This file shows some examples of how to read and write data in MATLAB.
% Specifically: .mat, .csv, .xls, .txt, (image files), (figures)
% 
% ______________________________
% Engineering Peer Helpers 2016

% -------------------------------------------------------------------------
% .mat files - MATLAB-specific format
load('fisheriris.mat');  % load in a sample dataset which comes packaged with MATLAB
                         % we now have cell array 'species' and array 'meas' in the workspace
save('temp.mat','meas'); % save only the 'meas' variable to a separate .mat file in the current folder

% -------------------------------------------------------------------------
% .csv files - Comma Separated Value (minimalist Excel)
csvwrite('temp.csv',meas);  % write the 'meas' array to the .csv file
                            % cannot export 'species', to csv since it is not numeric (there are workarounds if you need: Google it!)
meas12 = csvread('temp.csv',0,0,[0,0,150-1,2-1]); % read the first 2 columns from temp.csv; use 'help csvread' for more information

% -------------------------------------------------------------------------
% .xls files - Excel files
xlswrite('temp.xls',meas);                    % write the 'meas' array to the first sheet in the .xls file
xlswrite('temp.xls',species);                 % write the 'species' cell array to the second sheet in the .xls file
xlswrite('temp.xls',species(1:50),'first50'); % write the first 50 strings in 'species' to a new sheet the .xls file called 'first50'
spe50 = xlsread('temp.xls',1);                % read the 'meas' data from the first sheet in the .xls file
[spe50num,spe50txt,spe50raw] = xlsread('temp.xls','first50'); % read the 50 strings from the new worksheet; use 'help xlsread' for more information
                                                              % note: xlsread separates the data as numeric (num), text as a cell array (txt), and combined as cell array (raw)
                                                              % so spe50num will be empty, and spe50txt and spe50raw will both contain the same data as the 'species' variable

% -------------------------------------------------------------------------
% .txt files - Text files
% these operations are exactly like in C
f = fopen('temp.txt','w+');           % create the file temp.txt (if does not exist), and create a file pointer to it ('f')
fprintf(f,'%0.1f ',meas(:,1));        % write the first collumn of 'meas' to the file as characters, separated by spaces, with 1 decimal precision and 0 leading zeros
fseek(f,0,'bof');                     % IMPORTANT: reset the file pointer to the beginning of the file
txt = char(fread(f,inf,'char',0))';   % read the contents of the file back again, as characters
txt2 = char(fread(f,inf,'uint8',0))'; % try to do the same thing without fseek to beginning of file ('bof'); txt2 will be empty: []
fclose(f);                            % VERY IMPORTANT: close the file pointer (allowing other programs to use the temp.txt)

% -------------------------------------------------------------------------
% (image) files - .jpeg/.jpg, .tiff/.tif, .png, .gif, .bmp, .ico, ...
I = imread('cameraman.tif');          % load a sample image which comes packaged with MATLAB, assign the matrix of pixels to 'I'
imwrite(I(:,1:end/2),'temp.tif');     % save the left half of the image as the image file temp.tif

% -------------------------------------------------------------------------
% MATLAB figures - Saving as an image for reports
imshow(I);                            % create a figure (could be subplots, etc.)
frame = getframe(gcf);                % get the data associated with the figure (gcf: 'get current figure' - a handle to the figure);
imwrite(frame.cdata,'temp.png');      % save the 'cdata' (rendered figure's colour pixels) as image temp.png
close(gcf);                           % close the current (same) figure
