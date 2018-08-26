

-- drop all tables
-- drop link table first to avoid FK errors
drop table if exists link_gene_annotation_tissue;
drop table if exists link_region_annotation;
drop table if exists link_variant_annotation_tissue;
drop table if exists link_variant_phenotype;
drop table if exists link_gene_phenotype;


-- drop entity table
drop table if exists variant_annotation;
drop table if exists gene_annotation;
drop table if exists region_annotation;
drop table if exists variant;
drop table if exists gene;
drop table if exists phenotype;
drop table if exists tissue;
drop table if exists region;


-- entity tables
-- create variant annotations
create table variant_annotation (
    variant_annotation_id int(9) not null primary key,
    name varchar(100) not null,
    web_name varchar(1000) not null,
    description varchar(4000));
    
-- create gene annotations
create table gene_annotation (
    gene_annotation_id int(9) not null primary key,
    name varchar(100) not null,
    web_name varchar(1000) not null,
    description varchar(4000));

-- create region annotations
create table region_annotation (
    region_annotation_id int(9) not null primary key,
    name varchar(100) not null,
    web_name varchar(1000) not null,
    description varchar(4000));
    
-- create table variants
create table variant (
    variant_id int(9) not null primary key,
    chromosome varchar(2) not null,
    position int(9) not null,
    reference_allele varchar(4000) not null,
    alternate_allele varchar(4000) not null,
    description varchar(4000));

-- create gene table
create table gene (
    gene_id int(9) not null primary key,
    chromosome varchar(2) not null,
    start_position int(9) not null,
    end_position int(9) not null,
    description varchar(4000));

-- create region table
create table region (
    region_id int(9) not null primary key,
    chromosome varchar(2) not null,
    start_position int(9) not null,
    end_position int(9) not null,
    description varchar(4000));


-- create phenotype table
create table phenotype (
    phenotype_id int(9) not null primary key,
    name varchar(100) not null,
    parent_id int(9) null,
    description varchar(4000),
    foreign key (parent_id) references phenotype(phenotype_id));
    
    
-- create tissue table
create table tissue (
    tissue_id int(9) not null primary key,
    name varchar(100) not null,
    description varchar(4000));
    



-- link tables
-- gene to gene_annotation (tissue optional)
create table link_gene_annotation_tissue (
    link_gene_annotation_tissue_id int(9) not null primary key,
    gene_id int(9) not null,
    gene_annotation_id int(9) not null,
    tissue_id int(9) null,
    p_value double not null,
    name varchar(100) null,
    foreign key (gene_id) references gene(gene_id),
    foreign key (gene_annotation_id) references gene_annotation(gene_annotation_id),
    foreign key (tissue_id) references tissue(tissue_id)
);


-- variant to variant annotation (tissue optional)
create table link_variant_annotation_tissue (
    link_variant_annotation_tissue_id int(9) not null primary key,
    variant_id int(9) not null,
    variant_annotation_id int(9) not null,
    tissue_id int(9) null,
    p_value double not null,
    name varchar(100) null,
    foreign key (variant_id) references variant(variant_id),
    foreign key (variant_annotation_id) references variant_annotation(variant_annotation_id),
    foreign key (tissue_id) references tissue(tissue_id)
);

    
-- variant to phenotype (aggregated across all datasets)
create table link_variant_phenotype (
    link_variant_phenotype_id int(9) not null primary key,
    variant_id int(9) not null,
    phenotype_id int(9) not null,
    p_value double not null,
    name varchar(100) null,
    foreign key (variant_id) references variant(variant_id),
    foreign key (phenotype_id) references phenotype(phenotype_id)
);


-- gene to phenotype (burden score)
create table link_gene_phenotype (
    link_gene_phenotype_id int(9) not null primary key,
    gene_id int(9) not null,
    phenotype_id int(9) not null,
    p_value double not null,
    name varchar(100) null,
    foreign key (gene_id) references gene(gene_id),
    foreign key (phenotype_id) references phenotype(phenotype_id)
);
    
    
-- region to region annotation (gene and tissue optional)
create table link_region_annotation (
    link_region_annotation_id int(9) not null primary key,
    region_id int(9) not null,
    region_annotation_id int(9) not null,
    tissue_id int(9) null,
    gene_id int(9) null,
    p_value double not null,
    name varchar(100) null,
    foreign key (region_id) references region(region_id),
    foreign key (region_annotation_id) references region_annotation(region_annotation_id),
    foreign key (tissue_id) references tissue(tissue_id),
    foreign key (gene_id) references gene(gene_id)
);

    
    
    
-- show
show tables;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
