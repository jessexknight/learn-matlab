function [] = eph_commonerrors()
% This file gives a list of common MATLAB errors, and in the comments, the
% resulting error. When it is not obvious, additional information about how
% to fix the error is also given, separated by '-'.
% 
% ______________________________
% Engineering Peer Helpers 2016

% basic syntax errors
A = [1,3]        % Unbalanced or unexpected parenthesis or bracket.
A[1]             % Unbalanced or unexpected parenthesis or bracket.
A(1))            % Unbalanced or unexpected parenthesis or bracket.
A(1              % Expression or statement is incorrect--possibly unbalanced (, {, or [.
A = 1+2+         % Expression or statement is incomplete or incorrect.
#                % The input character is not valid in MATLAB statements or expressions.
$                % The input character is not valid in MATLAB statements or expressions.
`                % The input character is not valid in MATLAB statements or expressions.
"                % The input character is not valid in MATLAB statements or expressions.
A = 'hello world
% A MATLAB string constant is not terminated properly. - Finish the string with another '

% indexing errors
A = [1,3]
B(1)             % Undefined function or method 'B' for input arguments of type 'double'. - Need to define variable 'B' first
A(3)             % Attempted to access A(3); index out of bounds because numel(A)=2.
A(-1)            % Attempted to access A(-1); index must be a positive integer or logical.
A(1.5)           % Attempted to access A(1.5); index must be a positive integer or logical.
A(0)             % Attempted to access A(0); index must be a positive integer or logical.
A(2::)           % Unexpected MATLAB operator.
A(1,)            % Unbalanced or unexpected parenthesis or bracket.
A(2,end)         % Attempted to access A(2,2); index out of bounds because size(A)=[1,2].

% arithmetic errors
0/0              % (NaN): "not a number" - not really an error, for more information: help nan
1/0              % (inf): "infinity" - not really an error, for more information: help inf

% sizing errors
A = ones(2,2);
B = ones(2,3);
A.*B             % Matrix dimensions must agree. - Since this is an element-wise operation
A(2,:) = [3,4,5] % Subscripted assignment dimension mismatch. - Cannot assign 3 values to a 2-element row

% equality errors
a = 2;
if a = 3         % The expression to the left of the equals sign is not a valid target for an assignment. - Use == for logical comparison
end
if 'AA' == 'AAA' % Matrix dimensions must agree. - use strcmp('AA','AAA') to compare strings of different lengths
end

% function call errors
add(1,2);        % Undefined function or method 'add' for input arguments of type 'double'. - You can use '+', or 'plus(1,2)'
plot             % Not enough input arguments. - What are you trying to plot?

% loop errors
i = 0;
while(i < 10)    % (infinite loop) - press 'CTRL+C' to terminate; forgot to include 'i = i + 1;' within the loop
  disp('.');
end
for 1:10         % Unexpected MATLAB expression. - Need an iteration variable: 'for i = 1:10'
 disp('.')
end
