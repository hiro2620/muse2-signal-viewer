classdef SubplotHandler < handle
    %FIGUREHANDLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Fig
        Plot
    end
    
    methods
        function obj = SubplotHandler(fig,pos,tit,xla,yla,yli)
            %FIGUREHANDLER Construct an instance of this class
            %   Detailed explanation goes here
            obj.Fig = fig;
            figure(obj.Fig);
            subplot(pos(1), pos(2), pos(3));
            obj.Plot = plot(1:10,zeros(1,10),'-','Color','b');
            title(tit);
            xlabel(xla);
            ylabel(yla);
            ylim(yli);
        end
        
        function update(obj, x, y)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            figure(obj.Fig);
            obj.Plot.XData = x;
            obj.Plot.YData = y;
        end

    end
end

