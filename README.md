# City Scraper


The purpose of this project is to:
* retrieve the zip codes of the Italian cities
* retrieve all the cadastral codes for the calculation of the Italian personal number


In /data/ has been put codici_istat_2016.csv, the latest release of all active cities in Italy.

```bash
~/Development/city_scraper (master)$ rake execute
```
**Zip Codes of the Italian cities**
* import data from a .csv file to an object
* scrape additional information using this object
* generate a new .csv file for db import

```bash
~/Development/city_scraper (master)$ rake get_cadastral_codes
```
**Cadastral Codes of the Italian cities**
* scrape all information from Tax Authority
* generate a new .txt output file