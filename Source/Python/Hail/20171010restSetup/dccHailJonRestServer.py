
import os, sys
# import os, sys, IPython - from Ryan@UM
from os import path
from glob import glob
from pprint import pprint

# set up Hail home
#  entries, one for the packaged distribution that works, another for the REST branch compiled distribution that doesn't
# packaged Hail
# HAIL_HOME = "/home/ubuntu/hail_server/distribHail"
# REST branch compiled hail
HAIL_HOME = "/home/ubuntu/hail_server/jonHailTree20171114"

# Setup HAIL and PYTHONPATH
SPARK_HOME = "/home/ubuntu/Software/spark-2.0.2-bin-hadoop2.7"
PY4J_ZIPS = glob(path.join(SPARK_HOME,"python/lib/py4j-*-src.zip"))
PYTHON_LIBS = [
  "{}/python".format(HAIL_HOME),
  "{}/python".format(SPARK_HOME),
] + PY4J_ZIPS + os.environ.get("PYTHONPATH","").split(":")
PYTHONPATH = ":".join(PYTHON_LIBS)
sys.path = PYTHON_LIBS + sys.path

# set the Spark classpath; one line each for distribution Hail and one for Jon's branch of the code
# for distribution of Hail
# SPARK_CLASSPATH = "{}/jars/hail-all-spark.jar".format(HAIL_HOME)
# for REST code branch
# SPARK_CLASSPATH = "{}/build/install/hail/lib/*".format(HAIL_HOME)
# Iteration 1 - old Jon path that didn't work 
# SPARK_CLASSPATH = "{}/build/libs/hail-all-spark.jar".format(HAIL_HOME)
SPARK_CLASSPATH = "{}/build/install/hail/lib/*".format(HAIL_HOME)
print SPARK_CLASSPATH


# set up environment variables
os.environ["SPARK_HOME"] = SPARK_HOME
os.environ["HAIL_HOME"] = HAIL_HOME
os.environ["PYTHONPATH"] = PYTHONPATH
os.environ["SPARK_CLASSPATH"] = SPARK_CLASSPATH


# import Hail
from pyspark import *
from hail import *


# create the Hail context
hc = HailContext(log='/home/ubuntu/Logs/HailServers/hail6063.log')


# import the CVF
vcf_path = "/home/ubuntu/Data/Hail/Camp/camp.biallelic.chr1-22.clean.vcf"
campVds = hc.import_vcf(vcf_path)

# load in phenotypes
# use impute = True to let hail determine the type of the columns
ped_path = "/home/ubuntu/Data/Hail/Camp/camp.phenotypes.epacts.withId.modified.ped"
phenotypes = hc.import_table(ped_path, impute=True).key_by("ID")
pprint(phenotypes)


# annotate the loaded vds
campVdsAnnotated = campVds.annotate_samples_table(phenotypes, root="sa")
pprint(campVdsAnnotated.sample_schema)


# load covariates
# covariates = map(lambda c: 'sa.phenotypes.' + c, phenotypes.columns[1:])
covariateColumns = phenotypes.columns[5:]
pprint(covariateColumns)

covariates = map(lambda c: 'sa.' + c, covariateColumns)
pprint(covariates)


# start the server
campVdsAnnotated.rest_server_linreg(covariates, True, 6063)



# export the VDS
# build path
vds_path = vcf_path.replace(".vcf",".vds")
print vds_path

# save the annotated vcf data
campVdsAnnotated.write(vds_path)





# Scratch for now, from Ryan @ UM; get this done once REST server works
# cov = hc.import_table("fusion_muscle_for_hail.tab",impute=True,types={'labelcode':TString()}).key_by("labelcode")
# vds = hc.import_vcf(vcf_path,force_bgz=True)
# vds = vds.annotate_samples_table(cov,root="sa")
# vds.write(vds_path)

