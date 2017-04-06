
-- take origin out of the covariates
update SAMPLES_PROP set MEANING = 'FILTER' where PROP = 'origin';


-- make PC covariates first in order
update SAMPLES_PROP set SORT = 5 where PROP = 'C5';
update SAMPLES_PROP set SORT = 6 where PROP = 'C6';
update SAMPLES_PROP set SORT = 7 where PROP = 'C7';
update SAMPLES_PROP set SORT = 8 where PROP = 'C8';
update SAMPLES_PROP set SORT = 9 where PROP = 'C9';
update SAMPLES_PROP set SORT = 10 where PROP = 'C10';

-- sort other 17k covariates by alphabetical order
update SAMPLES_PROP set SORT = 20 where PROP = 'BMI';
update SAMPLES_PROP set SORT = 21 where PROP = 'CHOL';
update SAMPLES_PROP set SORT = 22 where PROP = 'DBP';
update SAMPLES_PROP set SORT = 23 where PROP = 'SBP';
update SAMPLES_PROP set SORT = 24 where PROP = 'FAST_GLU';
update SAMPLES_PROP set SORT = 25 where PROP = 'FAST_INS';
update SAMPLES_PROP set SORT = 26 where PROP = 'HDL';
update SAMPLES_PROP set SORT = 27 where PROP = 'LDL';

