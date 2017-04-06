

-- drop the temop new variant table if it exists
drop table if exists new_variants;
drop table if exists diff_variants;


-- create the variant table
create table new_variant (
    id int(9) not null primary key auto_increment,
    var_id varchar(4000) not null,
    db_snp_id varchar(4000) null,
    chromosome varchar(255) not null,
    position bigint(20) not null,
    insert_date timestamp);
    
-- populate the variant table; straihght copy from common_dv1 (gets rid of the long text issue)
insert into new_variant (var_id, db_snp_id, chromosome, position) select VAR_ID, DBSNP_ID, CHROM, POS from common_dv1;

-- create new variant difference table
create table diff_variant (
    id int(9) not null primary key auto_increment,
    var_id varchar(4000) not null,
    db_snp_id varchar(4000) null,
    chromosome varchar(255) not null,
    position bigint(20) not null,
    insert_date timestamp);

-- populate the difference variant table with variants that are in the new common_dv1 copy table but not in the current portal variant lookup table
insert into diff_variant (var_id, db_snp_id, chromosome, position)
    select nvar.var_id, nvar.db_snp_id, nvar.chromosome, nvar.position from new_variant nvar
        where not exists (select var_id from variant where var_id = nvar.var_id);

-- insert the new variants into the variant table, different created_date
insert into variant (var_id, var_id_first_characters, db_snp_id, db_snp_id_first_characters, position, chromosome, version, created_date)
    select var_id, substring(var_id, 1, 5), db_snp_id, substring(db_snp_id, 1, 4), position, chromosome, 0, sysdate() from diff_variant
        where length(var_id) < 755;
    
-- drop the temop new variant table if it exists to save space
drop table if exists new_variants;
drop table if exists diff_variants;



