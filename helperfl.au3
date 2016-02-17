#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListBoxConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Global $script = ""
Global $funcsel = ""
Global $luafunctions = FileRead("luafunctions.lfl")
Global $var = ""
Global $che = ""

HotKeySet("^s", "SaveKey")
HotKeySet("^o", "LoadMnuClick")
HotKeySet("^{SPACE}", "Button2Click")
HotKeySet("^{DEL}","ClearBox")

Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=l:\saved software\forms\luahlper.kxf
Global $Form1 = GUICreate("HypArc Lua Helper", 943, 588, 193, 125)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
Global $scriptbox = GUICtrlCreateEdit("", 16, 72, 625, 449)
GUICtrlSetData($scriptbox, $script)
GUICtrlSetOnEvent($scriptbox, "scriptboxChange")
GUICtrlSetTip($scriptbox, "Use CTRL+DEL to clear.")
GUICtrlSetFont($scriptbox,14)
Global $Button1 = GUICtrlCreateButton("Save", 280, 528, 73, 25, $WS_GROUP)
GUICtrlSetOnEvent($Button1, "Button1Click")
GUICtrlSetTip($Button1, "Save your script")
Global $Funclist = GUICtrlCreateList("", 664, 72, 257, 305)
GUICtrlSetOnEvent($Funclist, "FunclistClick")
GUICtrlSetData($Funclist, $luafunctions)
GUICtrlSetTip($Funclist, "Press CTRL+SPACE to add function to script.")
GUICtrlSetFont($Funclist,14)
Global $Label1 = GUICtrlCreateLabel("Functions List", 664, 48, 69, 17)
GUICtrlSetFont($Label1, 8, 400, 0, "Tahoma")
GUICtrlSetColor($Label1, 0x800000)
GUICtrlSetOnEvent($Label1, "Label1Click")
Global $Label2 = GUICtrlCreateLabel("Script", 16, 48, 31, 17)
GUICtrlSetFont($Label2, 8, 400, 0, "Tahoma")
GUICtrlSetColor($Label2, 0x008000)
GUICtrlSetOnEvent($Label2, "Label2Click")
Global $Label3 = GUICtrlCreateLabel("HypArc Lua Helper", 392, 8, 179, 29)
GUICtrlSetFont($Label3, 16, 400, 0, "Tahoma")
GUICtrlSetColor($Label3, 0x3399FF)
GUICtrlSetOnEvent($Label3, "Label3Click")
Global $Group1 = GUICtrlCreateGroup("Info", 656, 384, 273, 121)
GUICtrlSetFont($Group1, 8, 400, 0, "Tahoma")
GUICtrlSetColor($Group1, 0x0000FF)
Global $infobox = GUICtrlCreateEdit("", 664, 408, 257, 89, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN,$WS_VSCROLL,$WS_HSCROLL, $ES_READONLY))
GUICtrlSetData($infobox, "")
GUICtrlSetOnEvent($infobox, "infoboxChange")
GUICtrlSetTip($infobox, "Information about the function")
GUICtrlSetFont($infobox,10)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Button2 = GUICtrlCreateButton("<", 648, 208, 17, 17, 0)
GUICtrlSetOnEvent($Button2, "Button2Click")
GUICtrlSetTip($Button2, "Add to script")
Global $MenuItem1 = GUICtrlCreateMenu("&File")
GUICtrlSetOnEvent($MenuItem1, "MenuItem1Click")
Global $Savemnu = GUICtrlCreateMenuItem("Save  (CTRL+S)", $MenuItem1)
GUICtrlSetOnEvent($Savemnu, "SavemnuClick")
Global $Loadmnu = GUICtrlCreateMenuItem("Load  (CTRL+O)", $MenuItem1)
GUICtrlSetOnEvent($Loadmnu, "LoadmnuClick")
Global $Helpmnu = GUICtrlCreateMenu("&Help")
GUICtrlSetOnEvent($Helpmnu, "HelpmnuClick")
Global $aboutprgm = GUICtrlCreateMenuItem("About HypArc Lua Helper", $Helpmnu)
GUICtrlSetOnEvent($aboutprgm, "aboutprgmClick")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	Sleep(100)
WEnd

Func aboutprgmClick()
	MsgBox(0, "About", "HypArc Lua Helper  Version 2.0" & @CRLF & "Credits: Red, ArcEmu/HyperSniper" & @CRLF & "Copyright Red 2009.")
EndFunc

Func Button1Click()
	$che = ""
$script = GUICtrlRead($scriptbox)
$var = FileSaveDialog("Select where to save your script",@HomeDrive,"LUA Scripts (*.lua;*.lua)",18,"*.lua")
If @error Then

Else
	FileDelete($var)
	FileWrite($var,$script)
	WinSetTitle("HypArc Lua Helper","","HypArc Lua Helper - " & $var)
	$che = "g"
EndIf

EndFunc
Func Button2Click()
$script = GUICtrlRead($scriptbox)
$funcsel = GUICtrlRead($Funclist)
If $script = "" Then
GUICtrlSetData($scriptbox,$script & $funcsel)
Else
	GUICtrlSetData($scriptbox,$script & @CRLF & $funcsel)
Endif

EndFunc
Func Edit1Change()

EndFunc
Func Form1Close()
Exit
EndFunc
Func Form1Maximize()

EndFunc
Func Form1Minimize()

EndFunc
Func Form1Restore()

EndFunc
Func FunclistClick()
$funcsel = GUICtrlRead($Funclist)
If $funcsel  = "PerformIngameSpawn(type,entry_id,map_id,x,y,z,o,faction,duration)" Then
	GUICtrlSetData($infobox, "Spawns a creature." & @CRLF & "*- Fixed the creature summon to work correctly.")
EndIf
If $funcsel = "GetPlayer(name)" Then
	GUICtrlSetData($infobox,"Retrieves player name." & @CRLF & "*- Fixed possible world crash.")
EndIf
If $funcsel = "GetLuaEngine()" Then
	GUICtrlSetData($infobox,"+- Returns what engine the server is using. Should be LuaHypArc.")
EndIf
If $funcsel = "GetLuaEngineVersion()" Then
	GUICtrlSetData($infobox,"+- Returns what version LuaHypArc on the server is.")
EndIf
If $funcsel = "GetGameTime()" Then
	GUICtrlSetData($infobox,"+- Returns server time in seconds.")
EndIf
If $funcsel = "ReloadTable(tablename)" Then
	GUICtrlSetData($infobox,"+- Reloads table tablename.")
EndIf
If $funcsel = "Rehash()" Then
	GUICtrlSetData($infobox,"+- Rehashes server config files.")
EndIf

If $funcsel = "ReloadLuaEngine()" Then
	GUICtrlSetData($infobox,"+- Reloads the Lua engine & scripts.")
EndIf
If $funcsel = "Item:GetEntryId()" Then
	GUICtrlSetData($infobox,"Returns item entry ID." & @CRLF & "*- Now fixed and working correctly.")
EndIf
If $funcsel = "Item:GetName()" Then
	GUICtrlSetData($infobox,"+- Returns Item's name.")
EndIf
If $funcsel = "Item:GetSpellId(index)" Then
	GUICtrlSetData($infobox,"+- Returns Item's index'th spell Id. 0 means the first spell on the item." )
EndIf
If $funcsel = "Item:GetSpellTrigger(index)" Then
	GUICtrlSetData($infobox,"+- Returns Item's index'th spell's trigger type. 0 means the first spell on the item." & @CRLF & "USE = 0" & @CRLF & "ON_EQUIP = 1" & @CRLF & "CHANCE_ON_HIT = 2" & @CRLF & "SOULSTONE = 4" & @CRLF & "LEARNING = 6")
EndIf
If $funcsel = "Item:GetGUID()" Then
	GUICtrlSetData($infobox,"+- Gets Item's GUID. Dodgy.")
EndIf
If $funcsel = "Item:GetRawGUID()" Then
	GUICtrlSetData($infobox,"+- Gets Item's RawGUID. Not dodgy.")
EndIf
If $funcsel = "Item:AddLoot(itemid,mincount,maxcount,ffa_loot)" Then
	GUICtrlSetData($infobox,"+- Adds loot with described parameters to Item. Good to use with SendLootWindow.")
EndIf
If $funcsel = "Unit:InitPacket(buffer_index,packet_type)" Then
	GUICtrlSetData($infobox,"Multiple uses. Not fully established.")
EndIf
If $funcsel = "Unit:AddDataToPacket(buffer_index,data_type,data)" Then
	GUICtrlSetData($infobox,"Multiple uses. Not fully established.")
EndIf
If $funcsel = "Unit:AddGuidDataToPacket(buffer_index,data_type)" Then
	GUICtrlSetData($infobox,"Multiple uses. Not fully established.")
EndIf
If $funcsel = "Unit:SendPacketToSet(buffer_index)" Then
	GUICtrlSetData($infobox,"Multiple uses. Not fully established.")
EndIf
If $funcsel = "Plyr:SendPacketToPlayer(buffer_index)" Then
	GUICtrlSetData($infobox,"+- Sends the packet stored in buffer_index to Plyr.")
EndIf
If $funcsel = "Unit:SendPacketToZone(buffer_index,zone_id)" Then
	GUICtrlSetData($infobox,"+- Sends the packet stored in buffer_index to Zone zone_id.")
EndIf
If $funcsel = "Unit:SendPacketToInstance(buffer_index,instance_id)" Then
	GUICtrlSetData($infobox,"+- Sends the packet stored in buffer_index to Instance instance_id.")
EndIf
If $funcsel = "Unit:SendPacketToWorld(buffer_index)" Then
	GUICtrlSetData($infobox,"+- Sends the packet stored in buffer_index to the world.")
EndIf
If $funcsel = "Unit:PhaseSet(newphase [,save])" Then
	GUICtrlSetData($infobox,"+- Sets the phase of Unit to newphase. save is optional, if 1 and Unit is not a player, it will save to DB.")
EndIf
If $funcsel = "Unit:PhaseAdd(newphase [,save])" Then
	GUICtrlSetData($infobox,"+- Unit becomes a member of newphase. save is optional, if 1 and Unit is not a player, it will save to DB.")
EndIf
If $funcsel = "Unit:PhaseDelete(phase [,save])" Then
	GUICtrlSetData($infobox,"+- Removes phase from Unit. save is optional, if 1 and Unit is not a player, it will save to DB.")
EndIf
If $funcsel = "Unit:GetPhase()" Then
	GUICtrlSetData($infobox,"+- Returns Unit's current phase.")
EndIf
If $funcsel = "Plyr:PlaySoundToPlayer(sound_id)" Then
	GUICtrlSetData($infobox,"+- Plays sound_id to Plyr only.")
EndIf
If $funcsel = "Plyr:GetDuelState()" Then
	GUICtrlSetData($infobox,"+- Returns the player's duel state:" & @CRLF & "DUEL_STATE_REQUESTED = 0" & @CRLF & "DUEL_STATE_STARTED = 1" & @CRLF & "DUEL_STATE_FINISHED = 2 (Default)")
EndIf
If $funcsel = "Unit:SetPosition(x,y,z)" Then
	GUICtrlSetData($infobox,"+- Instantly relocates the Unit to the specified x,y,z.")
EndIf
If $funcsel = "Unit:CastSpellOnTarget(spell_id,target)" Then
	GUICtrlSetData($infobox,"Cast specified SpellID on specified Target." & @CRLF & "*- Now working as intended, at long last. Just like CastSpell, with a target.")
EndIf
If $funcsel = "Unit:GetLandHeight(x,y)" Then
	GUICtrlSetData($infobox,"+- Get the Z of the land at (x,y). Requires V-Maps to work correctly.")
EndIf
If $funcsel = "Unit:QuestAddStarter(quest_id)" Then
	GUICtrlSetData($infobox,"+- Makes Unit a quest starter for quest_id.")
EndIf
If $funcsel = "Unit:QuestAddFinisher(quest_id)" Then
	GUICtrlSetData($infobox,"+- Makes Unit a quest finisher for quest_id.")
EndIf
If $funcsel = "Plyr:SetPlayerSpeed(speed)" Then
	GUICtrlSetData($infobox,"+- Sets the speed of Plyr (0-255).")
EndIf
If $funcsel = "Plyr:GiveHonor(amount)" Then
	GUICtrlSetData($infobox,"+- Adds amount of honour to Plyr.")
EndIf
If $funcsel = "Plyr:SetBindPoint(x,y,z,map_id,zone_id)" Then
	GUICtrlSetData($infobox,"+- Sets Plyr's Hearthstone to x,y,z in zone_id, map_id.")
EndIf
If $funcsel = "Plyr:SoftDisconnect()" Then
	GUICtrlSetData($infobox,"+- Logs out Plyr.")
EndIf
If $funcsel = "Unit:SetZoneWeather(zone_id,type,density)" Then
	GUICtrlSetData($infobox,"+- Sets the weather of zone_id to type, and density (0.3-2.0)." & @CRLF & "WEATHER_TYPE_NORMAL = 0, // NORMAL (SUNNY)" & @CRLF & "WEATHER_TYPE_FOG = 1, // FOG" & @CRLF & "WEATHER_TYPE_RAIN = 2, // RAIN" & @CRLF & "WEATHER_TYPE_HEAVY_RAIN = 4, // HEAVY_RAIN" & @CRLF & "WEATHER_TYPE_SNOW = 8, // SNOW" & @CRLF & "WEATHER_TYPE_SANDSTORM = 16 // SANDSTORM")
EndIf
If $funcsel = "Plyr:SetPlayerWeather(type,density)" Then
	GUICtrlSetData($infobox,"+- Sets the weather for Plyr ONLY." & @CRLF & "WEATHER_TYPE_NORMAL = 0, // NORMAL (SUNNY)" & @CRLF & "WEATHER_TYPE_FOG = 1, // FOG" & @CRLF & "WEATHER_TYPE_RAIN = 2, // RAIN" & @CRLF & "WEATHER_TYPE_HEAVY_RAIN = 4, // HEAVY_RAIN" & @CRLF & "WEATHER_TYPE_SNOW = 8, // SNOW" & @CRLF & "WEATHER_TYPE_SANDSTORM = 16 // SANDSTORM")
EndIf
If $funcsel = "Plyr:PlayerSendChatMessage(type,lang,msg)" Then
	GUICtrlSetData($infobox,"+- Forces Plyr to send a chat message.See existing SendChatMessage function for other arguments.")
EndIf
If $funcsel = "Unit:GetDistanceYards(target)" Then
	GUICtrlSetData($infobox,"+- Gets the distance between Unit and target in yards.")
EndIf
If $funcsel = "Unit:VendorAddItem(item_id,amount,extcost)" Then
	GUICtrlSetData($infobox,"+- Adds amount items with entry item_id and extended cost extcost to Unit.")
EndIf
If $funcsel = "Unit:VendorRemoveItem(item_guid)" Then
	GUICtrlSetData($infobox,"+- Removes the item item_guid from the vendor. Note this is NOT entry id.")
EndIf
If $funcsel = "Unit:VendorRemoveAllItems()" Then
	GUICtrlSetData($infobox,"+- Removes all the items from the vendor Unit.")
EndIf
If $funcsel = "Unit:CreatureHasQuest(quest_id)" Then
	GUICtrlSetData($infobox,"+- Returns true if Unit has quest quest_id.")
EndIf
If $funcsel = "Plyr:SendBattlegroundWindow(bg_id)" Then
	GUICtrlSetData($infobox,"+- Sends a battleground window for bg_id to Plyr." & @CRLF & "BATTLEGROUND_ALTERAC_VALLEY = 1" & @CRLF & "BATTLEGROUND_WARSONG_GULCH = 2" & @CRLF & "BATTLEGROUND_ARATHI_BASIN = 3" & @CRLF & "BATTLEGROUND_ARENA_2V2 = 4" & @CRLF & "BATTLEGROUND_ARENA_3V3 = 5" & @CRLF & "BATTLEGROUND_ARENA_5V5 = 6" & @CRLF & "BATTLEGROUND_EYE_OF_THE_STORM = 7" & @CRLF & "BATTLEGROUND_STRAND_OF_THE_ANCIENT = 9")
EndIf
If $funcsel = "Plyr:SendvendorWindow(unit)" Then
	GUICtrlSetData($infobox,"+- Sends Plyr unit's vendor window. Note that this isn't an entry id.")
EndIf
If $funcsel = "Plyr:SendTrainerWindow(unit)" Then
	GUICtrlSetData($infobox,"+- Sends Plyr unit's Trainer window. Note that this isn't an entry id.")
EndIf
If $funcsel = "Plyr:SendInnkeeperWindow(unit)" Then
	GUICtrlSetData($infobox,"+- Sends Plyr unit's inkeeper bind window. Note that this isn't an entry id.")
EndIf
If $funcsel = "Plyr:SendBankWindow(unit)" Then
	GUICtrlSetData($infobox,"+- Sends Plyr unit's bank window. Note that this isn't an entry id.")
EndIf
If $funcsel = "Plyr:SendAuctionWindow(unit)" Then
	GUICtrlSetData($infobox,"+- Sends Plyr unit's auction house window. Note that this isn't an entry id.")
EndIf
If $funcsel = "Plyr:GetInventoryItem(bag_slot,slot)" Then
	GUICtrlSetData($infobox,"+- Returns the item object in Plyr's bag bag_slot and slot number slot.")
EndIf
If $funcsel = "Plyr:GetInventoryItemById(item_id)" Then
	GUICtrlSetData($infobox,"+- Returns the item object in Plyr's inventory with entry item_id.")
EndIf 
If $funcsel = "Plyr:GetPrimaryCombatTarget()" Then
	GUICtrlSetData($infobox,"+- Returns Plyr's combat target. Should use instead of old GetTarget.")
EndIf
If $funcsel = "Unit:MoveRandomArea(x1,y1,z1,x2,y2,z2,o2)" Then
	GUICtrlSetData($infobox,"+- Moves Unit to a random point in the area.")
EndIf
If $funcsel = "Plyr:SendLootWindow(raw_GUID, loot_type)" Then
	GUICtrlSetData($infobox,"+- Sends Plyr the loot window of the object identified by raw_GUID." & @CRLF & "1-creature, regular" & @CRLF & "2-creature, skinning" & @CRLF & "3-creature, pickpocketing" & @CRLF & "4-go, regular (includes fishing schools)" & @CRLF & "5-go, herbalism/mining" & @CRLF & "6-item, regular/milling/prospecting" & @CRLF & "7-item, disenchanting")
EndIf
If $funcsel = "Unit:GetRawGUID()" Then
	GUICtrlSetData($infobox,"+- Gets the RawGUID of Unit.")
EndIf
If $funcsel = "Unit:AddLoot(itemid,mincount,maxcount,ffa_loot)" Then
	GUICtrlSetData($infobox,"+- Adds a loot item with the described parameters to Unit. Good to use for SendLootWindow or dynamic loot.")
EndIf
If $funcsel = "Unit:SetPacified(true)" Then
	GUICtrlSetData($infobox,"+- Set true to 1 to pacify the Unit. 0 to un-pacify. Good for players.")
EndIf
If $funcsel = "Unit:GetUnitByRawGUID(raw_GUID)" Then
	GUICtrlSetData($infobox,"+- Just like its GUID counterpart but uses raw_GUID.")
EndIf
If $funcsel = "Unit:PlaySpellVisualByRawGUID(raw_GUID,spellid)" Then
	GUICtrlSetData($infobox,"+- Plays the visual of spellid through the unit identified by raw_GUID. Experimental.")
EndIf
If $funcsel = "Unit:SpawnVehicle(entry,x,y,z,o,faction,duration [,phase])" Then
	GUICtrlSetData($infobox,"+- Spawns a creature as a vehicle with described parameters. Returns the vehicle spawned.")
EndIf
If $funcsel = "Plyr:SetVehicle(vehicle, seat)" Then
	GUICtrlSetData($infobox,"+- Sets Plyr's vehicle, and their seat position - a number. Set to -1 for auto-choose.")
EndIf
If $funcsel = "Plyr:GetVehicle()" Then
	GUICtrlSetData($infobox,"+- Returns the Unit for Plyr's current vehicle.")
EndIf
If $funcsel = "Plyr:RemoveFromVehicle()" Then
	GUICtrlSetData($infobox,"+- Removes Plyr from their vehicle.")
EndIf
If $funcsel = "Plyr:GetVehicleSeat()" Then
	GUICtrlSetData($infobox,"+- Returns what seat Plyr is sitting in.")
EndIf
If $funcsel = "Unit:IsVehicle()" Then
	GUICtrlSetData($infobox,"+- Returns true if Unit is a vehicle, false otherwise.")
EndIf
If $funcsel = "Unit:GetPassengerCount()" Then
	GUICtrlSetData($infobox,"+- Returns the current amount of passengers in the vehicle Unit.")
EndIf
If $funcsel = "Unit:MoveVehicle(x,y,z,o)" Then
	GUICtrlSetData($infobox,"+- Moves the vehicle Unit (with all passengers) to defined position.")
EndIf
If $funcsel = "Plyr:SetPlayerLock(Yes)" Then
	GUICtrlSetData($infobox,"- Locks the player from all control. Yes should be 1 or 0. 0 unlocks the player.")
EndIf
If $funcsel = "Plyr:MovePlayerTo(x,y,z,type)" Then
	GUICtrlSetData($infobox,"- Forces a player to move to x,y,z." & @CRLF & "0 - walk" & @CRLF & "256 - teleport" & @CRLF & "4096 - run" & @CRLF & "12288 - fly" )
EndIf

EndFunc
Func HelpmnuClick()

EndFunc
Func infoboxChange()

EndFunc
Func Label1Click()

EndFunc
Func Label2Click()

EndFunc
Func Label3Click()

EndFunc
Func Label4Click()

EndFunc
Func ClearBox()
GUICtrlSetData($scriptbox,"")
EndFunc
Func LoadmnuClick()
$che = ""
$var = FileOpenDialog("Select the LUA file you want to edit",@HomeDrive,"LUA Scripts (*.lua)",1,"*.lua")
If @error Then
	
Else
	Global $selfile = FileRead($var)
	GUICtrlSetData($scriptbox,$selfile)
	WinSetTitle("HypArc Lua Helper","","HypArc Lua Helper - " & $var)
	$che = "g"
EndIf
EndFunc
Func MenuItem1Click()

EndFunc
Func SavemnuClick()
	$che = ""
$script = GUICtrlRead($scriptbox)
$var = FileSaveDialog("Select where to save your script",@HomeDrive,"LUA Scripts (*.lua;*.lua)",18,"*.lua")
If @error Then

Else
	FileDelete($var)
	FileWrite($var,$script)
	WinSetTitle("HypArc Lua Helper","","HypArc Lua Helper - " & $var)
	$che = "g"
EndIf

EndFunc
Func SaveKey()
$script = GUICtrlRead($scriptbox)
If $che = "" Then
	MsgBox(0, "HypArc Lua Helper", "Only use this shortcut if you have already saved the file for the first time.")
Else
	FileDelete($var)
	FileWrite($var,$script)
	WinSetTitle("HypArc Lua Helper","","HypArc Lua Helper - " & $var & " [" & @HOUR & ":" & @MIN & ":" & @SEC & "]")
EndIf

EndFunc
Func scriptboxChange()

EndFunc
