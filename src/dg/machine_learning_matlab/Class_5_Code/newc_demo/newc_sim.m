function y = newc_sim(p,s,w,b)
[r,q] = size(p);
for i = 1:q
    for j = 1:s
        d(j) = -1 * sqrt(sse(p(:,i)' - w(j,:)));
    end
    t = d' + b;
    [maxt,index] = max(t);
    y(i) = index;
end
    