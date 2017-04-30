# CSL Analysis

In the subfolders are some scripts and tools for an analysis
the styles of the Citation Style Language (CSL). These scripts
are in some standard formats, e.g. XQuery, and can be reuse
hopefully easily in various ways. However, we describe here
our technology stack to work with this scripts as one example:

## CSL Styles

Start with cloning the current csl styles:
```
git clone https://github.com/citation-style-language/styles.git
```
This gives you the most recent version of the styles. If you want
to work with an older snapshot you can simply `git checkout` it.

## baseX

1. Download and install [baseX](http://basex.org/) for performing the
XQueries.
2. Open baseX
3. Create a new database (Database>New...)
   a. Select the csl styles directory
   b. Choose a reasonable name, e.g. `csl-styles`
   c. Change the file patterns to `*.csl`
   d. Click `Ok`
![basex-new-database](img/basex-new-database.jpg)
4. Open the XQuery files `.xq` from the subfolder `xquery` you are
interested in (Editor>Open...)

![basex-new-database](img/basex-csl-example.png)

## Open Refine

We use [Open Refine](http://openrefine.org/) for enrichting
our data with the help of the
[SRU interface of the ZDB](http://www.zeitschriftendatenbank.de/services/schnittstellen/sru/),
which stores informations about journals. Especially we are
interested in the
[main DDC groups](http://www.dnb.de/SharedDocs/Downloads/DE/DNB/service/ddcSachgruppenDNB.pdf?__blob=publicationFile)
for a information about the discipline of the journal.

1. Download and install [Open Refine](http://openrefine.org/).
2. Open the result of the `csl-basic-statistics.xq` TODO w/o Excel
3. Create a new column which calls the URLs and download the
result as XML data. !!For the whole data this took at least 1 hour!!
   a. Create new column based on some column
   b. Use this GREL
   ```
   "http://services.dnb.de/sru/zdb?version=1.1&operation=searchRetrieve&recordSchema=MARC21-xml&query=dnb.iss%3D"  + cells.issn.value + "+OR+" + cells.eissn.value
   ```
   c. Change the waiting time between several requests
   d. Start
   e. Wait...
4. Create a new column for extracting the DDC info
   a. Create a new column based on the previous column with the xml data
   b. Use this GREL
   ```
   uniques(forEach(value.parseHtml().select('datafield[tag=082]>subfield[code=a]'), v, htmlText(v))).join(", ")
   ```
   c. Click `OK`
5. Create a text facet from the row `ddc`
6. Cluster it to merge the same combinations with different order
7. Explore further..

![open refine](img/open-refine.png)


## Gephi

1. Download and install [Gephi](https://gephi.org/).
2. Open `csl-basic-statistics.csv` as node list TODO how to add the header before?
3. Open `csl-template.csv` as edge list
4. ...
