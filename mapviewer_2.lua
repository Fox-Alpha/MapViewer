-- mein Mapviewer, anzeigen der PDA Map auf dem Bildschirm

mapviewer={};
mapviewer.moddir=g_currentModDirectory;

function mapviewer:loadMap(name)
	kurs = {};
	self.oSpieler = nil;
	kurs.xPos = 0.7543;
	kurs.yPos = 0.1715;
	self.mapvieweractive=false;
	self.activePlayerNode=0;
	self.loadedMap = name;
	
	--Blickrichtung
	self.kompass = {};
	self.kompass.width = 512;	--Gesamt
	self.kompass.xwidth = 214;	--tranparente Fläche
	self.kompass.x2width = 298;	--Grafik
	self.kompass.x2width = 60;	--Textfläche begin
	self.kompass.height = 64;	

	self.x=0;
	self.y=0;
	self.z=0;
	self.length=0;
	self.dX=0;
	self.dZ=0;
	self.TEntfernung=0;
	self.TRichtung=0;
	self.playerRotY=0;
	self.plyname = {};
	
	self.bigmap ={};
	self.bigmap.mapDimensionX = 2048;
	self.bigmap.mapDimensionY = 2048;
	self.bigmap.mapWidth = 1; 
	self.bigmap.mapHeight = 1; 
	self.bigmap.mapPosX = 0.5-(self.bigmap.mapWidth/2);
	self.bigmap.mapPosY = 0.5-(self.bigmap.mapHeight/2);
	self.bigmap.OverlayId = nil;
	self.bigmap.map = nil; 
	
	--Array für Fahrzeugkoordinaten
	self.bigmap.IconSteerable = {};
	self.bigmap.IconSteerable.file = "dataS2/missions/hud_pda_spot_shop.png"; 
	self.bigmap.IconSteerable.OverlayId = createImageOverlay(self.bigmap.IconSteerable.file);
	self.bigmap.IconSteerable.width = 0;
	self.bigmap.IconSteerable.height = 0;
	self.bigmap.IconSteerable.Icon = {};
	self.vehiclePosiTextT = "*"	
	self.vehiclePosiTextA = "#"	
	
	--Array für Anbauten
	self.bigmap.IconAttachments = {};
	self.bigmap.IconAttachments.file = mapviewer.moddir .. "dot_green.png"; 
	self.bigmap.IconAttachments.OverlayId = createImageOverlay(self.bigmap.IconAttachments.file);
	self.bigmap.IconAttachments.width = 0;
	self.bigmap.IconAttachments.height = 0;
	self.bigmap.IconAttachments.Icon = {};
	
	--Array für Spielerinfos
	self.bigmap.player = {};
	self.bigmap.player.ArrowOverlayId = g_currentMission.missionPDA.pdaPlayerMapArrow.overlayId;
	self.bigmap.player.name = ""; 
	self.bigmap.player.xPos	= 0;
	self.bigmap.player.xPosPDA	= g_currentMission.missionPDA.pdaMapPosX;
	self.bigmap.player.yPos = 0;
	self.bigmap.player.yPosPDA = g_currentMission.missionPDA.pdaMapPosX;	
	self.bigmap.player.width = g_currentMission.missionPDA.pdaPlayerMapArrow.width;
	self.bigmap.player.height = g_currentMission.missionPDA.pdaPlayerMapArrow.height;
	
	--debug
	-- print("Name :" .. name);
	-- print("pdaMapPosX :" .. g_currentMission.missionPDA.pdaMapPosX);
	-- print("pdaMapPosY :" .. g_currentMission.missionPDA.pdaMapPosY);
	-- print("pdaCoordsXPos :" .. g_currentMission.missionPDA.pdaCoordsXPos);
	-- print("pdaCoordsYPos :" .. g_currentMission.missionPDA.pdaCoordsYPos);

end;

function mapviewer:deleteMap()
end;

function mapviewer:mouseEvent(posX, posY, isDown, isUp, button)
	self.mouseX = posX;
	self.mouseY = posY;
end;

function mapviewer:keyEvent(unicode, sym, modifier, isDown)
	if sym==32 and isDown then
		self.mapvieweractive=not self.mapvieweractive;
		renderText(0.505, 0.04, 0.02,"Hallo Welt mein erster LS 11 Mod Sym == 32");
	end;
end;

function mapviewer:update(dt)
	if self.activePlayerNode == nil or self.activePlayerNode == 0 then
		for k,v in pairs(g_currentMission.players) do
			if k ~= nil and k ~= 0 then
				self.activePlayerNode=tonumber(k);
			end;
		end;
	end;
	
	--Spielerposition ermitteln und auf bigmap anpassen
	if self.mapvieweractive then
		if g_currentMission.player.isControlled == true then
			posX, posY, posZ = getWorldTranslation(g_currentMission.player.rootNode);
		elseif g_currentMission.player.isControlled == false then
			posX = g_currentMission.player.lastXPos;
			posY = g_currentMission.player.lastYPos;
			posZ = posY;
			self.bigmap.player.xPos	= ((((self.bigmap.mapDimensionX/2)+posX)/self.bigmap.mapDimensionX)*self.bigmap.mapWidth)-self.bigmap.player.xPosPDA+0.008;
			self.bigmap.player.yPos = ((((self.bigmap.mapDimensionY/2)-posZ)/self.bigmap.mapDimensionY)*self.bigmap.mapHeight)-self.bigmap.player.yPosPDA+0.003;
		end;
		if g_currentMission.player.isControlled == true then
			self.bigmap.player.xPos	= ((((self.bigmap.mapDimensionX/2)+posX)/self.bigmap.mapDimensionX)*self.bigmap.mapWidth)-self.bigmap.player.xPosPDA+0.008;
			self.bigmap.player.yPos = ((((self.bigmap.mapDimensionY/2)-posZ)/self.bigmap.mapDimensionY)*self.bigmap.mapHeight)-self.bigmap.player.yPosPDA+0.003;
			setTextAlignment(RenderText.ALIGN_LEFT);
			renderText(0.10, 0.030, 0.02, string.format("PlyPos: x %.4f -- y %.4f", self.bigmap.player.xPos, self.bigmap.player.yPos));	
		end;
	end;
	----------------------------------------------------
end;

function tprint (t, indent, done)
  done = done or {}
  indent = indent or 0
  for key, value in pairs (t) do
	txt = string.format("%s",string.rep ("\t", indent));
    if type (value) == "table" and not done [value] then
      done [value] = true
      print (string.format("%s[%s]:", string.rep("\t", indent), tostring (key)));
      tprint (value, indent + 1, done)
    else
      print(string.format("%s%s=%s", txt, tostring(key), tostring(value)));
    end
  end
end

function mapviewer:draw()
	if self.mapvieweractive then
		--
		--Abfrage von Objekt Eigenschaften und deren Typen
		--
		self.indent = 0;
		self.done = {};
		v_root = g_currentMission;
		--tprint(g_currentMission.attachables);
	end;

	if self.mapvieweractive then
		self.bigmap.OverlayId = createImageOverlay(Utils.getFilename("pda_map.png", self.moddir));

		if self.bigmap.OverlayId ~=nil then
			renderOverlay(self.bigmap.OverlayId, self.bigmap.mapPosX, self.bigmap.mapPosY, self.bigmap.mapWidth, self.bigmap.mapHeight);
		else
			print("Kann 'self.bigmap.OverlayId' nicht erzeugen");
		end;

		if self.bigmap.player.ArrowOverlayId ~=nil and g_currentMission.player.isControlled then
			renderOverlay(self.bigmap.player.ArrowOverlayId, self.bigmap.player.xPos, self.bigmap.player.yPos, self.bigmap.player.width, self.bigmap.player.height);
			setTextColor(0,0,0,1);
			setTextAlignment(RenderText.ALIGN_CENTER);
			renderText(self.bigmap.player.xPos+0.03 , self.bigmap.player.yPos, 0.02, g_currentMission.player.controllerName);
			setTextAlignment(RenderText.ALIGN_LEFT);
		end;

		--Hotspots auf grosse Karte
		for j=1, table.getn(g_currentMission.missionPDA.hotspots) do
			self.hsWidth = g_currentMission.missionPDA.hotspots[j].width;
			self.hsHeight = g_currentMission.missionPDA.hotspots[j].height;
			self.hsPosX = (g_currentMission.missionPDA.hotspots[j].xMapPos/2048)-(self.hsWidth/2);
			self.hsPosY = 1-(g_currentMission.missionPDA.hotspots[j].yMapPos/2048);--self.hsHeight;
			self.hsOverlayId = g_currentMission.missionPDA.hotspots[j].overlay.overlayId;
			renderOverlay(self.hsOverlayId, self.hsPosX, self.hsPosY, self.hsWidth, self.hsHeight);
				--debug
				-- print("Index HotSpots erzeugen:" .. j);
				-- print("self.hsWidth :" .. self.hsWidth);
				-- print("self.hsHeight :" .. self.hsHeight);
				-- print("self.hsPosX :" .. self.hsPosX);
				-- print("self.hsPosY :" .. self.hsPosY);
				-- print("self.hsOverlayId :" .. self.hsOverlayId);
		end;

		-- Fahrzeuge auf grosse Karte
		for i=1, table.getn(g_currentMission.steerables) do
			if not g_currentMission.steerables[i].isBroken then
				self.currentVehicle = g_currentMission.steerables[i];
				self.posX, self.posY, self.posZ = getWorldTranslation(self.currentVehicle.rootNode);
				self.buttonX = ((((self.bigmap.mapDimensionX/2)+self.posX)/self.bigmap.mapDimensionX)*self.bigmap.mapWidth);
				self.buttonZ = ((((self.bigmap.mapDimensionY/2)-self.posZ)/self.bigmap.mapDimensionY)*self.bigmap.mapHeight);
				if self.currentVehicle.isControlled and self.currentVehicle.controllerName == self.plyname.name then
					setTextColor(0, 1, 0, 1);
					renderText(self.buttonX-0.01, self.buttonZ-0.02, 0.03, string.format("%s", self.vehiclePosiTextT));
					renderText(self.buttonX-0.025, self.buttonZ-0.025, 0.015, string.format("%s", self.plyname.name));
				else
					setTextColor(1, 0, 0, 1);
					renderText(self.buttonX-0.01, self.buttonZ-0.02, 0.03, string.format("%s", self.vehiclePosiTextT));
				end;
				setTextColor(1, 1, 1,0);
			end;
		end;
		-----
		for i=1, table.getn(g_currentMission.attachables) do
			self.currentVehicle = g_currentMission.attachables[i];
			self.posX, self.posY, self.posZ = getWorldTranslation(self.currentVehicle.rootNode);
			self.buttonX = ((((self.bigmap.mapDimensionX/2)+self.posX)/self.bigmap.mapDimensionX)*self.bigmap.mapWidth);
			self.buttonZ = ((((self.bigmap.mapDimensionY/2)-self.posZ)/self.bigmap.mapDimensionY)*self.bigmap.mapHeight);
			setTextColor(1, 0, 0, 1);
			renderText(self.buttonX-0.01, self.buttonZ-0.02, 0.025, string.format("%s", self.vehiclePosiTextA));
			setTextColor(1, 1, 1,0);
		end;
		-----
	end;

	self.playerRotY = math.deg(g_currentMission.players[self.activePlayerNode].rotY);

	if math.mod(self.playerRotY,360) < 0 then
		self.TRichtung = math.mod(self.playerRotY,360) *-1;
	else
		self.TRichtung=math.mod(self.playerRotY,360);
	end;

	setTextAlignment(RenderText.ALIGN_CENTER);
	setTextColor(1,1,1,64);
	renderText(0.5-0.0273, 1-0.03,0.02, string.format("Richtung %.0f", self.TRichtung));
	setTextAlignment(RenderText.ALIGN_LEFT);
	----------------------------------------

	
	--Namen auf PDA anzeigen
		self.plyname.name = g_currentMission.player.controllerName;
		self.plyname.yPos = g_currentMission.missionPDA.pdaPlayerMapArrow.y - 0.003;
		self.plyname.xPos = g_currentMission.missionPDA.pdaPlayerMapArrow.x ;-- g_currentMission.missionPDA.pdaPlayerMapArrow.width;
	if g_currentMission.missionPDA.showPDA == true and g_currentMission.missionPDA.screen==1 then
		setTextColor(256,256,256,1);
		setTextAlignment(RenderText.ALIGN_CENTER);
		renderText(self.plyname.xPos, self.plyname.yPos, 0.02, self.plyname.name);
		setTextAlignment(RenderText.ALIGN_LEFT);
	end;
	---------------------------

end;

function mapviewer:calcdir()
	local x,y,z = localDirectionToWorld(self.rootNode, 0, 0, 1);
	local length = Utils.vector2Length(x,z);
	local dX = x/length
	local dZ = z/length
	local x,y,z = getWorldTranslation(self.rootNode);
	self.aiTractorTargetX = x;
	self.aiTractorTargetZ = z;
	local TEntfernung = math.sqrt(dX * dX + dZ * dZ)
	TRichtung = math.deg(math.atan2(dX,dZ))	
end;

addModEventListener(mapviewer);