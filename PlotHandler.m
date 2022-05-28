classdef PlotHandler < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Title;
        Fig;
    end
    
    methods
        function obj = PlotHandler(title)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.Title = title;
            obj.Fig = figure('Name', title);
        end
        
        function update(obj,x,y)

            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            
            figure(obj.Fig);
            plot(x,y,'-','Color','b')
            drawnow
        end
    end
end

