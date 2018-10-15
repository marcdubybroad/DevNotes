

-- all variant type relationships
MATCH (v:Variant {name:'4:106216205:T:C'})<-[]-(n)-[:FOR_PHENOTYPE]->(p:Phenotype)
RETURN v, labels(n), n, p

-- working generic variant to phenotype link sql
MATCH (v:Variant)<-[]-(n)-[:FOR_PHENOTYPE]->(p:Phenotype) 
  where v.chromosome = '8' and v.position >= 100000 and v.position<= 200000
  RETURN properties(v) as variant,
    labels(n) as director, properties(n) as link,
    properties(p) as phenotype







-- aggregated/top variants query
   MATCH  (v:Variant)<-[:TOP_VARIANT]-(b:BottomLine)-[:FOR_PHENOTYPE]->(p:Phenotype)
   WHERE  v.chromosome = $chrom
     AND  v.position >= $start
     AND  v.position <= $end
    WITH  p, b, v
ORDER BY  b.pValue
          // aggregate them to get the first one
    WITH  DISTINCT p, COLLECT(b) AS bs, COLLECT(v) AS vs
          // return the 'best' per phenotype
  RETURN  p, HEAD(bs), HEAD(vs)


  
-- CURRENT
-- variants query
match (v:Variant)<-[r:AT]-(b:BottomLine)-[:METAL {top:true}]->(p:Phenotype)
 where v.chromosome = '8' and v.position >= 100000 and v.position<= 200000 and b.pValue < 0.05 
 return p.name as phenotype, v.chromosome as chromosome, v.position as position,
 v.allele as alt_allele, v.reference as ref_allele, b.pValue as pValue, b.beta as beta



