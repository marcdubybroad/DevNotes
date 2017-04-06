
-- lookup tables
alter table PH modify column PH varchar(100);
alter table DATASET modify column ID varchar(100);
alter table PROP modify column PROP varchar(100);

-- ID_PH table
alter table ID_PH modify column PH varchar(100);
alter table ID_PH modify column ID varchar(100);
alter table ID_PH add constraint id_ph_ph_fk foreign key (PH) references PH(PH);
alter table ID_PH add constraint id_ph_id_fk foreign key (ID) references DATASET(ID);

-- PROP_ID table
alter table PROP_ID modify column PROP varchar(100);
alter table PROP_ID modify column ID varchar(100);
alter table PROP_ID add constraint prop_id_prop_fk foreign key (PROP) references PROP(PROP);
alter table PROP_ID add constraint prop_id_id_fk foreign key (ID) references DATASET(ID);

-- PROP_ID_PH table
alter table PROP_ID_PH modify column PROP varchar(100);
alter table PROP_ID_PH modify column ID varchar(100);
alter table PROP_ID_PH modify column PH varchar(100);
alter table PROP_ID_PH add constraint prop_id_ph_prop_fk foreign key (PROP) references PROP(PROP);
alter table PROP_ID_PH add constraint prop_id_ph_id_fk foreign key (ID) references DATASET(ID);
alter table PROP_ID_PH add constraint prop_id_ph_ph_fk foreign key (PH) references PH(PH);





