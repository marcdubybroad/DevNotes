

match 
  (pheno : Phenotype {name: 'T2D'})-[link :HAS_GLOBAL_ENRICHMENT]->(enrich :GlobalEnrichment),
  (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(tissue :Tissue),
  (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(ancestry :Ancestry)
return pheno.name as phenotype, tissue.name as tissue_id, tissue.description as tissue, ancestry.name as ancestry,
    enrich.pValue as p_value, enrich.inBedIndexSNP as in_beb_index_snp, enrich.expectedInBedIndexSNP as expected_in_beb_index_snp,
    enrich.annotation as annotation
order by enrich.pValue
limit 50


-- object query
match (pheno : Phenotype {name: 'T2D'})-[link :HAS_GLOBAL_ENRICHMENT]->(enrich :GlobalEnrichment),
    (enrich)<-[link2 :HAS_GLOBAL_ENRICHMENT]-(tissue :Tissue),
    (enrich)<-[:HAS_GLOBAL_ENRICHMENT]-(ancestry :Ancestry)
return pheno, tissue, ancestry, enrich, link, link2
limit 50

order by enrich.pValue


-- meta analysis for single variant
match (phenotype: Phenotype)-[vm:HAS_GLOBAL_ENRICHMENT]->(meta: MetaAnalysis)<-[pm:HAS_META_ANALYSIS]-(pheno: Phenotype)
where var.position = 118232242 and var.chromosome = '8'
return var, meta, pheno, vm, pm





-- random query
match (v:Variant {name: '16:53803574:T:A'})

// find regions that overlap the variant
match (o:OverlappedRegion)
where o.chromosome = v.chromosome and o.start <= v.position
with * order by o.start desc limit 1
match (r:Region)-[:OVERLAPS]-(o)
where r.start <= v.position and r.end > v.position
with r, v

// find globally enriched tissues that these regions affect
match (t:Tissue)-[:HAS_REGION]->(r),
      (t)-[:HAS_GLOBAL_ENRICHMENT]->(g:GlobalEnrichment),
      (p:Phenotype)-[:HAS_GLOBAL_ENRICHMENT]->(g),
      (c:Ancestry)-[:HAS_GLOBAL_ENRICHMENT]->(g)
where g.pValue < 5e-8 
and r.annotation = 'Enhancer'
and g.annotation = r.annotation 
with v, r, t, p, c, head(apoc.coll.sortNodes(collect(g), "pValue")) as g

// find the meta-analysis results for each of the phenotypes
match (v)-[:HAS_META_ANALYSIS]->(m:MetaAnalysis),
      (p)-[:HAS_META_ANALYSIS]->(m)
where m.pValue < 1e-5

return *




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

