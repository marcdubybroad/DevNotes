
-- drop table
drop table if exists SAMPLE_19k;

create table SAMPLE_19k as select new.ID, new.t2d_19k as t2d, old.SEX, new.origin, new.origin_African_American, new.origin_East_Asian, new.origin_European, new.origin_Hispanic, new.origin_South_Asian,
    new.C1, new.C2, new.C3, new.C4, new.C5, new.C6, new.C7, new.C8, new.C9, new.C10, old.FAST_GLU, old.FAST_INS, old.CREATININE, old.CHOL, old.LDL, old.HDL, old.TG,
    old.BMI, old.SBP, old.DBP, old.DIABMEDS, old.BPMEDS, old.LIPIDMEDS, old.FAST_GLU_ANAL, old.FAST_INS_ANAL, old.CHOL_ANAL, old.LDL_ANAL, old.HDL_ANAL, old.TG_ANAL,
    old.SBP_ANAL, old.DBP_ANAL, old.Age, old.SEX_readable
from burden_upload.ex19k new, SAMPLE_26k old
where new.ID = old.ID;

-- add T2D readable field
alter table SAMPLE_19k add column T2D_readable varchar(100); 
update SAMPLE_19k set T2D_readable = if((T2D = 1), 'No', if((T2D = 2), 'Yes', null));



-- scratch
select new.t2d, old.t2d
from SAMPLE_19k new, SAMPLE_26k old
where new.ID = old.ID and new.t2d != old.t2d;


select count(new.ID), new.t2d, old.t2d, old.t2d_readable, new.t2d_readable
from SAMPLE_19k new, SAMPLE_17k old
where new.ID = old.ID
group by new.t2d, old.t2d, old.t2d_readable, new.t2d_readable;


select new.t2d, old.t2d, old.t2d_readable
from SAMPLE_19k new, SAMPLE_17k old
where new.ID = old.ID
and new.t2d != old.t2d;
