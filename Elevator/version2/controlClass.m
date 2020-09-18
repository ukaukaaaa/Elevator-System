classdef  controlClass
    properties (Access = public)
        ev1;
        ev2;
    end

    methods (Access =public)
        function passsignal(dt,siganl)
            switch signal
                case 1
                    dt.db.s1 = 1;
                case 2
                    dt.db.s2 = 1;
                case 3
                    dt.db.s3 = 1;
                case 4
                    dt.db.s4 = 1;
                case 5
                    dt.db.s5 = 1;
                case 6
                    dt.db.s6 = 1;
                case 7
                    dt.db.s7 = 1;
                case 8
                    dt.db.s8 = 1;
                case 9
                    dt.db.s9 = 1;
                case 10
                    dt.db.s10 = 1;
                case 11
                    dt.db.s11 = 1;
                case 12
                    dt.db.s12 = 1;
                case 13
                    dt.db.s3 = 1;
                case 14
                    dt.db.s14 = 1;
            end
        end



        function trigger(dt,dt_num,floorr,direc,s)
            if ev1.workstate == 'r'
                dt.passsignal(s);
                dt.ev1.determinDirection(floorr);
                
        end
    end
end