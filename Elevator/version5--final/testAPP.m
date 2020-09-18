classdef testAPP < matlab.uitest.TestCase
    properties
        controller
    end
    
    methods (TestMethodSetup)
        function launchApp(testCase)
            ctr = controllerClass;
            
            eleUI1 = elevatorUI1;
            eleUI2 = elevatorUI2;
            btnUI1 = buttonUI1;
            btnUI2 = buttonUI2;
            btnUI3 = buttonUI3;
            mdlUI = modelUI;

            ctr.model = mdlUI;
            ctr.buttonAPP1 = btnUI1;
            ctr.buttonAPP2 = btnUI2;
            ctr.buttonAPP3 = btnUI3;
            ctr.eleAPP1 = eleUI1;
            ctr.eleAPP2 = eleUI2;


            btnUI1.contrler = ctr;
            btnUI2.contrler = ctr;
            btnUI3.contrler = ctr;
            eleUI1.contrler = ctr;
            eleUI2.contrler = ctr;
            mdlUI.contrler = ctr;
            mdlUI.count = 0;
            mdlUI.count2 = 0;
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
            testCase.controller=ctr;
            start(ctr.tall);
            %testCase.press(testCase.controller.buttonAPP2.F2_UpButton);
            testCase.addTeardown(@delete,testCase.controller.buttonAPP1);
            testCase.addTeardown(@delete,testCase.controller.buttonAPP2);
            testCase.addTeardown(@delete,testCase.controller.buttonAPP3);
            testCase.addTeardown(@delete,testCase.controller.eleAPP1);
            testCase.addTeardown(@delete,testCase.controller.eleAPP2);
            testCase.addTeardown(@delete,testCase.controller.model);
        end
    end
    methods (Test)
        function test_SelectButtonPushed(testCase)
            % State: No order for the table and no dish selected
            % Input: Choose appetizer 1 and press select button
            % Expected Output: OrderList has appetizer 1's name, amount and
            % unit price
            
            testCase.press(testCase.controller.buttonAPP2.F2_UpButton);
            pause(10);
            testCase.verifyEqual(testCase.controller.buttonAPP2.F2_dt1_num.Value,testCase.controller.dt1floor);
            testCase.verifyEqual(testCase.controller.buttonAPP2.F2_dt1_num.Value,testCase.controller.buttonAPP1.F1_dt1_num.Value);
            testCase.verifyEqual(testCase.controller.buttonAPP2.F2_dt1_num.Value,testCase.controller.buttonAPP3.F3_dt1_num.Value);
            testCase.verifyEqual(testCase.controller.buttonAPP2.F2_dt1_num.Value,testCase.controller.eleAPP1.dt1_num.Value);
            testCase.press(testCase.controller.buttonAPP1.F1_UpButton);
            pause(10);
            testCase.verifyEqual(testCase.controller.buttonAPP1.F1_dt1_num.Value,testCase.controller.dt1floor);
            testCase.press(testCase.controller.buttonAPP3.F3_DownButton);
            pause(10);
            testCase.verifyEqual(testCase.controller.buttonAPP3.F3_dt2_num.Value,testCase.controller.dt2floor);
            testCase.drag(testCase.controller.model.dt1_weight,1000,1200);
            
        end
        function test_ele(testCase)
            testCase.press(testCase.controller.eleAPP1.OpenButton);
            testCase.verifyEqual(testCase.controller.eleAPP1.dt1_door.Value,0);
            testCase.press(testCase.controller.eleAPP1.HelpButton);
        end
        function play1(testCase)
            testCase.press(testCase.controller.buttonAPP2.F2_UpButton);
            pause(7);
            testCase.press(testCase.controller.eleAPP1.Button_3);
            pause(5);
            testCase.press(testCase.controller.buttonAPP2.F2_DownButton);
            pause(7);
            testCase.press(testCase.controller.eleAPP2.Button_4);
            pause(5);
            testCase.press(testCase.controller.buttonAPP2.F2_DownButton);
            pause(9);
            testCase.press(testCase.controller.eleAPP1.HelpButton);
            pause(5);
        end
        function play2(testCase)
            testCase.press(testCase.controller.buttonAPP1.F1_UpButton);
            pause(2);
            testCase.press(testCase.controller.eleAPP1.Button_3);
            pause(3);
            testCase.press(testCase.controller.buttonAPP3.F3_DownButton);
            pause(1.5);
            testCase.press(testCase.controller.eleAPP2.Button_4);
            pause(0.2);
            testCase.press(testCase.controller.buttonAPP2.F2_UpButton);
            pause(5);

            testCase.drag(testCase.controller.model.dt2_weight,1000,1200);
            pause(5);
            %testCase.press(testCase.controller.eleAPP1.buttonAPP2.F2_DownButton);
            %pause(5);
            %testCase.press(testCase.controller.eleAPP1.HelpButton);
        end
        function play3(testCase)
            testCase.press(testCase.controller.buttonAPP1.F1_UpButton);
            pause(2);
            testCase.drag(testCase.controller.model.dt1_weight,0,300);
            pause(2);
            testCase.press(testCase.controller.eleAPP1.Button_2);
            pause(8);
            testCase.drag(testCase.controller.model.dt1_weight,300,1200);
            pause(4);
            testCase.drag(testCase.controller.model.dt1_weight,1200,800);
            pause(2);
            testCase.press(testCase.controller.eleAPP1.Button_3);
            pause(3);
            testCase.press(testCase.controller.eleAPP1.HelpButton);
            pause(4);
            testCase.press(testCase.controller.model.ProbelmFixedButton);
            pause(2);
            testCase.press(testCase.controller.buttonAPP1.F1_UpButton);
            
            %testCase.press(testCase.controller.eleAPP1.Button);
            %pause(3);
            %testCase.press(testCase.controller.buttonAPP3.F3_DownButton);
            pause(14);

            testCase.drag(testCase.controller.model.dt2_weight,0,1200);
            pause(5);
            testCase.drag(testCase.controller.model.dt2_weight,1200,500);
            pause(3);
            testCase.press(testCase.controller.eleAPP2.Button_5);
            %testCase.press(testCase.controller.eleAPP1.buttonAPP2.F2_DownButton);
            %pause(5);
            %testCase.press(testCase.controller.eleAPP1.HelpButton);
        end
    end
end