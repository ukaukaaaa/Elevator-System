%testbuttonpushed inside outside
%testelevator receive order
%testhelp
%testoverweight

classdef unitTest < matlab.unittest.TestCase
    methods (Test)
        function launchApp(testCase)
            ctr = controllerClass;
            
            mdlUI = modelUI;
            ctr.model = mdlUI;
            mdlUI.contrler = ctr;
 

            

            ctr.dt1_direction = 0;
            ctr.dt2_direction = 0;
            ctr.target = 0;
            ctr.target2 = 0;

            ctr.F3_signal = 0;
            ctr.F2_down_signal = 0;
            ctr.F2_up_signal = 0;
            ctr.F1_signal = 0;

            ctr.dt1floor = 1;
            ctr.dt2floor = 3;

            ctr.dt1s1 = 0;
            ctr.dt1s2 = 0;
            ctr.dt1s3 = 0;
            ctr.dt2s1 = 0;
            ctr.dt2s2 = 0;
            ctr.dt2s3 = 0;
            for i =1:60
                ctr.goup(1);
                i=i+1;
            end
            ctr.updatedoornum();
            
            testCase.verifyEqual(ctr.dt1floor,2);
            
            
        end
    end
end
            