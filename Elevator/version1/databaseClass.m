classdef  databaseClass

    properties (Access = public)
        db1;
        db2;
        db3;
        elev1;
        elev2;
    end

    methods (Access = public)
        function t = checkdb(db,level)
            switch level
                case 1
                    if db.db1 == 1
                        t = 1;
                    else
                        t = 0;
                    end
                case 2
                    if db.db2 == 1
                        t = 1;
                    else
                        t = 0;
                    end
                case 3
                    if db.db3 == 1
                        t = 1;
                    else
                        t= 0;
                    end
                                        
            end
        end
    end
end