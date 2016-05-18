#Panama Papers
The Panama Papers are 11.5 million leaked documents that detail financial and attorney–client information for more than 214,488 offshore entities. The leaked documents were created by Panamanian law firm and corporate service provider Mossack Fonseca;[2] some date back to the 1970s.

The leaked documents illustrate how wealthy individuals, including public officials, are able to keep personal financial information private.While offshore business entities are often not illegal, reporters found that some of the shell corporations were used for illegal purposes, including fraud, kleptocracy, tax evasion, and evading international sanctions."

Source: Wikipedia

##Database released by ICIJ
On 10th May 2016, the ICIJ make available the complete database for download in CSV format. The compressed file size is 41 Mb.
The following image shows the CSV files and relations between them. As we can see the main concepts are Addresses, Intermediaries, Officers, Entities (Offshore Companies) and the relations between them (all_edges.csv).
Paname Papers CSVs files and relations between them.
![panamapaperscsv](https://cloud.githubusercontent.com/assets/4923203/15346486/9b3d76a8-1c86-11e6-82cd-7b0bd11ce07b.png)

In general, the structure of the CSV files is easy to understand. all_edges.csv contains the relations between the different nodes that compose the Panama Papers, this CSV file defines 69 types of relations between the entities in total.

Source: ICJI Official Web Site

##Panama papers into OntoFuhSen vocabulary
The following goals motivated the transformation of the "Panama Papers" data into LiDaKrA Organized Crime vocabulary:
* As dataset example for LiDaKrA project. Notice this data set can be enriched with other open data sources such as DBPedia.
* To validate and extend the Organized Crime vocabulary.

The following image despites the process we followed to transform the CSV files into OntoFuhSen vocabulary for organized crime.
![panamapaperstransformationprocess](https://cloud.githubusercontent.com/assets/4923203/15346492/ad28c91c-1c86-11e6-9c16-87a1165d5240.png)

The process to transform CSV files into OntoFuhSen vocabulary for organized crime analysis.

The Panama Papers CSV files can be download from the following link: https://offshoreleaks.icij.org/pages/database

The Mapping files and project for SILK framework can be found here: 
https://github.com/LiDaKrA/data-integration-workspace/tree/master/Workspace/LeaksMappings

###OntoFuhSen vocabulary
Our vocabulary was extended with concepts, the new concepts: Address, Country, OffshoreCompany, Officer, Intermediary, and Bank.
Note: These changes are still under revision.

The following image despites some of the classes of the vocabulary involved in this process.
![organizedcrime_ontology3](https://cloud.githubusercontent.com/assets/4923203/15346498/bcfa6508-1c86-11e6-9258-7d68e65b3042.png)

###Final result
The final result of this process is an RDF dump containing the database graph with the Panama Papers data. The following are examples of SPARQL queries we can execute.
 
Top 25 Countries
```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX fs: <http://vocab.lidakra.de/fuhsen#>
 
SELECT *
WHERE {
  ?s rdf:type fs:Country .
}
LIMIT 25
```
Intermediaries from Bolivia
```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX fs: <http://vocab.lidakra.de/fuhsen#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
 
SELECT ?s ?name
WHERE {
  ?s rdf:type fs:Intermediary .
  ?s foaf:name ?name .
  ?s fs:intermediaryHasCountry ?country .
  ?country fs:code "BOL"    
}
LIMIT 200
```

Addresses from Germany
```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX fs: <http://vocab.lidakra.de/fuhsen#>
 
SELECT ?s ?value
WHERE {
  ?s rdf:type fs:Address .
  ?s fs:addressValue ?value .
  ?s fs:addressHasCountry ?country .
  ?country fs:code "DEU"    
}
LIMIT 200
```

Officers from Germany
```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX fs: <http://vocab.lidakra.de/fuhsen#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
 
SELECT ?s ?name
WHERE {
  ?s rdf:type fs:Officer .
  ?s foaf:name ?name .
  ?s fs:officerHasCountry ?country .
  ?country fs:code "DEU"    
}
LIMIT 200
```

Offshore companies from Germany
```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX fs: <http://vocab.lidakra.de/fuhsen#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
 
SELECT ?s ?name
WHERE {
  ?s rdf:type fs:OffshoreCompany .
  ?s foaf:name ?name .
  ?s fs:offshoreCompanyCountry ?country .
  ?country fs:code "DEU"    
}
LIMIT 200
```
Name of the entities that are "Chairman of"
```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX fs: <http://vocab.lidakra.de/fuhsen#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
 
SELECT DISTINCT *
WHERE {
  ?r rdf:type fs:Relation .
  ?r rdfs:label "Chairman of" .
  ?r fs:node_1 ?isChairmanOf .
  ?isChairmanOf foaf:name ?name .
}
LIMIT 200
```
Name and relations from entitiy 90939
```
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX fs: <http://vocab.lidakra.de/fuhsen#>
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
 
SELECT DISTINCT *
WHERE {
  ?r rdf:type fs:Relation .
  ?r rdfs:label ?label .
  ?r fs:node_1 <http://vocab.lidakra.de/fuhsen/panama_papers/node#90939> .
  <http://vocab.lidakra.de/fuhsen/panama_papers/node#90939> foaf:name ?name .
}
LIMIT 200
```

###Related Project
Today (17.05.2016) OntoText company announced "Linked Leaks" project.
"Linked Leaks, an Ontotext portal, publishes this data as a knowledge graph, according to the Linked Open Data principles. This allows one to enter the URL identifier of the an entity or a person (say,http://data.ontotext.com/resource/leaks/entity-123456) in a web browser to see all the information available in for this entity in the database."
Source: Linked Leaks Official Web Site

They provide their vocabulary, the dataset in RDF format under their vocabulary, and also an SPARQL access point to query the data online.

###Get the final RDF file
If you want to get the latest RDF file, please contact collaran@cs.uni-bonn.de
