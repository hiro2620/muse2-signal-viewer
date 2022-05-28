function res = floorMul(x,p)
%FLOORMUL x以上で最小のpの倍数
res = fix((x + p - 1) / p) * p;
end

