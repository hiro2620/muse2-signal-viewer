t = 1:0.001:2;
x = sin(2*pi*t);
figure
hold on
axis([1 2 -1 1])
for i=1:numel(t)
    plot(t(i),x(i),'.','Color','b')
    drawnow
end