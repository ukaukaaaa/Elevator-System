classdef controllerClass < handle
    properties (Access = public)
        model;
        buttonAPP1;
        buttonAPP2;
        buttonAPP3;

        eleAPP1;
        eleAPP2;

        target;
        target2;
        F3_signal;
        F2_up_signal;
        F2_down_signal;
        F1_signal;

        dt1s1;
        dt1s2;
        dt1s3;
        dt2s1;
        dt2s2;
        dt2s3;

        dt1floor;
        dt2floor;
        dt1_direction;
        dt2_direction;
    end

    methods (Access = public)
        function run(ctr)
            while 1
                pause(0.5);
                % fprintf("target: %d\n",ctr.target);
                % fprintf("target2: %d\n",ctr.target2);
                % fprintf("det: %d\n")
                if (ctr.target == 0 && ctr.target2 == 0) && ~isequal(ctr.model.dt1.Position, [80,0,59,100]) && ~isequal(ctr.model.dt1.Position, [80,300,59,100]) &&  ~isequal(ctr.model.dt1.Position, [80,600,59,100])
                    % fprintf("1");
                    ctr.godown(1);
                end

                if (ctr.target == 0 && ctr.target2 == 0) &&  ~isequal(ctr.model.dt2.Position, [265,0,59,100]) &&  ~isequal(ctr.model.dt2.Position, [265,300,59,100]) &&  ~isequal(ctr.model.dt2.Position, [265,600,59,100])
                    % fprintf("2");
                    ctr.goup(2);
                end
                if ctr.target ~= 0 || ctr.target2 ~= 0

                    % fprintf("dt1_direction: %d\n",ctr.dt1_direction);
                    % fprintf("target: %d\n",ctr.target2);
                    % fprintf("F2signal: %d\n",ctr.dt1s3);
                    % fprintf("dt1floor: %d\n\n",ctr.dt1floor);


%check if call is from the same floor so that can directly open the door
                    if ctr.dt2_direction == 0 && ctr.F3_signal == 1 && isequal(ctr.model.dt2.Position, [265,600,59,100])
                        ctr.stop(2,3);
                        % fprintf("5");

                        ctr.complete(3);
                        ctr.dt2_direction = 0;
                        ctr.opendoor(2,3);
                    end

                    if ctr.dt2_direction == 0 && ctr.F2_up_signal == 1 && isequal(ctr.model.dt2.Position, [265,300,59,100])
                        ctr.stop(2,2);
                        ctr.complete(21);
                        ctr.dt2_direction = 0;
                        ctr.opendoor(2,2);
                    end

                    if ctr.dt2_direction == 0 && ctr.F2_down_signal == 1 && isequal(ctr.model.dt2.Position, [265,300,59,100])
                        ctr.stop(2,2);
                        ctr.complete(22);
                        ctr.dt2_direction = 0;
                        ctr.opendoor(2,2);
                    end

                    if ctr.dt2_direction == 0 && ctr.F1_signal == 1 && isequal(ctr.model.dt2.Position, [265,0,59,100])
                        ctr.stop(2,1);
                        ctr.complete(1);
                        ctr.dt2_direction = 0;
                        ctr.opendoor(2,1);
                    end
                    


%initaial                
                    %ele
                    if ctr.dt1_direction == 0 && (ctr.dt1s1 ~= 0 || ctr.dt1s2 ~= 0 || ctr.dt1s3 ~= 0)
                        switch ctr.dt1floor
                            case 1
                                if ctr.dt1s1 == 1
                                    ctr.opendoor(1,1);
                                end
                                if ctr.dt1s2 == 1 || ctr.dt1s3 == 1
                                    ctr.goup(1);
                                    ctr.dt1_direction = 1;
                                end
                            case 2
                                if ctr.dt1s2 == 1
                                    ctr.opendoor(1,2);
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
                                    ctr.opendoor(1,3);
                                end
                                if ctr.dt1s1 == 1 || ctr.dt1s2 == 1
                                    ctr.godown(1);
                                    ctr.dt1_direction = 2;
                                end
                        end
                    end

                    if ctr.dt2_direction == 0 && (ctr.dt2s1 ~= 0 || ctr.dt2s2 ~= 0 || ctr.dt2s3 ~= 0)
                        switch ctr.dt2floor
                            case 1
                                if ctr.dt2s1 == 1
                                    ctr.opendoor(2,1);
                                end
                                if ctr.dt2s2 == 1 || ctr.dt2s3 == 1
                                    ctr.goup(2);
                                    ctr.dt2_direction = 1;
                                end
                            case 2
                                if ctr.dt2s2 == 1
                                    % fprintf("this one");
                                    ctr.opendoor(2,2);
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
                                    ctr.opendoor(2,3);
                                end
                                if ctr.dt2s1 == 1 || ctr.dt2s2 == 1
                                    ctr.godown(2);
                                    ctr.dt2_direction = 2;
                                end
                        end
                    end


%initial            %button
                    if ctr.target >= 2 && ctr.dt2_direction == 0
                        if (ctr.F3_signal == 1 && ctr.dt2floor < 3) || (ctr.F2_down_signal == 1 && ctr.dt2floor < 2) || (ctr.F2_up_signal == 1 && ctr.dt2floor < 2)
                            ctr.goup(2);
                            ctr.dt2_direction = 1;
                        end
                       
                        if (ctr.F1_signal == 1 && ctr.dt2floor > 1) || (ctr.F2_down_signal == 1 && ctr.dt2floor > 2) || (ctr.F2_up_signal == 1 && ctr.dt2floor > 2)
                            ctr.godown(2);
                            ctr.dt2_direction = 2;
                        end
                        if (ctr.F3_signal == 1 & ctr.model.dt2.Position == [265,600,59,100])
                            ctr.stop(2,3);
                            % fprintf("6");

                            ctr.complete(3);
                            ctr.dt2_direction = 0;
                            ctr.opendoor(2,3);
                        end

                        if (ctr.F2_up_signal == 1 & ctr.model.dt2.Position == [265,300,59,100]) 
                            ctr.stop(2,2);
                            ctr.complete(21);
                            ctr.opendoor(2,2);
                        end

                        if (ctr.F2_down_signal == 1 & ctr.model.dt2.Position == [265,300,59,100]) 
                            ctr.stop(2,2);
                            ctr.complete(22);
                            
                            ctr.opendoor(2,2);
                        end

                        if (ctr.F1_signal == 1 & ctr.model.dt2.Position == [265,0,59,100])
                            ctr.stop(1,1);
                            ctr.complete(1);
                            ctr.opendoor(1,1);
                        end  
                    end

                    if  ctr.dt1_direction == 0
                        if (ctr.F3_signal == 1 && ctr.dt1floor < 3) || (ctr.F2_down_signal == 1 && ctr.dt1floor < 2) || (ctr.F2_up_signal == 1 && ctr.dt1floor < 2)
                            ctr.goup(1);
                            ctr.dt1_direction = 1;
                        end
                       
                        if (ctr.F1_signal == 1 && ctr.dt1floor > 1) || (ctr.F2_down_signal == 1 && ctr.dt1floor > 2) || (ctr.F2_up_signal == 1 && ctr.dt1floor > 2)
                            ctr.godown(1);
                            ctr.dt1_direction = 2;
                        end

                        if (ctr.F3_signal == 1 & ctr.model.dt1.Position == [80,600,59,100])
                            ctr.stop(1,3);
                            % fprintf("7");

                            ctr.complete(3);
                            ctr.dt1_direction = 0;
                            ctr.opendoor(1,3);
                        end

                        if (ctr.F2_up_signal == 1 & ctr.model.dt1.Position == [80,300,59,100]) 
                            ctr.stop(1,2);
                            ctr.complete(21);
                            ctr.opendoor(1,2);
                        end

                        if (ctr.F2_down_signal == 1 & ctr.model.dt1.Position == [80,300,59,100]) 
                            ctr.stop(1,2);
                            ctr.complete(22);
                            ctr.opendoor(1,2);
                        end

                        if (ctr.F1_signal == 1 & ctr.model.dt1.Position == [80,0,59,100])
                            ctr.stop(1,1);
                            ctr.complete(1);
                            % ctr.dt1_direction = 0;
                            ctr.opendoor(1,1);
                        end  

                    end
%keep running
%ele1 check if stop 
                    if (ctr.dt1s1 == 1 & ctr.model.dt1.Position == [80,0,59,100])
                        ctr.stop(1,1);
                        ctr.completeforele(11);
                        %if ctr.F1_signal ~= 1
                        ctr.opendoor(1,1);
                        %end
                        ctr.dt1_direction = 0;
                    elseif (ctr.dt1s2 == 1 && isequal(ctr.model.dt1.Position, [80,300,59,100]))
                        ctr.stop(1,2);
                        ctr.completeforele(12);
                        %if ctr.F2_down_signal ~= 1 && ctr.F2_up_signal ~= 1
                        ctr.opendoor(1,2);
                        %end                      

                    elseif (ctr.dt1s3 == 1 & ctr.model.dt1.Position == [80,600,59,100])
                        ctr.stop(1,3);
                        % fprintf("after");
                        ctr.completeforele(13);
                        %fprintf("F3sinalg:%d",ctr.F3_signal);
                        %if ctr.F3_signal ~= 1
                        %   fprintf("yes");
                        ctr.opendoor(1,3);
                        %end
                        ctr.dt1_direction = 0;
                    end
%ele2
                    if (ctr.dt2s1 == 1 & ctr.model.dt2.Position == [265,0,59,100])
                        ctr.stop(2,1);
                        ctr.completeforele(21);
                        %if ctr.F1_signal ~= 1
                        ctr.opendoor(2,1);
                        % end
                        ctr.dt2_direction = 0;
                    elseif (ctr.dt2s2 == 1 & ctr.model.dt2.Position == [265,300,59,100])
                        ctr.stop(2,2);
                        ctr.completeforele(22);
                        % fprintf("up down:");
                        %if ctr.F2_down_signal ~= 1 && ctr.F2_up_signal ~= 1
                        ctr.opendoor(2,2);                        
                        %end
                    elseif (ctr.dt2s3 == 1 & ctr.model.dt2.Position == [265,600,59,100])
                        ctr.stop(2,3);
                        ctr.completeforele(23);
                        %if ctr.F3_signal ~= 1
                        ctr.opendoor(2,3);
                        % end
                        ctr.dt2_direction = 0;
                    end


%dt1

                    if ctr.dt1_direction == 1
                        if (ctr.F3_signal == 1 && ctr.dt1floor < 3) || (ctr.F2_down_signal == 1 && ctr.dt1floor < 2) || (ctr.F2_up_signal == 1 && ctr.dt1floor < 2) || (ctr.dt1s2 == 1 && ctr.dt1floor < 2) || (ctr.dt1s3 == 1 && ctr.dt1floor < 3)
                            ctr.goup(1);
                        end

                        if (ctr.F3_signal == 1 & ctr.model.dt1.Position == [80,600,59,100])
                            ctr.stop(1,3);
                            % fprintf("1111");
                            ctr.complete(3);
                            ctr.dt1_direction = 0;
                            ctr.opendoor(1,3);
                        end
                        if (ctr.F2_up_signal == 1 & ctr.model.dt1.Position == [80,300,59,100]) 
                            ctr.stop(1,2);
                            ctr.complete(21);
                            ctr.opendoor(1,2);
                        end

                        if (ctr.F1_signal == 1 & ctr.model.dt1.Position == [80,0,59,100])
                            ctr.stop(1,1);
                            ctr.complete(1);
                            ctr.opendoor(1,1);
                        end

                        if (ctr.F3_signal == 0 & ctr.model.dt1.Position == [80,300,59,100] & ctr.dt1s3 == 0)
                            
                            ctr.stop(1,2);
                            ctr.opendoor(1,2);
                            if ctr.F2_up_signal == 1 
                                ctr.complete(21);
                            end
                            if ctr.dt1s2 == 1
                                ctr.completeforele(12);
                            end
                            % fprintf("shita");
                            ctr.dt1_direction = 0;
                        end
                    end

                    if ctr.dt1_direction == 2
                        if (ctr.F1_signal == 1 && ctr.dt1floor > 1) || (ctr.F2_down_signal == 1 && ctr.dt1floor > 2) || (ctr.F2_up_signal == 1 && ctr.dt1floor > 2) || (ctr.dt1s2 == 1 && ctr.dt1floor > 2) || (ctr.dt1s1 == 1 && ctr.dt1floor > 1)
                            ctr.godown(1);
                        end
                        if (ctr.F3_signal == 1 & ctr.model.dt1.Position == [80,600,59,100])
                            ctr.stop(1,3);
                            % fprintf("2222");
                            ctr.complete(3);
                            
                            ctr.opendoor(1,3);
                        end
                        if (ctr.F2_down_signal == 1 & ctr.model.dt1.Position == [80,300,59,100]) 
                            ctr.stop(1,2);
                            ctr.complete(22);
                            ctr.opendoor(1,2);
                        end
                        if (ctr.F1_signal == 1 & ctr.model.dt1.Position == [80,0,59,100])
                            ctr.stop(1,1);
                            ctr.complete(1);
                            ctr.dt1_direction = 0;
                            ctr.opendoor(1,1);
                        end   
                        if (ctr.F1_signal == 0 & ctr.model.dt1.Position == [80,300,59,100] & ctr.dt1s1 == 0)
                            ctr.stop(1,2);
                            ctr.opendoor(1,2);
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
                            ctr.stop(2,3);
                            % fprintf("3");

                            ctr.complete(3);
                            ctr.dt2_direction = 0;
                            ctr.opendoor(2,3);
                        end
                        if (ctr.F2_up_signal == 1 & ctr.model.dt2.Position == [265,300,59,100]) 
                            ctr.stop(2,2);
                            ctr.complete(21);
                            ctr.opendoor(2,2);
                        end

                        if (ctr.F1_signal == 1 & ctr.model.dt2.Position == [265,0,59,100])
                            ctr.stop(2,1);
                            ctr.complete(1);
                            
                            ctr.opendoor(2,1);
                        end

                        if (ctr.F3_signal == 0 & ctr.model.dt2.Position == [265,300,59,100] & ctr.dt2s3 == 0) | (ctr.dt1_direction == 1 & ctr.model.dt2.Position == [265,300,59,100])
                            ctr.stop(2,2);
                            ctr.opendoor(2,2);
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
                            ctr.stop(2,3);
                            % fprintf("4");

                            ctr.complete(3);
                            
                            ctr.opendoor(2,3);
                        end
                        if (ctr.F2_down_signal == 1 & ctr.model.dt2.Position == [265,300,59,100]) 
                            ctr.stop(2,2);
                            ctr.complete(22);
                            ctr.opendoor(2,2);
                        end
                        if (ctr.F1_signal == 1 & ctr.model.dt2.Position == [265,0,59,100])
                            ctr.stop(2,1);
                            ctr.complete(1);
                            ctr.dt2_direction = 0;
                            ctr.opendoor(2,1);

                        end   
                        if (ctr.F1_signal == 0 & ctr.model.dt2.Position == [265,300,59,100] & ctr.dt2s1 == 0) | (ctr.dt1_direction == 2 & ctr.model.dt2.Position == [265,300,59,100])
                            ctr.stop(2,2);
                            ctr.opendoor(2,2);
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
%check do not stop in the middle
                % fprintf("%d\n",ctr.target);
                % fprintf("%d\n",ctr.target2);


                
                ctr.updatedoornum();

            end
        end

        function goup(ctr, num)
            switch num
                case 1
                    if ctr.model.dt1.Position <= [80,599,59,100]
                        ctr.model.dt1.Position = ctr.model.dt1.Position + [0,25,0,0];
                    end
                case 2
                    if ctr.model.dt2.Position <= [265,599,59,100]
                        ctr.model.dt2.Position = ctr.model.dt2.Position + [0,25,0,0];
                    end
            end
        end

        function godown(ctr,num)
            switch num
                case 1
                    if ctr.model.dt1.Position >= [80,1,59,100]
                        ctr.model.dt1.Position = ctr.model.dt1.Position - [0,25,0,0];
                    end
                case 2
                    if ctr.model.dt2.Position >= [265,1,59,100]
                        ctr.model.dt2.Position = ctr.model.dt2.Position - [0,25,0,0];
                    end
            end
        end

        function stop(ctr,num,floorr)
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

        function opendoor(ctr,num,floorr)
            switch floorr
                case 1
                    if num == 1
                        ctr.buttonAPP1.F1_dt1_door.Value = 1;
                        ctr.buttonAPP1.F1_dt1_door.BackgroundColor = [0,1,0];
                        ctr.eleAPP1.dt1_door.Value = 1;
                        ctr.model.dt1.BackgroundColor = [0,1,0];
                        ctr.eleAPP1.dt1_door.BackgroundColor = [0,1,0];
                        pause(1);
                        ctr.model.dt1.BackgroundColor = [0.8,0.8,0.8];
                        ctr.buttonAPP1.F1_dt1_door.Value = 0;
                        ctr.buttonAPP1.F1_dt1_door.BackgroundColor = [1,1,1];
                        ctr.eleAPP1.dt1_door.Value = 0;
                        ctr.eleAPP1.dt1_door.BackgroundColor = [1,1,1];
                    else
                        ctr.buttonAPP1.F1_dt2_door.Value = 1;
                        ctr.buttonAPP1.F1_dt2_door.BackgroundColor = [0,1,0];
                        ctr.eleAPP2.dt2_door.Value = 1;
                        ctr.eleAPP2.dt2_door.BackgroundColor = [0,1,0];
                        ctr.model.dt2.BackgroundColor = [0,1,0];
                        pause(1);
                        ctr.model.dt2.BackgroundColor = [0.8,0.8,0.8];
                        ctr.buttonAPP1.F1_dt2_door.Value = 0;
                        ctr.buttonAPP1.F1_dt2_door.BackgroundColor = [1,1,1];
                        ctr.eleAPP2.dt2_door.Value = 0;
                        ctr.eleAPP2.dt2_door.BackgroundColor = [1,1,1];
                    end
                
                case 2
                    if num == 1
                        ctr.buttonAPP2.F2_dt1_door.Value = 1;
                        ctr.buttonAPP2.F2_dt1_door.BackgroundColor = [0,1,0];
                        ctr.eleAPP1.dt1_door.Value = 1;
                        ctr.eleAPP1.dt1_door.BackgroundColor = [0,1,0];
                        ctr.model.dt1.BackgroundColor = [0,1,0];
                        pause(1);
                        ctr.model.dt1.BackgroundColor = [0.8,0.8,0.8];
                        ctr.buttonAPP2.F2_dt1_door.Value = 0;
                        ctr.buttonAPP2.F2_dt1_door.BackgroundColor = [1,1,1];
                        ctr.eleAPP1.dt1_door.Value = 0;
                        ctr.eleAPP1.dt1_door.BackgroundColor = [1,1,1];
                    else
                        ctr.buttonAPP2.F2_dt2_door.Value = 1;
                        ctr.buttonAPP2.F2_dt2_door.BackgroundColor = [0,1,0];
                        ctr.eleAPP2.dt2_door.Value = 1;
                        ctr.model.dt2.BackgroundColor = [0,1,0];
                        ctr.eleAPP2.dt2_door.BackgroundColor = [0,1,0];
                        pause(1);
                        ctr.model.dt2.BackgroundColor = [0.8,0.8,0.8];
                        ctr.buttonAPP2.F2_dt2_door.Value = 0;
                        ctr.buttonAPP2.F2_dt2_door.BackgroundColor = [1,1,1];
                        ctr.eleAPP2.dt2_door.Value = 0;
                        ctr.eleAPP2.dt2_door.BackgroundColor = [1,1,1];
                    end

                case 3
                    if num == 1
                        ctr.buttonAPP3.F3_dt1_door.Value = 1;
                        ctr.buttonAPP3.F3_dt1_door.BackgroundColor = [0,1,0];
                        ctr.eleAPP1.dt1_door.Value = 1;
                        ctr.eleAPP1.dt1_door.BackgroundColor = [0,1,0];
                        ctr.model.dt1.BackgroundColor = [0,1,0];
                        pause(1);
                        ctr.model.dt1.BackgroundColor = [0.8,0.8,0.8];
                        ctr.buttonAPP3.F3_dt1_door.Value = 0;
                        ctr.buttonAPP3.F3_dt1_door.BackgroundColor = [1,1,1];
                        ctr.eleAPP1.dt1_door.Value = 0;
                        ctr.eleAPP1.dt1_door.BackgroundColor = [1,1,1];
                    else
                        ctr.buttonAPP3.F3_dt2_door.Value = 1;
                        ctr.buttonAPP3.F3_dt2_door.BackgroundColor = [0,1,0];
                        ctr.eleAPP2.dt2_door.Value = 1;
                        ctr.eleAPP2.dt2_door.BackgroundColor = [0,1,0];
                        ctr.model.dt2.BackgroundColor = [0,1,0];
                        pause(1);
                        ctr.model.dt2.BackgroundColor = [0.8,0.8,0.8];
                        ctr.buttonAPP3.F3_dt2_door.Value = 0;
                        ctr.buttonAPP3.F3_dt2_door.BackgroundColor = [1,1,1];
                        ctr.eleAPP2.dt2_door.Value = 0;
                        ctr.eleAPP2.dt2_door.BackgroundColor = [1,1,1];
                    end

            end
        end

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