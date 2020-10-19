function [zShear, zInt, XSA, y, Ix, geom] = ibeamfunct(sigma, F, t, h, w, dist, tol)
%% Inputs:
% sigma : max allowable stress
% F     : force applied
% t     : thickness of I-beam
% h     : height of I-beam (NOTE: total height of I-beam = h + 2*t)
% w     : width of I-beam
% dist  : distance from force applied, requirement for bending moment
% calculation
% tol   : tolerance -> how much we want the chosen z value (zInt) to be
% over the minimum (we don't want too high as this leads to unnecessary mass)

%% Outputs:
% zShear : calculated shear modulus due to moment applied and max stress
% allowable (i.e. M / sigma)
% zInt   : calculated shear modulus due to inertia and distance from
% neutral axis (i.e. Ix / y)
% XSA    : cross sectional area of I-beam
% y      : distance from the neutral axis
% Ix     : inertia about the x-axis (i.e. inertia of the system due to symmetric loading condition)
% geom   : relationship b/w shear modulus and XSA (i.e. want to maximise)

%% Comments:
% (1) This code chunks seeks to find an optimal geometric configuration based
%     on dist

% (2) We want to maximise zInt -> i.e. since sigma = M / Z, since increasing Z
%     means decreasing sigma (which is ideal for our case)

% (3) For the zInt / XSA case, we want to minimize XSA (as small XSA means less mass) 
%     and maximise zInt (refer to (2) for explanation)

%% Code Chunk:
    M = F * dist; % calculating moment
    zShear = M / sigma; % calculating shear modulus based on given conditions

    for i = 1:length(h) % iterating through the height vector
        for j = 1:length(w) % iterating through the width vector
            XSA(i,j) = 2*t*w(j) + t*h(i); % calculating XSA for each h/w combination   
            Ix(i,j) = (t*h(i)^3)/12 + (w(j)/12)*((2*t+h(i))^3 - h(i)^3); % calculating Ix for each h/w combination
            y(i)  = h(i)/2 + t; % calculating y for each h combination 
            
            zInt(i,j) = Ix(i,j) / y(i); % calculating zInt for each Ix/y combination
            
            % Check to see if our zInt < zShear since this is not ideal
            if zInt(i,j) <= zShear
                zInt(i,j) = 0; 
            end 
            
            if zInt(i,j) >= tol * zShear
                zInt(i,j) = 0;
            end
            
            % Creating the relationship between zInt and XSA
            geom(i,j) = zInt(i,j) / XSA(i,j);  
        end 
    end
end