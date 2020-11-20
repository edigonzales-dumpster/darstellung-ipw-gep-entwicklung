# darstellung-ipw-gep-entwicklung

## QGIS 2.18
Für Erstellung der QML für AGI SO.

```
cd vagrant/qgis218
vagrant up
ssh -X -p 2020 vagrant@127.0.0.1 qgis
```

oder mit _x2go_ (xfc4). 

- Passwort `vagrant`.
- Host-IP (für DB-Connection und Geoserver): `192.168.56.1`


## QGIS 3.16
Für das Editieren von Daten.

```
cd vagrant/qgis316
vagrant up
ssh -X -p 2021 vagrant@127.0.0.1 qgis
```

oder mit _x2go_ (xfc4). 

- Passwort `vagrant`.
- Host-IP (für DB-Connection und Geoserver): `192.168.56.1`

## Datenbank und Geoserver

```
docker-compose up
```

### Datenbank

Die Daten bleiben auch z.B. nach `docker-compose stop` oder `docker-compose down` erhalten. Falls man mit leeren DBs neu starten möchte:

```
docker-compose down
docker volume prune
```

Credentials: 

* Hostname: `localhost`
* Port: `54321`
* DB-Name: `edit`
* Benutzer: `gretl` (für Lese- und Schreibzugriff) oder `admin` (zum Anlegen von Schemen, Tabellen usw.); das Passwort lautet jeweils gleich wie der Benutzername


### Geoserver

Credentials: `admin / geoserver`

## VSA-DSS-mini Datenmodell 

### Leere Tabellen und Schema anlegen (lokal)

Der Einfachheit halber ohne Basket- und Datasetcolumn. Dafür einmal mit Fremdschlüsseln und einmal ohne (und mit `--sqlEnableNull`).

```
java -jar /Users/stefan/apps/ili2pg-4.4.2/ili2pg-4.4.2.jar \
--dbschema vsadssmini_fk --models VSADSSMINI_2020_LV95 --modeldir "https://vsa.ch/models;http://models.geo.admin.ch" \
--defaultSrsCode 2056 --createGeomIdx --createFk --createFkIdx --createUnique --createEnumTabs --beautifyEnumDispName --createNumChecks --nameByTopic --strokeArcs \
--createscript vsadssmini_fk.sql
```

```
java -jar /Users/stefan/apps/ili2pg-4.4.2/ili2pg-4.4.2.jar \
--dbschema vsadssmini --models VSADSSMINI_2020_LV95 --modeldir "https://vsa.ch/models;http://models.geo.admin.ch" \
--defaultSrsCode 2056 --createGeomIdx --sqlEnableNull --createUnique --createEnumTabs --beautifyEnumDispName --createNumChecks --nameByTopic --strokeArcs \
--createscript vsadssmini.sql
```

Siehe https://github.com/claeis/ili2db/issues/353. Es wird auf `--createMetaInfo` verzichtet.

- 'Abwasserentsorgung bei Regenwetter'
- 'Regenüberlauf'
- 'Erhaltung von Kanalisationen'
- 'Abwasserbewirtschaftung bei Regenwetter'
- ...?


### Daten exportieren
```
java -jar /Users/stefan/apps/ili2pg-4.4.2/ili2pg-4.4.2.jar \
--dbhost localhost --dbport 54321 --dbdatabase edit --dbusr admin --dbpwd admin \
--dbschema vsadssmini --models VSADSSMINI_2020_LV95 --modeldir "https://vsa.ch/models;http://models.geo.admin.ch" \
--defaultSrsCode 2056 --createGeomIdx --sqlEnableNull --createUnique --createEnumTabs --beautifyEnumDispName --createNumChecks --nameByTopic --strokeArcs \
--disableValidation \
--export fubar.xtf
```

## Fragestellungen

### Fliessrichtung
Einstellungen in QGIS:
- Placement: Above line und Below line
- Rendering: Show up side down label = always

Ist das nun Zufall, dass es stimmt?