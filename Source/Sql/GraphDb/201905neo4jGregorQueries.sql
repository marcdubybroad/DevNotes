

match 
  (pheno : Phenotype {name: 'T2D'})-[link :HAS_GLOBAL_ENRICHMENT]->(enrich :GlobalEnrichment),
  (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(tissue :Tissue),
  (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(ancestry :Ancestry),
  (enrich)-[:HAS_ANNOTATION]->(annot :Annotation)
return pheno.name as phenotype, tissue.name as tissue, ancestry.name as ancestry,
    enrich.pValue as p_value, enrich.inBedIndexSNP as in_beb_index_snp, enrich.expectedInBedIndexSNP as expected_in_beb_index_snp,
    annot.name as annotation
order by enrich.pValue

limit 10


-- meta analysis for single variant
match (phenotype: Phenotype)-[vm:HAS_GLOBAL_ENRICHMENT]->(meta: MetaAnalysis)<-[pm:HAS_META_ANALYSIS]-(pheno: Phenotype)
where var.position = 118232242 and var.chromosome = '8'
return var, meta, pheno, vm, pm




match 
  (pheno : Phenotype {name: 'T2D'})-[link :HAS_GLOBAL_ENRICHMENT]->(enrich :GlobalEnrichment)
return pheno, enrich, link
  
  
  
  
  (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(tissue :Tissue),
  (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(ancestry :Ancestry),
  (enrich)-[:HAS_ANNOTATION]->(annot :Annotation)
return pheno, tissue, ancestry, enrich, annot, link





match 
  (pheno : Phenotype {name: 'T2D'})-[link :HAS_GLOBAL_ENRICHMENT]->(enrich :GlobalEnrichment),
  (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(tissue :Tissue),
  (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(ancestry :Ancestry),
  (enrich)-[:HAS_ANNOTATION]->(annot :Annotation)
return pheno, tissue, ancestry, enrich, annot, link
limit 10


order by enrich.pValue





match (ge: GlobalEnrichment) return ge


--    (:Tissue) -[:HAS_REGION]-> (:Region)
--    (:Variant) -[:HAS_REGION]-> (:Region) // not yet, but will
--    (:Tissue) -[:HAS_GLOBAL_ENRICHMENT]-> (:GlobalEnrichment)
--    (:Phenotype) -[:HAS_GLOBAL_ENRICHMENT]-> (:GlobalEnrichment)
--    (:Ancestry) -[:HAS_GLOBAL_ENRICHMENT]-> (:GlobalEnrichment)

