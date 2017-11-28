

#!/usr/bin/env python
import os, sys, IPython
from os import path
from glob import glob

# Setup HAIL and PYTHONPATH
SPARK_HOME = "/data/hail/spark/spark-2.1.0-bin-hadoop2.7"
HAIL_HOME = "/data/hail/hail"
PY4J_ZIPS = glob(path.join(SPARK_HOME,"python/lib/py4j-*-src.zip"))
PYTHON_LIBS = [
  "{}/python".format(HAIL_HOME),
  "{}/python".format(SPARK_HOME),
] + PY4J_ZIPS + os.environ.get("PYTHONPATH","").split(":")
PYTHONPATH = ":".join(PYTHON_LIBS)
SPARK_CLASSPATH = "{}/build/install/hail/lib/*".format(HAIL_HOME)

sys.path = PYTHON_LIBS + sys.path

os.environ["SPARK_HOME"] = SPARK_HOME
os.environ["HAIL_HOME"] = HAIL_HOME
os.environ["PYTHONPATH"] = PYTHONPATH
#os.environ["SPARK_CLASSPATH"] = SPARK_CLASSPATH

from pyspark import *
from hail import *

conf = SparkConf()

conf.set("spark.executor.extraClassPath",SPARK_CLASSPATH)
conf.set("spark.driver.extraClassPath",SPARK_CLASSPATH)
conf.set("spark.executor.instances",1)
conf.set("spark.executor.cores",2)
conf.set("spark.executor.memory","4g")
conf.set("spark.cores.max",2)
conf.set("spark.sql.files.openCostInBytes",1099511627776)
conf.set("spark.sql.files.maxPartitionBytes",1099511627776)

sc = SparkContext(conf=conf)
hc = HailContext(sc)

def get_covariate_names(fpath):
  with open(fpath,"rt") as fp:
    header = fp.readline().rstrip().split("\t")
    header = list(filter(lambda x: x != "labelcode",header))

  return header

vcf_path = "hailfix_foreqtls_tissue_go2td_imputed_140708.clean.chr22.vcf.gz"
vds_path = vcf_path.replace(".vcf.gz",".vds")

vds = hc.read(vds_path)
covariates = ["sa." + x for x in get_covariate_names("fusion_muscle_for_hail.tab")]
vds.rest_server_score_covariance(covariates,port=6060)



