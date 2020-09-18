classdef controllerClass < handle
    properties (Access = public)
        model;
        buttonAPP1;
        buttonAPP2;
        buttonAPP3;

        eleAPP1;
        eleAPP2;

        target;% buttonUI signal
        target2;%elevatorUI
        
        %buttonUI floor signal
        F3_signal;
        F2_up_signal;
        F2_down_signal;
        F1_signal;

        %elevator floor signal
        dt1s1;%(dianti == dt)
        dt1s2;
        dt1s3;
        dt2s1;
        dt2s2;
        dt2s3;

        %elevator floor number
        dt1floor;
        dt2floor;
        %elevator direction
        dt1_direction;
        dt2_direction;
        help;%help signal
        tall;%timer
    end

    methods (Access = public)
        %timer of run function
        function ctr = controllerClass()
            ctr.tall = timer("Period",0.1,'ExecutionMode',"fixedSpacing","TasksToExecute",inf);
            ctr.tall.timerFcn = @(~,~) ctr.run();


        end


        function run(ctr)
                %weight slider is unable during elevator running
                if (ctr.model.dt1.Position(2) == 300 || ctr.model.dt1.Position(2) == 600 || ctr.model.dt1.Position(2) == 0)
                    ctr.model.dt1_weight.Enable =  'on';
                else
                    ctr.model.dt1_weight.Enable = 'off';
                end
                if (ctr.model.dt2.Position(2) == 300 || ctr.model.dt2.Position(2) == 600 || ctr.model.dt2.Position(2) == 0)
                    ctr.model.dt2_weight.Enable =  'on';
                else
                    ctr.model.dt2_weight.Enable = 'off';
                end
    
                %check do not stop1 in the middle

                if (ctr.target == 0 && ctr.target2 == 0) && ~isequal(ctr.model.dt1.Position, [80,0,59,100]) && ~isequal(ctr.model.dt1.Position, [80,300,59,100]) &&  ~isequal(ctr.model.dt1.Position, [80,600,59,100])
                    ctr.dt1_direction = 2;
                    ctr.godown(1);
                end

                if (ctr.target == 0 && ctr.target2 == 0) &&  ~isequal(ctr.model.dt2.Position, [265,0,59,100]) &&  ~isequal(ctr.model.dt2.Position, [265,300,59,100]) &&  ~isequal(ctr.model.dt2.Position, [265,600,59,100])
                    ctr.dt2_direction = 1;
                    ctr.goup(2);
                end

                if (ctr.target == 0 && ctr.target2 == 0) && isequal(ctr.model.dt1.Position, [80,0,59,100])                     % fprintf("1");
                    ctr.dt1_direction = 0;
                end

                if (ctr.target == 0 && ctr.target2 == 0) && ctr.model.dt2.Position(2) == 600
                    ctr.dt2_direction = 0;
                end

                if ctr.target ~= 0 || ctr.target2 ~= 0

%check if call is from the same floor so that can directly open the door
                    if ctr.dt2_direction == 0 && ctr.F3_signal == 1 && isequal(ctr.model.dt2.Position, [265,600,59,100])
                        ctr.stop1(2,3);

                        ctr.complete(3);
                        ctr.dt2_direction = 0;
                        ctr.opendoor2(3);
                    end

                    if ctr.dt2_direction == 0 && ctr.F2_up_signal == 1 && isequal(ctr.model.dt2.Position, [265,300,59,100])
                        ctr.stop1(2,2);
                        ctr.complete(21);
                        ctr.dt2_direction = 0;
                        ctr.opendoor2(2);
                    end

                    if ctr.dt2_direction == 0 && ctr.F2_down_signal == 1 && isequal(ctr.model.dt2.Position, [265,300,59,100])
                        ctr.stop1(2,2);
                        ctr.complete(22);
                        ctr.dt2_direction = 0;
                        ctr.opendoor2(2);
                    end

                    if ctr.dt2_direction == 0 && ctr.F1_signal == 1 && isequal(ctr.model.dt2.Position, [265,0,59,100])
                        ctr.stop1(2,1);
                        ctr.complete(1);
                        ctr.dt2_direction = 0;
                        ctr.opendoor2(1);
                    end
                    


%initaial                
                    %ele
                    if ctr.dt1_direction == 0 && (ctr.dt1s1 ~= 0 || ctr.dt1s2 ~= 0 || ctr.dt1s3 ~= 0)
                        switch ctr.dt1floor
                            case 1
                                if ctr.dt1s1 == 1
                                    ctr.opendoor1(1);
                                end
                                if (ctr.dt1s2 == 1 || ctr.dt1s3 == 1)
                                    ctr.goup(1);
                                    ctr.dt1_direction = 1;
                                end
                            case 2
                                if ctr.dt1s2 == 1
                                    ctr.opendoor1(2);
                                end
                                if ctr.dt1s1 == 1
                                    ctr.godown(1);
                                    ctr.dt1_direction = 2;
                                elseif ctr.dt1s3 == 1 
                                    ctr.goup(1);
                                    ctr.dt1_direction = 1;
                                end
                            case 3
                                if ctr.dt1s3 == 1
                                    ctr.opendoor1(3);
                                end
                                if (ctr.dt1s1 == 1 || ctr.dt1s2 == 1)
                                    ctr.godown(1);
                                    ctr.dt1_direction = 2;
                                end
                        end
                    end

                    if ctr.dt2_direction == 0 && (ctr.dt2s1 ~= 0 || ctr.dt2s2 ~= 0 || ctr.dt2s3 ~= 0)
                        switch ctr.dt2floor
                            case 1
                                if ctr.dt2s1 == 1
                                    ctr.opendoor2(1);
                                end
                                if (ctr.dt2s2 == 1 || ctr.dt2s3 == 1)
                                    ctr.goup(2);
                                    ctr.dt2_direction = 1;
                                end
                            case 2
                                if ctr.dt2s2 == 1
                                    ctr.opendoor2(2);
                                end
                                if ctr.dt2s1 == 1  
                                    ctr.godown(2);
                                    ctr.dt2_direction = 2;
                                elseif ctr.dt2s3 == 1
                                    ctr.goup(2);
                                    ctr.dt2_direction = 1;
                                end
                            case 3
                                if ctr.dt2s3 == 1
                                    ctr.opendoor2(3);
                                end
                                if (ctr.dt2s1 == 1 || ctr.dt2s2 == 1) 
                                    ctr.godown(2);
                                    ctr.dt2_direction = 2;
                                end
                        end
                    end


%initial            %button
                    if (ctr.target + ctr.target2) >= 2 && ctr.dt2_direction == 0 
                        if ((ctr.F3_signal == 1 && ctr.dt2floor < 3) || (ctr.F2_down_signal == 1 && ctr.dt2floor < 2) || (ctr.F2_up_signal == 1 && ctr.dt2floor < 2))  && (ctr.dt1_direction ~= 1 || (ctr.dt1_direction == 1 && ctr.dt1floor > 2 && ctr.dt2floor < 2 && (ctr.F2_up_signal == 1 || ctr.F2_down_signal == 1)))
                            ctr.goup(2);
                            ctr.dt2_direction = 1;
                        end
                       
                        if ((ctr.F1_signal == 1 && ctr.dt2floor > 1) || (ctr.F2_down_signal == 1 && ctr.dt2floor > 2) || (ctr.F2_up_signal == 1 && ctr.dt2floor > 2))  && (ctr.dt1_direction ~= 2 || (ctr.dt1_direction == 2 && ctr.dt1floor < 2 && ctr.dt2floor > 2 && (ctr.F2_up_signal == 1 || ctr.F2_down_signal == 1)))
                            ctr.godown(2);
                            ctr.dt2_direction = 2;
                        end
                        if (ctr.F3_signal == 1 & ctr.model.dt2.Position == [265,600,59,100])
                            ctr.stop1(2,3);
                            ctr.complete(3);
                            ctr.dt2_direction = 0;
                            ctr.opendoor2(3);
                        end

                        if (ctr.F2_up_signal == 1 & ctr.model.dt2.Position == [265,300,59,100]) 
                            ctr.stop1(2,2);
                            ctr.complete(21);
                            ctr.opendoor2(2);
                        end

                        if (ctr.F2_down_signal == 1 & ctr.model.dt2.Position == [265,300,59,100]) 
                            ctr.stop1(2,2);
                            ctr.complete(22);
                            
                            ctr.opendoor2(2);
                        end

                        if (ctr.F1_signal == 1 & ctr.model.dt2.Position == [265,0,59,100])
                            ctr.stop1(1,1);
                            ctr.complete(1);
                            ctr.opendoor1(1);
                        end  
                    end

                    if  ctr.dt1_direction == 0
                        if ((ctr.F3_signal == 1 && ctr.dt1floor < 3) || (ctr.F2_down_signal == 1 && ctr.dt1floor < 2) || (ctr.F2_up_signal == 1 && ctr.dt1floor < 2) ) && (ctr.dt2_direction ~= 1 || (ctr.dt2_direction == 1 && ctr.dt2floor > 2 && ctr.dt1floor < 2 && (ctr.F2_up_signal == 1 || ctr.F2_down_signal == 1)))
                            ctr.goup(1);
                            ctr.dt1_direction = 1;
                        end
                       
                        if ((ctr.F1_signal == 1 && ctr.dt1floor > 1) || (ctr.F2_down_signal == 1 && ctr.dt1floor > 2) || (ctr.F2_up_signal == 1 && ctr.dt1floor > 2)) && (ctr.dt2_direction ~= 2 || (ctr.dt2_direction == 2 && ctr.dt2floor < 2 && ctr.dt1floor > 2 && (ctr.F2_up_signal == 1 || ctr.F2_down_signal == 1)))
                            ctr.godown(1);
                            ctr.dt1_direction = 2;
                        end

                        if (ctr.F3_signal == 1 & ctr.model.dt1.Position == [80,600,59,100])
                            ctr.stop1(1,3);
                            ctr.complete(3);
                            ctr.dt1_direction = 0;
                            ctr.opendoor1(3);
                        end

                        if (ctr.F2_up_signal == 1 & ctr.model.dt1.Position == [80,300,59,100]) 
                            ctr.stop1(1,2);
                            ctr.complete(21);
                            ctr.opendoor1(2);
                        end

                        if (ctr.F2_down_signal == 1 & ctr.model.dt1.Position == [80,300,59,100]) 
                            ctr.stop1(1,2);
                            ctr.complete(22);
                            ctr.opendoor1(2);
                        end

                        if (ctr.F1_signal == 1 & ctr.model.dt1.Position == [80,0,59,100])
                            ctr.stop1(1,1);
                            ctr.complete(1);
                            ctr.opendoor1(1);
                        end  

                    end
%keep running
%ele1 check if stop1 
                    if (ctr.dt1s1 == 1 & ctr.model.dt1.Position == [80,0,59,100])
                        ctr.stop1(1,1);
                        ctr.completeforele(11);
                        ctr.opendoor1(1);
                        ctr.dt1_direction = 0;
                    elseif (ctr.dt1s2 == 1 && isequal(ctr.model.dt1.Position, [80,300,59,100]))
                        ctr.stop1(1,2);
                        ctr.completeforele(12);
                        ctr.opendoor1(2);
                    elseif (ctr.dt1s3 == 1 & ctr.model.dt1.Position == [80,600,59,100])
                        ctr.stop1(1,3);
                        ctr.completeforele(13);
                        ctr.opendoor1(3);
                        ctr.dt1_direction = 0;
                    end
%ele2
                    if (ctr.dt2s1 == 1 & ctr.model.dt2.Position == [265,0,59,100])
                        ctr.stop1(2,1);
                        ctr.completeforele(21);
                        ctr.opendoor2(1);
                        ctr.dt2_direction = 0;
                    elseif (ctr.dt2s2 == 1 & ctr.model.dt2.Position == [265,300,59,100])
                        ctr.stop1(2,2);
                        ctr.completeforele(22);
                        ctr.opendoor2(2);                        
                    elseif (ctr.dt2s3 == 1 & ctr.model.dt2.Position == [265,600,59,100])
                        ctr.stop1(2,3);
                        ctr.completeforele(23);
                        ctr.opendoor2(3);
                        ctr.dt2_direction = 0;
                    end


%dt1

                    if ctr.dt1_direction == 1
                        if (ctr.F3_signal == 1 && ctr.dt1floor < 3) || (ctr.F2_down_signal == 1 && ctr.dt1floor < 2) || (ctr.F2_up_signal == 1 && ctr.dt1floor < 2) || (ctr.dt1s2 == 1 && ctr.dt1floor < 2) || (ctr.dt1s3 == 1 && ctr.dt1floor < 3)
                            ctr.goup(1);
                        end

                        if (ctr.F3_signal == 1 & ctr.model.dt1.Position == [80,600,59,100])
                            ctr.stop1(1,3);
                            ctr.complete(3);
                            ctr.dt1_direction = 0;
                            ctr.opendoor1(3);
                        end
                        if (ctr.F2_up_signal == 1 & ctr.model.dt1.Position == [80,300,59,100]) 
                            ctr.stop1(1,2);
                            ctr.complete(21);
                            ctr.opendoor1(2);
                        end

                        if (ctr.F1_signal == 1 & ctr.model.dt1.Position == [80,0,59,100])
                            ctr.stop1(1,1);
                            ctr.complete(1);
                            ctr.opendoor1(1);
                        end

                        if (ctr.F3_signal == 0 & ctr.model.dt1.Position == [80,300,59,100] & ctr.dt1s3 == 0)
                            
                            ctr.stop1(1,2);
                            ctr.opendoor1(2);
                            if ctr.F2_up_signal == 1 
                                ctr.complete(21);
                            end
                            if ctr.dt1s2 == 1
                                ctr.completeforele(12);
                            end
                            ctr.dt1_direction = 0;
                        end
                    end

                    if ctr.dt1_direction == 2
                        if (ctr.F1_signal == 1 && ctr.dt1floor > 1) || (ctr.F2_down_signal == 1 && ctr.dt1floor > 2) || (ctr.F2_up_signal == 1 && ctr.dt1floor > 2) || (ctr.dt1s2 == 1 && ctr.dt1floor > 2) || (ctr.dt1s1 == 1 && ctr.dt1floor > 1)
                            ctr.godown(1);
                        end
                        if (ctr.F3_signal == 1 & ctr.model.dt1.Position == [80,600,59,100])
                            ctr.stop1(1,3);
                            ctr.complete(3);
                            ctr.opendoor1(3);
                        end
                        if (ctr.F2_down_signal == 1 & ctr.model.dt1.Position == [80,300,59,100]) 
                            ctr.stop1(1,2);
                            ctr.complete(22);
                            ctr.opendoor1(2);
                        end
                        if (ctr.F1_signal == 1 & ctr.model.dt1.Position == [80,0,59,100])
                            ctr.stop1(1,1);
                            ctr.complete(1);
                            ctr.dt1_direction = 0;
                            ctr.opendoor1(1);
                        end   
                        if (ctr.F1_signal == 0 & ctr.model.dt1.Position == [80,300,59,100] & ctr.dt1s1 == 0)
                            ctr.stop1(1,2);
                            ctr.opendoor1(2);
                            if ctr.F2_down_signal == 1 
                                ctr.complete(22);
                            end
                            if ctr.dt1s2 == 1
                                ctr.completeforele(12);
                            end
                            ctr.dt1_direction = 0;
                        end 
                    end

%dt2

                    if ctr.dt2_direction == 1
                        if (ctr.F3_signal == 1 && ctr.dt2floor < 3) || (ctr.F2_down_signal == 1 && ctr.dt2floor < 2) || (ctr.F2_up_signal == 1 && ctr.dt2floor < 2) || (ctr.dt2s2 == 1 && ctr.dt2floor < 2) || (ctr.dt2s3 == 1 && ctr.dt2floor < 3)
                            ctr.goup(2);
                        end

                        if (ctr.F3_signal == 1 & ctr.model.dt2.Position == [265,600,59,100])
                            ctr.stop1(2,3);
                            ctr.complete(3);
                            ctr.dt2_direction = 0;
                            ctr.opendoor2(3);
                        end
                        if (ctr.F2_up_signal == 1 & ctr.model.dt2.Position == [265,300,59,100]) 
                            ctr.stop1(2,2);
                            ctr.complete(21);
                            ctr.opendoor2(2);
                        end

                        if (ctr.F1_signal == 1 & ctr.model.dt2.Position == [265,0,59,100])
                            ctr.stop1(2,1);
                            ctr.complete(1);
                            
                            ctr.opendoor2(1);
                        end

                        if (ctr.F3_signal == 0 & ctr.model.dt2.Position == [265,300,59,100] & ctr.dt2s3 == 0) | (ctr.dt1_direction == 1 & ctr.model.dt2.Position == [265,300,59,100])
                            ctr.stop1(2,2);
                            ctr.opendoor2(2);
                            if ctr.F2_up_signal == 1 
                                ctr.complete(21);
                            end
                            if ctr.dt2s2 == 1
                                ctr.completeforele(22);
                            end
                            ctr.dt2_direction = 0;
                        end
                    end

                    if ctr.dt2_direction == 2

                        if (ctr.F1_signal == 1 && ctr.dt2floor > 1) || (ctr.F2_down_signal == 1 && ctr.dt2floor > 2) || (ctr.F2_up_signal == 1 && ctr.dt2floor > 2) || (ctr.dt2s2 == 1 && ctr.dt2floor > 2) || (ctr.dt2s1 == 1 && ctr.dt2floor > 1)
                            ctr.godown(2);
                        end
                        if (ctr.F3_signal == 1 & ctr.model.dt2.Position == [265,600,59,100])
                            ctr.stop1(2,3);
                            ctr.complete(3);
                            ctr.opendoor2(3);
                        end
                        if (ctr.F2_down_signal == 1 & ctr.model.dt2.Position == [265,300,59,100]) 
                            ctr.stop1(2,2);
                            ctr.complete(22);
                            ctr.opendoor2(2);
                        end
                        if (ctr.F1_signal == 1 & ctr.model.dt2.Position == [265,0,59,100])
                            ctr.stop1(2,1);
                            ctr.complete(1);
                            ctr.dt2_direction = 0;
                            ctr.opendoor2(1);

                        end   
                        if (ctr.F1_signal == 0 & ctr.model.dt2.Position == [265,300,59,100] & ctr.dt2s1 == 0) | (ctr.dt1_direction == 2 & ctr.model.dt2.Position == [265,300,59,100])
                            ctr.stop1(2,2);
                            ctr.opendoor2(2);
                            if ctr.F2_down_signal == 1 
                                ctr.complete(22);
                            end
                            if ctr.dt2s2 == 1
                                ctr.completeforele(22);
                            end
                            ctr.dt2_direction = 0;

                        end 
                    end




                    
                    
                    
                end
%update floor information            
                ctr.updatedoornum();

        end

        % goup until the end(floor 1 or 3)
        function goup(ctr, num)
            switch num
                case 1
                    if ctr.model.dt1.Position <= [80,599,59,100]
                        ctr.model.dt1.Position = ctr.model.dt1.Position + [0,5,0,0];
                    end
                case 2
                    if ctr.model.dt2.Position <= [265,599,59,100]
                        ctr.model.dt2.Position = ctr.model.dt2.Position + [0,5,0,0];
                    end
            end
        end

        % godown until the end(floor 1 or 3)
        function godown(ctr,num)
            switch num
                case 1
                    if ctr.model.dt1.Position >= [80,1,59,100]
                        ctr.model.dt1.Position = ctr.model.dt1.Position - [0,5,0,0];
                    end
                case 2
                    if ctr.model.dt2.Position >= [265,1,59,100]
                        ctr.model.dt2.Position = ctr.model.dt2.Position - [0,5,0,0];
                    end
            end
        end

        %stop at one certain floor
        function stop1(ctr,num,floorr)
            switch num
                case 1
                    if floorr == 1
                        ctr.model.dt1.Position = [80,0,59,100];
                    elseif floorr == 2
                        ctr.model.dt1.Position = [80,300,59,100];
                    elseif floorr == 3
                        ctr.model.dt1.Position = [80,600,59,100];
                    end
                case 2
                    if floorr == 1
                        ctr.model.dt2.Position = [265,0,59,100];
                    elseif floorr == 2
                        ctr.model.dt2.Position = [265,300,59,100];
                    elseif floorr == 3
                        ctr.model.dt2.Position = [265,600,59,100];
                    end
            end
        end

        %open door for elevator1 floorr is floor(1,2,3)
        function opendoor1(ctr,floorr)
            switch floorr
                case 1
                    ctr.buttonAPP1.F1_dt1_door.Value = 1;
                    ctr.buttonAPP1.F1_dt1_door.BackgroundColor = [0,1,0];
                    ctr.eleAPP1.dt1_door.Value = 1;
                    ctr.model.dt1.BackgroundColor = [0,1,0];
                    ctr.eleAPP1.dt1_door.BackgroundColor = [0,1,0];
                    if ctr.buttonAPP1.m11.Position(1) == 85
                        ctr.buttonAPP1.m11.Position(1) = ctr.buttonAPP1.m11.Position(1) - 35;
                    end
                    if ctr.buttonAPP1.m12.Position(1) == 140   
                        ctr.buttonAPP1.m12.Position(1) = ctr.buttonAPP1.m12.Position(1) + 35;
                    end
                    pause(0.5);
                    if ctr.buttonAPP1.m11.Position(1) == 50
                        ctr.buttonAPP1.m11.Position(1) = ctr.buttonAPP1.m11.Position(1) + 35;
                    end
                    if ctr.buttonAPP1.m12.Position(1) == 175
                        ctr.buttonAPP1.m12.Position(1) = ctr.buttonAPP1.m12.Position(1) - 35;
                    end
                    ctr.model.dt1.BackgroundColor = [0.8,0.8,0.8];
                    ctr.buttonAPP1.F1_dt1_door.Value = 0;
                    ctr.buttonAPP1.F1_dt1_door.BackgroundColor = [1,1,1];
                    ctr.eleAPP1.dt1_door.Value = 0;
                    ctr.eleAPP1.dt1_door.BackgroundColor = [1,1,1];
                case 2
                    ctr.buttonAPP2.F2_dt1_door.Value = 1;
                    ctr.buttonAPP2.F2_dt1_door.BackgroundColor = [0,1,0];
                    ctr.eleAPP1.dt1_door.Value = 1;
                    ctr.eleAPP1.dt1_door.BackgroundColor = [0,1,0];
                    ctr.model.dt1.BackgroundColor = [0,1,0];
                    if ctr.buttonAPP2.m11.Position(1) == 85
                        ctr.buttonAPP2.m11.Position(1) = ctr.buttonAPP2.m11.Position(1) - 35;
                    end
                    if ctr.buttonAPP2.m12.Position(1) == 140   
                        ctr.buttonAPP2.m12.Position(1) = ctr.buttonAPP2.m12.Position(1) + 35;
                    end
                    pause(0.5);
                    if ctr.buttonAPP2.m11.Position(1) == 50
                        ctr.buttonAPP2.m11.Position(1) = ctr.buttonAPP2.m11.Position(1) + 35;
                    end
                    if ctr.buttonAPP2.m12.Position(1) == 175
                        ctr.buttonAPP2.m12.Position(1) = ctr.buttonAPP2.m12.Position(1) - 35;
                    end
                    ctr.model.dt1.BackgroundColor = [0.8,0.8,0.8];
                    ctr.buttonAPP2.F2_dt1_door.Value = 0;
                    ctr.buttonAPP2.F2_dt1_door.BackgroundColor = [1,1,1];
                    ctr.eleAPP1.dt1_door.Value = 0;
                    ctr.eleAPP1.dt1_door.BackgroundColor = [1,1,1];
                case 3
                    ctr.buttonAPP3.F3_dt1_door.Value = 1;
                    ctr.buttonAPP3.F3_dt1_door.BackgroundColor = [0,1,0];
                    ctr.eleAPP1.dt1_door.Value = 1;
                    ctr.eleAPP1.dt1_door.BackgroundColor = [0,1,0];
                    ctr.model.dt1.BackgroundColor = [0,1,0];
                    if ctr.buttonAPP3.m11.Position(1) == 85
                        ctr.buttonAPP3.m11.Position(1) = ctr.buttonAPP3.m11.Position(1) - 35;
                    end
                    if ctr.buttonAPP3.m12.Position(1) == 140   
                        ctr.buttonAPP3.m12.Position(1) = ctr.buttonAPP3.m12.Position(1) + 35;
                    end
                    pause(0.5);
                    if ctr.buttonAPP3.m11.Position(1) == 50
                        ctr.buttonAPP3.m11.Position(1) = ctr.buttonAPP3.m11.Position(1) + 35;
                    end
                    if ctr.buttonAPP3.m12.Position(1) == 175
                        ctr.buttonAPP3.m12.Position(1) = ctr.buttonAPP3.m12.Position(1) - 35;
                    end
                    ctr.model.dt1.BackgroundColor = [0.8,0.8,0.8];
                    ctr.buttonAPP3.F3_dt1_door.Value = 0;
                    ctr.buttonAPP3.F3_dt1_door.BackgroundColor = [1,1,1];
                    ctr.eleAPP1.dt1_door.Value = 0;
                    ctr.eleAPP1.dt1_door.BackgroundColor = [1,1,1];
            end                                        


        end
        %open door for elevator1 floorr is floor(1,2,3)
        function opendoor2(ctr,floorr)
            switch floorr
                case 1
                    ctr.buttonAPP1.F1_dt2_door.Value = 1;
                    ctr.buttonAPP1.F1_dt2_door.BackgroundColor = [0,1,0];
                    ctr.eleAPP2.dt2_door.Value = 1;
                    ctr.eleAPP2.dt2_door.BackgroundColor = [0,1,0];
                    ctr.model.dt2.BackgroundColor = [0,1,0];
                    if ctr.buttonAPP1.m21.Position(1) == 615
                        ctr.buttonAPP1.m21.Position(1) = ctr.buttonAPP1.m21.Position(1) - 35;
                    end
                    if ctr.buttonAPP1.m22.Position(1) == 670   
                        ctr.buttonAPP1.m22.Position(1) = ctr.buttonAPP1.m22.Position(1) + 35;
                    end
                    pause(0.5);
                    if ctr.buttonAPP1.m21.Position(1) == 580
                        ctr.buttonAPP1.m21.Position(1) = ctr.buttonAPP1.m21.Position(1) + 35;
                    end
                    if ctr.buttonAPP1.m22.Position(1) == 705
                        ctr.buttonAPP1.m22.Position(1) = ctr.buttonAPP1.m22.Position(1) - 35;
                    end
                    ctr.model.dt2.BackgroundColor = [0.8,0.8,0.8];
                    ctr.buttonAPP1.F1_dt2_door.Value = 0;
                    ctr.buttonAPP1.F1_dt2_door.BackgroundColor = [1,1,1];
                    ctr.eleAPP2.dt2_door.Value = 0;
                    ctr.eleAPP2.dt2_door.BackgroundColor = [1,1,1];
                case 2
                    ctr.buttonAPP2.F2_dt2_door.Value = 1;
                    ctr.buttonAPP2.F2_dt2_door.BackgroundColor = [0,1,0];
                    ctr.eleAPP2.dt2_door.Value = 1;
                    ctr.model.dt2.BackgroundColor = [0,1,0];
                    ctr.eleAPP2.dt2_door.BackgroundColor = [0,1,0];
                    if ctr.buttonAPP2.m21.Position(1) == 615
                        ctr.buttonAPP2.m21.Position(1) = ctr.buttonAPP2.m21.Position(1) - 35;
                    end
                    if ctr.buttonAPP2.m22.Position(1) == 670   
                        ctr.buttonAPP2.m22.Position(1) = ctr.buttonAPP2.m22.Position(1) + 35;
                    end
                    pause(0.5);
                    if ctr.buttonAPP2.m21.Position(1) == 580
                        ctr.buttonAPP2.m21.Position(1) = ctr.buttonAPP2.m21.Position(1) + 35;
                    end
                    if ctr.buttonAPP2.m22.Position(1) == 705
                        ctr.buttonAPP2.m22.Position(1) = ctr.buttonAPP2.m22.Position(1) - 35;
                    end
                    ctr.model.dt2.BackgroundColor = [0.8,0.8,0.8];
                    ctr.buttonAPP2.F2_dt2_door.Value = 0;
                    ctr.buttonAPP2.F2_dt2_door.BackgroundColor = [1,1,1];
                    ctr.eleAPP2.dt2_door.Value = 0;
                    ctr.eleAPP2.dt2_door.BackgroundColor = [1,1,1];
                case 3
                    ctr.buttonAPP3.F3_dt2_door.Value = 1;
                    ctr.buttonAPP3.F3_dt2_door.BackgroundColor = [0,1,0];
                    ctr.eleAPP2.dt2_door.Value = 1;
                    ctr.eleAPP2.dt2_door.BackgroundColor = [0,1,0];
                    ctr.model.dt2.BackgroundColor = [0,1,0];
                    if ctr.buttonAPP3.m21.Position(1) == 615
                        ctr.buttonAPP3.m21.Position(1) = ctr.buttonAPP3.m21.Position(1) - 35;
                    end
                    if ctr.buttonAPP3.m22.Position(1) == 670   
                        ctr.buttonAPP3.m22.Position(1) = ctr.buttonAPP3.m22.Position(1) + 35;
                    end
                    pause(0.5);
                    if ctr.buttonAPP3.m21.Position(1) == 580
                        ctr.buttonAPP3.m21.Position(1) = ctr.buttonAPP3.m21.Position(1) + 35;
                    end
                    if ctr.buttonAPP3.m22.Position(1) == 705
                        ctr.buttonAPP3.m22.Position(1) = ctr.buttonAPP3.m22.Position(1) - 35;
                    end
                    ctr.model.dt2.BackgroundColor = [0.8,0.8,0.8];
                    ctr.buttonAPP3.F3_dt2_door.Value = 0;
                    ctr.buttonAPP3.F3_dt2_door.BackgroundColor = [1,1,1];
                    ctr.eleAPP2.dt2_door.Value = 0;
                    ctr.eleAPP2.dt2_door.BackgroundColor = [1,1,1];
            end                                        


        end

        %update the floor number in UIs and update the system variable elevator floor
        function updatedoornum(ctr)
                if ctr.model.dt1.Position == [80,0,59,100]
                    ctr.buttonAPP1.F1_dt1_num.Value = 1;
                    ctr.buttonAPP2.F2_dt1_num.Value = 1;
                    ctr.buttonAPP3.F3_dt1_num.Value = 1;
                    ctr.eleAPP1.dt1_num.Value = 1;
                    ctr.dt1floor = 1;
                elseif ctr.model.dt1.Position == [80,300,59,100]
                    ctr.buttonAPP1.F1_dt1_num.Value = 2;
                    ctr.buttonAPP2.F2_dt1_num.Value = 2;
                    ctr.buttonAPP3.F3_dt1_num.Value = 2;
                    ctr.eleAPP1.dt1_num.Value = 2;
                    ctr.dt1floor = 2;
                elseif ctr.model.dt1.Position == [80,600,59,100]
                    ctr.buttonAPP1.F1_dt1_num.Value = 3;
                    ctr.buttonAPP2.F2_dt1_num.Value = 3;
                    ctr.buttonAPP3.F3_dt1_num.Value = 3;
                    ctr.eleAPP1.dt1_num.Value = 3;
                    ctr.dt1floor = 3;
                end
                
                if ctr.model.dt2.Position == [265,0,59,100]
                    ctr.buttonAPP1.F1_dt2_num.Value = 1;
                    ctr.buttonAPP2.F2_dt2_num.Value = 1;
                    ctr.buttonAPP3.F3_dt2_num.Value = 1;
                    ctr.eleAPP2.dt2_num.Value = 1;
                    ctr.dt2floor = 1;
                elseif ctr.model.dt2.Position == [265,300,59,100]
                    ctr.buttonAPP1.F1_dt2_num.Value = 2;
                    ctr.buttonAPP2.F2_dt2_num.Value = 2;
                    ctr.buttonAPP3.F3_dt2_num.Value = 2;
                    ctr.eleAPP2.dt2_num.Value = 2;
                    ctr.dt2floor = 2;
                elseif ctr.model.dt2.Position == [265,600,59,100]
                    ctr.buttonAPP1.F1_dt2_num.Value = 3;
                    ctr.buttonAPP2.F2_dt2_num.Value = 3;
                    ctr.buttonAPP3.F3_dt2_num.Value = 3;
                    ctr.eleAPP2.dt2_num.Value = 3;
                    ctr.dt2floor = 3;
                end
        end

        %complete one buttonUI signal minus one buttonUI target and let corresponding button floor signal be 0
        %let the buttonUI button color back to grey
        function complete(ctr,signal)
            switch signal
                case 3
                    ctr.target = ctr.target - 1;
                    ctr.F3_signal = 0;
                    ctr.buttonAPP3.F3_DownButton.BackgroundColor = [0.96,0.96,0.96]; 
                case 21
                    ctr.target = ctr.target - 1;
                    ctr.F2_up_signal = 0;
                    ctr.buttonAPP2.F2_UpButton.BackgroundColor = [0.96,0.96,0.96];                    
                case 22
                    ctr.target = ctr.target - 1;
                    ctr.F2_down_signal = 0;
                    ctr.buttonAPP2.F2_DownButton.BackgroundColor = [0.96,0.96,0.96];
                case 1
                    ctr.target = ctr.target - 1;
                    ctr.F1_signal = 0;
                    ctr.buttonAPP1.F1_UpButton.BackgroundColor = [0.96,0.96,0.96];
            end
        end

        %complete one elevator signal minus one elevatorUI target and let corresponding elevator floor signal be 0
        %let the elevatorUI button color back to grey
        function completeforele(ctr,signal)
            switch signal
                case 11
                    ctr.target2 = ctr.target2 - 1;
                    ctr.dt1s1 = 0;
                    ctr.eleAPP1.Button.BackgroundColor = [0.96,0.96,0.96];
                case 12
                    ctr.target2 = ctr.target2 - 1;
                    ctr.dt1s2 = 0;
                    ctr.eleAPP1.Button_2.BackgroundColor = [0.96,0.96,0.96];
                case 13
                    ctr.target2 = ctr.target2 - 1;
                    ctr.dt1s3 = 0;
                    ctr.eleAPP1.Button_3.BackgroundColor = [0.96,0.96,0.96];  
                case 21
                    ctr.target2 = ctr.target2 - 1;
                    ctr.dt2s1 = 0;
                    ctr.eleAPP2.Button_4.BackgroundColor = [0.96,0.96,0.96];
                case 22
                    ctr.target2 = ctr.target2 - 1;
                    ctr.dt2s2 = 0;
                    ctr.eleAPP2.Button_5.BackgroundColor = [0.96,0.96,0.96];                    
                case 23
                    ctr.target2 = ctr.target2 - 1;
                    ctr.dt2s3 = 0;
                    ctr.eleAPP2.Button_6.BackgroundColor = [0.96,0.96,0.96];                    
            end
        end


    end




end