
import os, sys
# import os, sys, IPython - from Ryan@UM
from os import path
from glob import glob
from pprint import pprint

# set up Hail home
#  entries, one for the packaged distribution that works, another for the REST branch compiled distribution that doesn't
# packaged Hail
# REST branch compiled hail
HAIL_HOME = "/home/ubuntu/hail_server/jonHailTree20171114"

# set up SPARK home
SPARK_HOME = "/home/ubuntu/Software/spark-2.0.2-bin-hadoop2.7"

# set the REST server port
SERVER_PORT = 6063
pprint("server port: " + str(SERVER_PORT))

# set the log file path
LOG_FILE_PATH = "/home/ubuntu/Logs/HailServers/hail" + str(SERVER_PORT) + ".log"
pprint("log file: " + LOG_FILE_PATH)

# set the VCF path
VCF_PATH = "/home/ubuntu/Data/Hail/Camp/camp.biallelic.chr1-22.clean.vcf"
pprint("vcf file: " + VCF_PATH)

# set the VDS path
VDS_PATH = "/home/ubuntu/MountedData/Hail/VDS/Camp/camp.vds"
pprint("VDS file: " + VDS_PATH)

# set the phenotype file path and sample key
# PHENOTYPE_FILE_PATH = "/home/ubuntu/Data/Hail/Biome/biome_illumina.ped"
PHENOTYPE_FILE_PATH = "/home/ubuntu/Data/Hail/Camp/camp.phenotypes.epacts.withId.modified.ped"
pprint("ped file: " + PHENOTYPE_FILE_PATH)
SAMPLE_KEY = "ID"


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
phenotypes = hc.import_table(PHENOTYPE_FILE_PATH, impute=True).key_by(SAMPLE_KEY)
pprint(phenotypes)


# annotate the loaded vds
vdsAnnotated = vds.annotate_samples_table(phenotypes, root="sa")
pprint(vdsAnnotated.sample_schema)

# write out the VDS file
vdsAnnotated.write(VDS_PATH)





# Scratch for now, from Ryan @ UM; get this done once REST server works
# cov = hc.import_table("fusion_muscle_for_hail.tab",impute=True,types={'labelcode':TString()}).key_by("labelcode")
# vds = hc.import_vcf(vcf_path,force_bgz=True)
# vds = vds.annotate_samples_table(cov,root="sa")
# vds.write(vds_path)

