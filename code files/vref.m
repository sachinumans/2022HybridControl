function [v_ref] = vref(alpha,t)
% Return the reference velocity as specified in Q2.9
if t<=3
    v_ref=0.85*alpha;
elseif t<=9
    v_ref=1.2*alpha;
elseif t<=15
    v_ref=1.2*alpha-1/12*alpha*(t-9);
elseif t<=18
    v_ref=0.7*alpha;
elseif t<=21
    v_ref=0.7*alpha+4/15*alpha*(t-18);
elseif t<=30
    v_ref=0.9*alpha;
end