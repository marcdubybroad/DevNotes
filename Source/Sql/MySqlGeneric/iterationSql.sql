
-- Looking back at the results we have right now, we notice that they are already in the order needed. We simply need to
-- filter and take the first row for each new phenotype group:

-- So, we use a local variable initialized to NULL. For each row returned in our inner query we ask a question:
-- "is this phenotype the same as the last one we looked at?" If it is, return NULL, otherwise update the local
-- variable to the new phenotype and return it, which will be non-NULL. Just keep only those rows that returned non-NULL,
-- we have the set we care about.

SELECT top.* FROM (SELECT @ph := NULL) AS iterator, (
  SELECT variants.*, common.* FROM variants, common WHERE
    common.var_id = variants.var_id AND
    common.chrom = ? AND
    common.pos BETWEEN ? AND ?
  ORDER BY
    variants.phenotype, variants.p_value
) AS top
WHERE IF(@ph = top.phenotype, NULL, @ph := top.phenotype) IS NOT NULL

