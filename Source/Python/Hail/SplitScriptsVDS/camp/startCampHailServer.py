
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

# set the VDS path
VDS_PATH = "/home/ubuntu/MountedData/Hail/VDS/Camp/camp.vds"
pprint("VDS file: " + VDS_PATH)

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
vdsAnnotated = hc.read(VDS_PATH)

# load covariates
# covariates = map(lambda c: 'sa.phenotypes.' + c, phenotypes.columns[1:])
itemsForCovariates = ['t2d', 'BMI', 'FAST_GLU', 'FAST_INS', 'C1', 'C2', 'C3', 'C4', 'C5', 'C6']
pprint(itemsForCovariates)

covariateColumns = []
for item in itemsForCovariates:
    covariateColumns.append(item)


pprint(covariateColumns)

# create covariate array?
covariates = map(lambda c: 'sa.' + c, covariateColumns)
pprint(covariates)


# start the server
vdsAnnotated.rest_server_linreg(covariates, False, SERVER_PORT)







# Scratch for now, from Ryan @ UM; get this done once REST server works
# cov = hc.import_table("fusion_muscle_for_hail.tab",impute=True,types={'labelcode':TString()}).key_by("labelcode")
# vds = hc.import_vcf(vcf_path,force_bgz=True)
# vds = vds.annotate_samples_table(cov,root="sa")
# vds.write(vds_path)

