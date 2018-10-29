

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
 



