#!/usr/bin/env python
import os, sys
# import os, sys, IPython - from Ryan@UM
from os import path
from glob import glob

# set up Hail home
#  entries, one for the packaged distribution that works, another for the REST branch compiled distribution that doesn't
# packaged Hail
HAIL_HOME = "/home/ubuntu/hail_server/distribHail"
# REST branch compiled hail
# HAIL_HOME = "/home/ubuntu/hail_server/jonHailTree"

# Setup HAIL and PYTHONPATH
SPARK_HOME = "/home/ubuntu/Software/spark-2.0.2-bin-hadoop2.7"
PY4J_ZIPS = glob(path.join(SPARK_HOME,"python/lib/py4j-*-src.zip"))
PYTHON_LIBS = [
  "{}/python".format(HAIL_HOME),
  "{}/python".format(SPARK_HOME),
] + PY4J_ZIPS + os.environ.get("PYTHONPATH","").split(":")
PYTHONPATH = ":".join(PYTHON_LIBS)
SPARK_CLASSPATH = "{}/jars/hail-all-spark.jar".format(HAIL_HOME)

sys.path = PYTHON_LIBS + sys.path

# set up environment variables
os.environ["SPARK_HOME"] = SPARK_HOME
os.environ["HAIL_HOME"] = HAIL_HOME
os.environ["PYTHONPATH"] = PYTHONPATH
os.environ["SPARK_CLASSPATH"] = SPARK_CLASSPATH

# import Hail
from pyspark import *
from hail import *

# create the Hail context
hc = HailContext()

# import the CVF
vcf_path = "/home/ubuntu/Data/Hail/Camp/camp.biallelic.chr1-22.clean.vcf"
campVds = hailContext.import_vcf(vcf_path)

# export the VDS
vds_path = vcf_path.replace(".vcf.gz",".vds")




cov = hc.import_table("fusion_muscle_for_hail.tab",impute=True,types={'labelcode':TString()}).key_by("labelcode")
vds = hc.import_vcf(vcf_path,force_bgz=True)
vds = vds.annotate_samples_table(cov,root="sa")
vds.write(vds_path)

