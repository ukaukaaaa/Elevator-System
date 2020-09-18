close all
clear all 
bt1 = ButtonPanelApp;
bt2 = ButtonPanelApp2;
evapp1 = ElevatorUI1;
evapp2 = ElevatorUI2;
ev2 = elevatorClass;
ev1 = elevatorClass;

dbb = databaseClass;
dbb.elev1 = ev1;
dbb.elev2 = ev2;

ev1.buttonUI = bt1;
ev2.buttonUI = bt2;
ev1.db = dbb;
ev2.db = dbb;
ev1.elevatorUI = evapp1;
ev2.elevatorUI = evapp2;
bt1.elevator1 = ev1;
bt1.elevator2 = ev2;
bt1.eleUI1 = evapp1;
bt1.eleUI2 = evapp2;
bt1.button2 = bt2;
bt2.elevator2 = ev2;
bt2.eleUI1 = evapp1;
bt2.eleUI2 = evapp2;
bt2.elevator1 = ev1;
bt2.button1 = bt1;
evapp1.elevator = ev1;
evapp1.button1 = bt1;
evapp1.button2 = bt2;
evapp2.button1 = bt1;
evapp2.button2 = bt2;
evapp2.elevator = ev2;


ev1.level = 1;
ev1.state = 'r';
ev1.direction = 's';
ev1.door = 'close';
ev1.target = 0;

ev2.level = 3;
ev2.state = 'r';
ev2.direction = 's';
ev2.door = 'close';
ev2.target = 0;