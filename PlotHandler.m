classdef PlotHandler < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Title;
        Ax;
        XLabel;
        YLabel;
        YLim;
    end

    methods
        function obj = PlotHandler(ax, title, xlabel, ylabel, ylim)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.Title = title;
            obj.Ax = ax;
            obj.XLabel = xlabel;
            obj.YLabel = ylabel;
            obj.YLim = ylim;
        end

        function update(obj,x,y)

            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here

            figure(obj.Fig);
            plot(x,y,'-','Color','b');
            title(obj.Title);
            xlabel(obj.XLabel);
            ylabel(obj.YLabel);
            ylim(obj.YLim);
            drawnow;
        end

        function close(obj)
            close(obj.Fig);
        end
    end
end

