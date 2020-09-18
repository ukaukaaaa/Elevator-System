clear all;
close all;
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
ctr.help = 0;

start(ctr.tall);
