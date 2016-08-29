function [w,b] = newc_train(p,s,n,w_lr,b_lr)

% NEWC_TRAIN Create a competitive layer.

% Syntax

% NET = NEWC_TRAIN(P,S,N,W_LR,B_LR)

%  Description
%
%    Competitive layers are used to solve classification problems.
%
%    NET = NEWC_TRAIN(P,S,N,W_LR,B_LR) takes these inputs,
%      P  - RxQ matrix of Q input vectors.
%      S  - Number of neurons.
%      N  - Max iter epochs,default = 100.
%      W_LR - Kohonen learning rate, default = 0.01.
%      B_LR - Conscience learning rate, default = 0.001.
%    Returns
%      W  - S*R weight matrix.
%      B  - S*1 bias vector.
%
%  Examples
%
%    Here is a set of four two-element vectors P.
%
%      P = [.1 .8  .1 .9; .2 .9 .1 .8];
%
%    To competitive layer can be used to divide these inputs
%    into two classes.  First a two neuron layer is created
%    with two input elements ranging from 0 to 1, then it
%    is trained.
%
%      net = newc_train(P,2);
%
%    The resulting network can then be simulated and its
%    output vectors converted to class indices.
%
%      Y = newc_sim(net,P)

% Lei Yu, 25-9-2010
% Copyright 1992-2010.

[r,q] = size(p);
% Initialize weight matrix. 
w = mean(minmax(p),2)';
w = repmat(w,[s 1]);
% Initialize bias vector.
b = ones(s,1) / s;
b = exp(1 - log(b));

for k = 1:n
    for i = 1:q
        for j = 1:s
            d(j) = -1 * sqrt(sse(p(:,i)' - w(j,:)));
        end
        t = d' + b;
        [maxt,index] = max(t);
        
        delta_w = w_lr * (p(:,i)' - w(index,:));
        w(index,:) = w(index,:) + delta_w;

        c = exp(1 - log(b));
        c = (1 - b_lr) * c + b_lr * t;
        delta_b = exp(1 - log(c)) - b;
        b = b + delta_b;
    end
end
        