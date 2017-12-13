


select tv.VAR_ID,tv.dataset,tv.P_VALUE,tv.BETA,tv.MDV,
tv.phenotype,tv.AF,kg.EAF,tv.POS,tv.GENE,tv.CHROM,tv.MOST_DEL_SCORE
from TOP_VARIANTS_MDV29  tv
inner join 1kg_phase1_dv1 kg on (tv.VAR_ID=kg.VAR_ID) limit 1;


