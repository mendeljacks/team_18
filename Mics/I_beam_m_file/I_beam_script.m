% Script file:
% JUST RUN THE CODE AND YOU ARE GOOD TO GO
% ENSURE THAT YOU CHANGE THE INPUTS BASED ON SPECIFICATIONS
% NOTE: The units implemneted in this script is N/mm^2
% Hence, forces are in N, all distances in mm and all stresses in MPa

% PLEASE NOTE:
% - h: represented through the row number
% - w: represented through the column number

%% Defining system inputs
clear all; close all; clc;
sigma = 100; % Max stress not allowed to exceed
F     = 100e3; % Force applied
dist  = [100, 1000, 2000, 3000, 4000]; % Distance from force applied  

t = 10; % Thickness of I-beam
h = 1:1:1000-2*t; % Height of I-beam 
w = 1:1:1000-2*t; % width of I-beam 

tol = 2.00; % tolerance for the system (how close we want our desired shear modulus to be to the limit)

%% Calling the ibeamfunct function
% Input desired distance in the function: i.e. dist(1), dist(2), etc
[zShear, zInt, XSA, y, Ix, geom] = ibeamfunct(sigma, F, t, h, w, dist(4), tol);

%% Determining the ideal geometry for the given dist requirement
[M,I] = max(geom(:,:));
[row_h,col_w] = find(geom == max(M));

% Input desired distance in the fprintf: i.e. dist(1), dist(2), etc
fprintf(' height (h): %4.0f \n width (w): %4.0f \n distance (dist) from force applied: %4.0f \n', row_h, col_w, dist(4))

