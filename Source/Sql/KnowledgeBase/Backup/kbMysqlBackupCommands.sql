
mysqldump -u dig_qa -p -h digdiabetesdb.broadinstitute.org dig_qa `cat ./metadataTableList.txt` > 20160303kbCommonTablesDump.sql

mysqldump -u root gene8 `cat ./metadataTableList.txt` > 20160303kbCommonTablesDump.sql

