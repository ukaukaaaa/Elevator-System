clear all
close all
data = databaseClass;
dt1 = elevatorClass;
dt2 = elevatorClass;
bt1 = ButtonPanelApp;
bt2 = ButtonPanelApp2;
dt1app = ElevatorUI1;
dt2app = ElevatorUI2;
ctl = controlClass;

ctl.ev1 = dt1;
ctl.ev2 = dt2;

data.elev1 = dt1;
data.elev2 = dt2;

dt1.buttonApp = bt1;
dt1.elevatorApp = dt1app;
dt1.db = data;
dt1.ct = ctl;

dt2.buttonApp = bt2;
dt2.elevatorApp = dt2app;
dt2.db = data;
dt2.ctl = ctl;

bt1.elevator = dt1;
bt1.button2 = bt2;

bt2.elevator = dt2;
bt2.button1 = bt1;

dt1app.elevator = dt1;
dt2app.elevator = dt2;

db.s1 = 0;
db.s2 = 0;
db.s3 = 0;
db.s4 = 0;
db.s5 = 0;
db.s6 = 0;
db.s7 = 0;
db.s8 = 0;
db.s9 = 0;

dt1.door = 'c';
dt1.workstate = 'r';
dt1.level = 1;
dt1.direction = 's';

dt2.door = 'c';
dt2.workstate = 'r';
dt2.level = 3;
dt2.direction = 's';

