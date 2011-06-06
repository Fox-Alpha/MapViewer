## Die Mapviewer XML anpassen

```xml+cheetah
<?xml version="1.0" encoding="utf-8" standalone="no" ?>
<mapviewer>
	<map mapWidth="1" mapHeight="1" file="gfx/pda_map.dds" mapDimensionX = "2048" mapDimensionY = "2048">
		<legende file="gfx/background.png" width="0.15" height="0.125" posX="0.0244" posY="0.15" />
		<poi usePoI="true" file="gfx/PoI_Num.png" width="2048" height="2048" />
		<icons>
			<iconPlayer  width="0.0078125" height="0.0078125" file="icons/eigenerspieler.png" />
			<iconMPPlayer  width="0.0078125" height="0.0078125" file="icons/mpspieler.png" />
			<iconSteerable  width="0.0078125" height="0.0078125" file="icons/tractor.png" />
			<iconSteerableCtrl  width="0.0078125" height="0.0078125" file="icons/tractorctrl.png" />
			<iconAttachmentFront  width="0.0078125" height="0.0078125" file="icons/feldgeraet.png" />
			<iconAttachmentRear  width="0.0078125" height="0.0078125" file="icons/feldgeraet.png" />
		</icons>
	</map>
</mapviewer>
```