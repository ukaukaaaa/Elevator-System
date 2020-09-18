classdef elevatorClass
    properties (Access = public)
        door;
        workstate;
        direction;
        level;
        buttonApp;
        elevatorApp;
        db;
        ct;
    end

    methods (Access = public)
        function determinDirection(dt,floorr)
            if floorr < dt.level
                dt.direction = 'd';
                dt.movedown();
            elseif floorr > dt.level
                dt.direction = 'u';
                dt.moveup();
            else
                dt.direction = 's';
                dt.openDoor();
            end
        end

    end



end