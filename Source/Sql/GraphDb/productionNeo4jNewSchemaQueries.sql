

-- meta analysis for single variant
match (var: Variant)-[vm:HAS_META_ANALYSIS]->(meta: MetaAnalysis)<-[pm:HAS_META_ANALYSIS]-(pheno: Phenotype)
where var.position = 118232242 and var.chromosome = '8'
return var, meta, pheno, vm, pm







-- scratch variant association
match (grp: PhenotypeGroup)<-[:BELONGS_TO]-(phe: Phenotype)-[:HAS_META_ANALYSIS]->(meta: MetaAnalysis)<-[:HAS_META_ANALYSIS]-(var: Variant {position: {pos}}) 
where var.chromosome = {chrom} 
return meta.pValue as p_value, meta.stdErr as std_err, meta.beta as beta, 
    var.chromosome as chrom, var.position as pos, var.reference as ref, var.alt as alt, phe.name as phenotype, grp.name as phenotype_group
order by meta.pValue limit {limit}
                
                
                
match (grp: PhenotypeGroup)<-[:BELONGS_TO]-(phe: Phenotype)-[:HAS_META_ANALYSIS]->(meta: MetaAnalysis)<-[:HAS_META_ANALYSIS]-(var: Variant {position: 118232242}) 
where var.chromosome = '8'
return meta.pValue as p_value, meta.stdErr as std_err, meta.beta as beta, 
    var.chromosome as chrom, var.position as pos, var.reference as ref, var.alt as alt, phe.name as phenotype, grp.name as phenotype_group
order by meta.pValue limit 100
                
                
                