
# import os, sys, IPython - from Ryan@UM
import os, sys
from os import path
from glob import glob
from pprint import pprint

# set the constants
# set up Hail home
# REST branch compiled hail
HAIL_HOME = "/home/ubuntu/hail_server/jonHailTree20171114"
# set up SPARK home
SPARK_HOME = "/home/ubuntu/Software/spark-2.0.2-bin-hadoop2.7"
# set the REST server port
SERVER_PORT = 6066
pprint("server port: " + str(SERVER_PORT))
# set the log file path
LOG_FILE_PATH = "/home/ubuntu/Logs/HailServers/hail" + str(SERVER_PORT) + ".log"
pprint("log file: " + LOG_FILE_PATH)
# set the VCF path
VCF_PATH = "/home/ubuntu/Data/Hail/Biome/BIOME_ILL.CLUSTERED.clean.epacts.vcf"
pprint("vcf file: " + VCF_PATH)
# set the phenotype file path and sample key
PHENOTYPE_FILE_PATH = "/home/ubuntu/Data/Hail/Biome/biome_illumina.ped"
pprint("ped file: " + PHENOTYPE_FILE_PATH)
SAMPLE_KEY = "IID"


# Setup HAIL and PYTHONPATH
PY4J_ZIPS = glob(path.join(SPARK_HOME,"python/lib/py4j-*-src.zip"))
PYTHON_LIBS = [
  "{}/python".format(HAIL_HOME),
  "{}/python".format(SPARK_HOME),
] + PY4J_ZIPS + os.environ.get("PYTHONPATH","").split(":")
PYTHONPATH = ":".join(PYTHON_LIBS)
sys.path = PYTHON_LIBS + sys.path

# set the Spark classpath; one line each for distribution Hail and one for Jon's branch of the code
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
hc = HailContext(log=LOG_FILE_PATH)


# import the CVF
vds = hc.import_vcf(VCF_PATH)

# load in phenotypes
# use impute = True to let hail determine the type of the columns
phenotypes = hc.import_table(PHENOTYPE_FILE_PATH, impute=True, types={SAMPLE_KEY: TString()}).key_by(SAMPLE_KEY)
pprint(phenotypes)


# annotate the loaded vds
vdsAnnotated = vds.annotate_samples_table(phenotypes, root="sa")
pprint(vdsAnnotated.sample_schema)


# load covariates
# covariates = map(lambda c: 'sa.phenotypes.' + c, phenotypes.columns[1:])
itemsForCovariates = ['C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'BMI', 'CHOL', 'LDL', 'HDL', 'SBP', 'DBP', 'FAST_GLU', 'HBA1C', 'SEX', 'AGE']
pprint(itemsForCovariates)

covariateColumns = []
for item in phenotypes.columns:
  if item in itemsForCovariates:
    covariateColumns.append(item)


pprint(covariateColumns)
# covariateColumns = phenotypes.columns[20:30]
# pprint(covariateColumns)

covariates = map(lambda c: 'sa.' + c, covariateColumns)
pprint(covariates)


# start the server
vdsAnnotated.rest_server_linreg(covariates, False, SERVER_PORT)



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

