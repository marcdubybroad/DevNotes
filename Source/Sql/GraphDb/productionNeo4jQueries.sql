

-- variant association query
match (grp: PhenotypeGroup)<-[:BELONGS_TO]-(phe: Phenotype)<-[:FOR_PHENOTYPE]-(meta: MetaAnalysis)-[:TOP_VARIANT]->(var: Variant {position: 28139238})
where var.chromosome = '8'
return meta, var, phe, grp
order by meta.pValue
limit 50


match (grp: PhenotypeGroup)<-[:BELONGS_TO]-(phe: Phenotype)<-[:FOR_PHENOTYPE]-(meta: MetaAnalysis)-[:TOP_VARIANT]->(var: Variant {position: 28139238})
where var.chromosome = '8'
return meta.pValue as p_value, meta.stdErr as std_err, meta.beta as beta,
    var.chromosome as chrom, var.position as pos, var.reference as ref, var.alt as alt, phe.name as phenotype, grp.name as phenotype_group
order by meta.pValue
limit 50


-- all variants for region across phenotype, ordered
match (grp: PhenotypeGroup)<-[:BELONGS_TO]-(phe: Phenotype)<-[:FOR_PHENOTYPE]-(meta: MetaAnalysis)-[:TOP_VARIANT]->(var: Variant {chromosome: '8'})
where var.position >= 29000000 and var.position <= 30000000
    and meta.pValue < 0.5
return meta, var, phe, grp
order by meta.pValue
limit 50

match (grp: PhenotypeGroup)<-[:BELONGS_TO]-(phe: Phenotype)<-[:FOR_PHENOTYPE]-(meta: MetaAnalysis)-[:TOP_VARIANT]->(var: Variant {chromosome: '8'})
where var.position >= 29000000 and var.position <= 30000000
    and meta.pValue < 0.05
return meta.pValue as p_value, meta.stdErr as std_err, meta.beta as beta,
    var.chromosome as chrom, var.position as pos, var.reference as ref, var.alt as alt, phe.name as phenotype, grp.name as phenotype_group
order by meta.pValue
limit 250



-- SCRATCH
-- new portal type
MATCH (v:Variant)-[:HAS_META_ANALYSIS]->(a:MetaAnalysis), 
      (p:Phenotype)-[:HAS_META_ANALYSIS]->(a),
      (p)-[:VISIBLE_TO]->(:Portal {name: 'CVDKP'})
WHERE v.chromosome = '8' 
  AND v.position = 1234567
  AND v.reference = 'C'


-- scratch qorking queries
match (meta: MetaAnalysis) return meta order by meta.pValue limit 25



-- return phentotype
MATCH (p:Phenotype {name: 'T2D'})-[:BELONGS_TO]->(g:PhenotypeGroup)
RETURN p, g
limit 25


MATCH (p:Phenotype)-[:BELONGS_TO]->(g:PhenotypeGroup)
RETURN p, g
limit 25


-- 20190212 - new queries
match (v:Variant)<-[xx]-(b:BottomLine)-[yy]->(p:Phenotype)
 where v.chromosome = '8' and v.position >= 100000 and v.position<= 200000 and b.pValue < 0.05 
 return p.name as phenotype,
    v.chromosome as chromosome, v.position as position, v.allele as alt_allele, v.reference as ref_allele,
    b.pValue as pValue, b.beta as beta


-- get variants by phenotype group
MATCH (c:TranscriptConsequence)-[:FOR_VARIANT]->(v:Variant),
       (r:RegulatoryFeature)-[:FOR_VARIANT]->(v),
       (n:MetaAnalysis)-[:TOP_VARIANT]->(v), 
       (n)-[:FOR_PHENOTYPE]-(p:Phenotype),
       (p)-[:BELONGS_TO]->(g:PhenotypeGroup)
 WHERE v.chromosome = '8' 
   AND v.position > 29000000
   AND v.position < 30000000
   AND c.pick
   AND n.pValue < 0.005
   and g.name = 'GLYCEMIC'
RETURN v, c, n, r, p, g
limit 25


-- get variant to metabolic link with meta analysis
MATCH (c:TranscriptConsequence)-[:FOR_VARIANT]->(v:Variant),
       (r:RegulatoryFeature)-[:FOR_VARIANT]->(v),
       (n:MetaAnalysis)-[:TOP_VARIANT]->(v), 
       (n)-[:FOR_PHENOTYPE]-(p:Phenotype {name: 'T2D'}) 
 WHERE v.chromosome = '8' 
   AND v.position > 29000000
   AND v.position < 30000000
   AND c.pick
   AND n.pValue < 0.5
RETURN v, c, n, r, p
limit 25


-- 20190212 - test queries
MATCH (c:TranscriptConsequence)-[:FOR_VARIANT]->(v:Variant),
       (r:RegulatoryFeature)-[:FOR_VARIANT]->(v),
       (n:MetaAnalysis)-[:TOP_VARIANT]->(v), 
       (n)-[:FOR_PHENOTYPE]-(p:Phenotype {name: 'T2D'}) 

 WHERE v.chromosome = '8' 
   AND v.position > 29000000
   AND v.position < 30000000
   AND c.pick

RETURN v, c, n, r


-- CURRENT

-- variants query
match (v:Variant)<-[xx]-(b:BottomLine)-[yy]->(p:Phenotype)
 where v.chromosome = '8' and v.position >= 100000 and v.position<= 200000 and b.pValue < 0.05 
 return p.name as phenotype,
    v.chromosome as chromosome, v.position as position, v.allele as alt_allele, v.reference as ref_allele,
    b.pValue as pValue, b.beta as beta

-- variants query object
match (v:Variant)<-[xx:TOP_VARIANT]-(b:BottomLine)-[yy]->(p:Phenotype)
 where v.chromosome = '8' and v.position >= 100000 and v.position<= 200000 and b.pValue < 0.05 
 return v, xx, b, yy, p
 



