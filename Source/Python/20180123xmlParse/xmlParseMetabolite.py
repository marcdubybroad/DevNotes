
# inports
import xml.etree.ElementTree

# load the file and parse
eTree = xml.etree.ElementTree.parse('/Users/mduby/Google Drive/Broad/Documents/Work/Broad/Projects/20180109metabolitesXml/Data/testMetabolite.xml').getroot()
eTree = xml.etree.ElementTree.parse('/home/ubuntu/Data/Metabolites/hmdb_metabolites.xml').getroot()



# parse the file
for metabolite in eTree.findall('metabolite'):
  print(metabolite.get('accession'))
  
  
  



from xml.dom import minidom

xmldoc = minidom.parse('/Users/mduby/Google Drive/Broad/Documents/Work/Broad/Projects/20180109metabolitesXml/Data/testMetabolite.xml')
xmldoc = minidom.parse('/Users/mduby/Google Drive/Broad/Documents/Work/Broad/Projects/20180109metabolitesXml/Data/hmdb_metabolites.xml')
xmldoc = minidom.parse('/home/ubuntu/Data/Metabolites/hmdb_metabolites.xml')

itemlist = xmldoc.getElementsByTagName('metabolite')

print(len(itemlist))

for metabolite in itemlist:
    accensionlist = metabolite.getElementsByTagName('accession')
    for accension in accensionlist:
        print accension.firstChild.nodeValue
    taxonomyList = metabolite.getElementsByTagName('taxonomy')
    for taxonomy in taxonomyList:
        descriptionList = taxonomy.getElementsByTagName('description')
        for description in descriptionList:
            print description.firstChild.nodeValue
        directParent = taxonomy.getElementsByTagName('direct_parent')[0].firstChild.nodeValue            
        print directParent
        superClass = taxonomy.getElementsByTagName('super_class')[0].firstChild.nodeValue            
        print superClass
        otherClass = taxonomy.getElementsByTagName('class')[0].firstChild.nodeValue            
        print otherClass
        molecularFramework = taxonomy.getElementsByTagName('molecular_framework')[0].firstChild.nodeValue            
        print molecularFramework
    keggId = metabolite.getElementsByTagName('kegg_id')[0].firstChild.nodeValue            
    print keggId
    print('----------------------')
    
    
    

    




