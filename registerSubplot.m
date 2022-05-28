function p = registerSubplot(pos,t,xl,yl,yli)
%REGISTERSUBPLOT Summary of this function goes here
%   Detailed explanation goes here

subplot(pos(1), pos(2), pos(3));
p = plot(1:10,zeros(1,10),'-','Color','b');
title(t);
xlabel(xl);
ylabel(yl);
ylim(yli);
end

