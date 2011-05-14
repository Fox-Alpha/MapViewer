Meine nächste Version des MapViewers steht in den Startlöchern.
Ich muss nur noch ein paar Kleinigkeiten ausbügeln.

Besonders habe ich mich darauf konzentriert das der MapViewer unabhängig auf die PDA_Map der geladenen Karte zugreifen kann.
Dies funktioniert auch schon nach meinen Tests ohne schwierigkeiten.

Die Einbindung der PoI (Points of interessts) und der Feldnummerierung muss ich noch so gestalten das dies nach Möglichkeit ohne User Eingriff geschehen kann. Hierzu habe ich mir ein einfaches Konzept überlegt, wobei allerdings die Mithilfe der Mapper gefragt ist. (Details unter :)

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