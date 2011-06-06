Meine neueste Version steht seit dem 14.05.2011 zum Download. Zufinden auf [[http://www.Modhoster.de|http://www.modhoster.de/mods/fox-alpha-beta-mapviewer--5]]

Besonders habe ich mich darauf konzentriert das der MapViewer unabhängig auf die PDA_Map der geladenen Karte zugreifen kann.  

Jeder Mapper oder auch Spieler kann auf einfache weise, die Einbindung der PoI (Points of interessts) und der Feldnummerierung vornehmen. Hierzu ist es nur notwendig dei entsprechende Grafik in der Map.zip mit bereitzustellen.
Eine Anleitung zum erstellen findet sich unter : [[https://github.com/Fox-Alpha/MapViewer/wiki/Mapviewer-Feldnummern-und-PoI-erstellen]]

MapViewer V0.4 Changelog
========================
  + Dynamisches laden der PDA Map aus der verwendendeten Karte  
    - /map01/pda_map.png/.dds  
    - Kein manuelles bearbeiten der ZIP Datei mehr notwendig  
	- Klappt auf allen getesteten Karten  

  + Laden der Feldnummern aus dem Mapzip, wenn vorhanden
    - /map01/MV_Feldnummern.png
  
  + Laden der PoI aus dem Mapzip, wenn vorhanden
    - /map01/MV_PoI.png
  
  + Umschalten der Mapgroesse von 2048 auf 4096
	- Keine Einstellungen mehr in der XML notwendig
	+ ALT+M Umschalten der Mapgroesse von 2048 auf 4096

  + Durchschalten der PoI und Feldnummern
	+ Kann PoI und Feldnummern als seperates Overlay laden
    - Feldnummern und PoI können als eigene Overlay Dateien in der xml hinterlegt werden
    + Y Durchschalten der PoI und Feldnummern
	
  + Aufräumen des Quelltextes
    -- Überflüssige Scriptzeilene entfernt
	-- Bessere Kommentare eingefügt