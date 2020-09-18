classdef  elevatorClass < handle
    properties (Access = public)
        door;
        level;
        state;
        direction;
        target;
        buttonUI;
        elevatorUI;
        db;
    end
    methods (Access = public)
        function openDoor(dt,num)
            switch num
                case 11
                    dt.buttonUI.F1_1_doorEditField.Value = 'open';
                    dt.elevatorUI.doorEditField.Value = 'open';
                    dt.door = 'open';
                    pause(2);
                    dt.buttonUI.F1_1_doorEditField.Value = 'close';
                    dt.elevatorUI.doorEditField.Value = 'close';
                    dt.door = 'close';
                case 12
                    dt.buttonUI.F1_2_doorEditField.Value = 'open';
                    dt.elevatorUI.doorEditField.Value = 'open';
                    dt.door = 'open';
                    pause(2);
                    dt.buttonUI.F1_2_doorEditField.Value = 'close';
                    dt.elevatorUI.doorEditField.Value = 'close';
                    dt.door = 'close';
                case 21
                    dt.buttonUI.F2_1_doorEditField.Value = 'open';
                    dt.elevatorUI.doorEditField.Value = 'open';
                    dt.door = 'open';
                    pause(2);
                    dt.buttonUI.F2_1_doorEditField.Value = 'close';
                    dt.elevatorUI.doorEditField.Value = 'close';
                    dt.door = 'close';
                case 22
                    dt.buttonUI.F2_2_doorEditField.Value = 'open';
                    dt.elevatorUI.doorEditField.Value = 'open';
                    dt.door = 'open';
                    pause(2);
                    dt.buttonUI.F2_2_doorEditField.Value = 'close';
                    dt.elevatorUI.doorEditField.Value = 'close';
                    dt.door = 'close';
                case 31
                    dt.buttonUI.F3_1_doorEditField.Value = 'open';
                    dt.elevatorUI.doorEditField.Value = 'open';
                    dt.door = 'open';
                    pause(2);
                    dt.buttonUI.F3_1_doorEditField.Value = 'close';
                    dt.elevatorUI.doorEditField.Value = 'close';
                    dt.door = 'close';
                case 32
                    dt.buttonUI.F3_2_doorEditField.Value = 'open';
                    dt.elevatorUI.doorEditField.Value = 'open';
                    dt.door = 'open';
                    pause(2);
                    dt.buttonUI.F3_2_doorEditField.Value = 'close';
                    dt.elevatorUI.doorEditField.Value = 'close';
                    dt.door = 'close';
            end
        end

        function ButtonFor1(dt,callFromLevel,num)
            while dt.level > callFromLevel
                pause(3);
                dt.level = dt.level - 1;
                dt.buttonUI.F1_1_EditField.Value = dt.buttonUI.F1_1_EditField.Value - 1;
                dt.buttonUI.F2_1_EditField.Value = dt.buttonUI.F2_1_EditField.Value - 1;
                dt.buttonUI.F3_1_EditField.Value = dt.buttonUI.F3_1_EditField.Value - 1;
                dt.elevatorUI.EditField.Value = dt.elevatorUI.EditField.Value - 1;
            end

            while dt.level < callFromLevel
                pause(3);
                dt.level = dt.level + 1;
                dt.buttonUI.F1_1_EditField.Value = dt.buttonUI.F1_1_EditField.Value + 1;
                dt.buttonUI.F2_1_EditField.Value = dt.buttonUI.F2_1_EditField.Value + 1;
                dt.buttonUI.F3_1_EditField.Value = dt.buttonUI.F3_1_EditField.Value + 1;
                dt.elevatorUI.EditField.Value = dt.elevatorUI.EditField.Value + 1;
            end

            pause(0.5);
            dt.openDoor(num);
        end

        function ButtonFor2(dt,callFromLevel,num)
            while dt.level > callFromLevel
                pause(3);
                dt.level = dt.level - 1;
                dt.buttonUI.F1_2_EditField.Value = dt.buttonUI.F1_2_EditField.Value - 1;
                dt.buttonUI.F2_2_EditField.Value = dt.buttonUI.F2_2_EditField.Value - 1;
                dt.buttonUI.F3_2_EditField.Value = dt.buttonUI.F3_2_EditField.Value - 1;
                dt.elevatorUI.EditField.Value = dt.elevatorUI.EditField.Value - 1;
            end

            while dt.level < callFromLevel
                pause(3);
                dt.level = dt.level + 1;
                dt.buttonUI.F1_2_EditField.Value = dt.buttonUI.F1_2_EditField.Value + 1;
                dt.buttonUI.F2_2_EditField.Value = dt.buttonUI.F2_2_EditField.Value + 1;
                dt.buttonUI.F3_2_EditField.Value = dt.buttonUI.F3_2_EditField.Value + 1;
                dt.elevatorUI.EditField.Value = dt.elevatorUI.EditField.Value + 1;
            end

            pause(0.5);
            dt.openDoor(num);
        end
        


        function updateTarget(dt,target)
            switch dt.direction
                case 'u'
                    if target > dt.target
                        dt.target = target;
                    end
                case 'd'
                    if target < dt.target
                        dt.target = target;
                    end

                case 's'
                    dt.target = target;
            end

        end

        function determinDirection(dt)
            if dt.target < dt.level
                dt.direction = 'd';
            elseif dt.target > dt.level
                dt.direction = 'u';
            else
                dt.direction = 's';
            end
        end

        function n = retreive_num(dt,dt_num)
            switch dt_num
                case 1
                    switch dt.level
                        case 1
                            n = 11;
                        case 2
                            n = 21;
                        case 3
                            n = 31;
                    end

                case 2
                    switch dt.level
                        case 1
                            n = 12;
                        case 2
                            n = 22;
                        case 3
                            n = 32;
                end

            end
        end

        function moveup(dt,dt_num)
            app.elevatorUI.Lamp.Color = [1,0,0];
            switch dt_num
                case 1
                    while dt.level < dt.target
                        if dt.db.checkdb(dt.level) == 1
                            dt.openDoor(dt.retreive_num(1));
                        end
                        pause(5);
                        dt.level = dt.level + 1;
                        dt.buttonUI.F1_1_EditField.Value = dt.buttonUI.F1_1_EditField.Value + 1;
                        dt.buttonUI.F2_1_EditField.Value = dt.buttonUI.F2_1_EditField.Value + 1;
                        dt.buttonUI.F3_1_EditField.Value = dt.buttonUI.F3_1_EditField.Value + 1;
                        dt.elevatorUI.EditField.Value = dt.elevatorUI.EditField.Value + 1;
                    end
        
                    pause(0.5);
                    dt.openDoor(dt.retreive_num(1));
                case 2
                    while dt.level < dt.target
                        if dt.db.checkdb(dt.level) == 1
                            dt.openDoor(retreive_num(2));
                        end
                        pause(5);
                        dt.level = dt.level + 1;
                        dt.buttonUI.F1_2_EditField.Value = dt.buttonUI.F1_2_EditField.Value + 1;
                        dt.buttonUI.F2_2_EditField.Value = dt.buttonUI.F2_2_EditField.Value + 1;
                        dt.buttonUI.F3_2_EditField.Value = dt.buttonUI.F3_2_EditField.Value + 1;
                        dt.elevatorUI.EditField.Value = dt.elevatorUI.EditField.Value + 1;
                    end
        
                    pause(0.5);
                    dt.openDoor(retreive_num(2));
            end
            app.elevatorUI.Lamp.Color = [0,0,0];
        end

        function movedown(dt,dt_num)
            switch dt_num
                case 1
                    while dt.level > dt.target
                        if dt.db.checkdb(dt.level) == 1
                            dt.openDoor(dt.retreive_num(1));
                        end
                        pause(3);
                        dt.level = dt.level - 1;
                        dt.buttonUI.F1_1_EditField.Value = dt.buttonUI.F1_1_EditField.Value - 1;
                        dt.buttonUI.F2_1_EditField.Value = dt.buttonUI.F2_1_EditField.Value - 1;
                        dt.buttonUI.F3_1_EditField.Value = dt.buttonUI.F3_1_EditField.Value - 1;
                        dt.elevatorUI.EditField.Value = dt.elevatorUI.EditField.Value - 1;
                    end
        
                    pause(0.5);
                    dt.openDoor(dt.retreive_num(1));
                case 2
                    while dt.level > dt.target
                        if dt.db.checkdb(dt.level) == 1
                            dt.openDoor(dt.retreive_num(2));
                        end
                        pause(3);
                        dt.level = dt.level - 1;
                        dt.buttonUI.F1_2_EditField.Value = dt.buttonUI.F1_2_EditField.Value - 1;
                        dt.buttonUI.F2_2_EditField.Value = dt.buttonUI.F2_2_EditField.Value - 1;
                        dt.buttonUI.F3_2_EditField.Value = dt.buttonUI.F3_2_EditField.Value - 1;
                        dt.elevatorUI.EditField.Value = dt.elevatorUI.EditField.Value - 1;
                    end
        
                    pause(0.5);
                    dt.openDoor(dt.retreive_num(2));
            end
        end

        function add(dt,level)
            switch level
                case 1
                    dt.db.db1 = 1;
                case 2
                    dt.db.db2 = 1;
                case 3
                    dt.db.db3 = 1;
            end
        end

    end
end