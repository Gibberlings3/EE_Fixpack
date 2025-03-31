// tbd, cam
// broken DV check for bassilus
REPLACE_TRIGGER_TEXT ~ftowbe~  ~Dead("bassil")~ ~Dead("bassilus")~ 
REPLACE_TRIGGER_TEXT ~mtowbe~  ~Dead("bassil")~ ~Dead("bassilus")~ 
REPLACE_TRIGGER_TEXT ~mtowbez~ ~Dead("bassil")~ ~Dead("bassilus")~ 

// tbd, cam
// broken DV check for bassilus
REPLACE_TRIGGER_TEXT ~ftowbe~  ~Dead("FLAMHUSB")~ ~Dead("FlamingE")~ 

// tbd, cam
// mulahey stutter fix (see also mulahey.bcs) https://www.gibberlings3.net/forums/topic/35178-scripting-bugs/#comment-308786
ADD_STATE_TRIGGER mulahe 3 ~Global("TalkedToMulahey","GLOBAL",0)~  
SET_WEIGHT mulahe 7 #0 
SET_WEIGHT mulahe 3 #1 
SET_WEIGHT mulahe 0 #2 
SET_WEIGHT mulahe 1 #3 
SET_WEIGHT mulahe 5 #4 
SET_WEIGHT mulahe 6 #5 
SET_WEIGHT mulahe 8 #6

//tbd, cam
// tiax's broken charm dialogue, NVLOR for x2 talk
ALTER_TRANS tiax BEGIN 8 END BEGIN 0 END BEGIN ~REPLY~ ~~ END // blank dialogue text prevents exiting
APPEND tiax 
  IF ~RandomNum(3,1)~ THEN BEGIN tiax_common1 SAY #4216 // use his common selects as one-and-dones for repeat dialogue
    IF ~~ THEN EXIT
  END
  IF ~RandomNum(3,2)~ THEN BEGIN tiax_common2 SAY #4217
    IF ~~ THEN EXIT
  END
  IF ~RandomNum(3,3)~ THEN BEGIN tiax_common3 SAY #4218
    IF ~~ THEN EXIT
  END
END


// tbd, cam
// glanmarie and oberan have nothing to say to you on repeat visits
APPEND glanma 
  IF ~!ReactionLT(LastTalkedToBy,FRIENDLY_LOWER)~ THEN BEGIN glanma_common1 SAY #4803 // use her common select as one-and-done for repeat dialogue
    IF ~~ THEN EXIT
  END
END

APPEND oberan 
  IF ~True()~ THEN BEGIN oberan_common1 SAY #4875 // use his common select as one-and-done for repeat dialogue
    IF ~~ THEN EXIT
  END
END

// tbd, cam
// perdue says he's giving you 50 gold, but only delivers if you actually accepted the quest
REPLACE_ACTION_TEXT perdue ~GivePartyGoldGlobal("PerduePayment","GLOBAL")~ ~GivePartyGold(50)~

// tbd, graion
// mendas's dialogue triggers the wrong spell
REPLACE_ACTION_TEXT ~menda4~ ~ActionOverride("Baresh",ApplySpell(Myself,BERESH_CHANGE))~ ~ActionOverride("Baresh",ApplySpellRES("ohwi924",Myself))~

// tbd, cam (from k4thos/eet)
//https://forums.beamdog.com/discussion/comment/789128#Comment_789128
//http://redmine.beamdog.com/issues/22244
//Duplicated Neera and Dorn GAM entries
REPLACE_ACTION_TEXT ~dorn~  ~CreateCreatureObjectOffset("DORN",Myself,\[0\.0\])[%LNL%%MNL%%WNL% %TAB%]*DestroySelf()~ ~~
REPLACE_ACTION_TEXT ~neera~ ~CreateCreatureObjectOffset("NEERA",Myself,\[0\.0\])[%LNL%%MNL%%WNL% %TAB%]*DestroySelf()~ ~~

// tbd, cam (from scs)
// make gretek and friends go hostile more reliably (see also gretek.baf, arlin.cre et al)
ALTER_TRANS gretek BEGIN 1 2 END BEGIN 0 END BEGIN ACTION ~SetGlobal("DMWWGretekShout","GLOBAL",1) Enemy()~ END

// tbd, cam (from scs)
// make cydermac and friends go hostile more reliably (see also banditcy.baf)
ALTER_TRANS cyderm BEGIN 1 2 END BEGIN 0 END BEGIN ACTION ~SetGlobal("DMWWCyd","Global",1) Enemy()~ END
ALTER_TRANS cyderm BEGIN 5 END BEGIN 2 END BEGIN ACTION ~SetGlobal("DMWWCyd","Global",1) Enemy()~ END

// tbd, cam
// disable silke's chap-7-specific dialogue that implies she's at the coronation, when she's still in beregost
ADD_TRANS_TRIGGER silke 12 ~False()~ DO 0 // leads to silke dialogue about a 'wondrous party'
ADD_TRANS_TRIGGER silke 17 ~False()~ DO 2 // reply mentions you're there to save the dukes

// tbd, cam
// rasaad's quest can be missed when kicking him out under certain conditions: https://www.gibberlings3.net/forums/topic/35424-b
ADD_STATE_TRIGGER rasaadj 69 ~!Global("RASAAD_ROMANCE","GLOBAL",1)~ // nice

// tbd, cam
// when flam5 leaves, he doesn't take his cronies
ADD_TRANS_ACTION flam5 BEGIN 5 8 12 14 END BEGIN END ~ActionOverride("flam5a",EscapeArea()) ActionOverride("flam5b",EscapeArea())~

// tbd, cam
// wench at FAI has triggers for charmed and NTTT=0, 1, and 3 (?); change =3 to true() (unused, but fix anyway)
REPLACE_STATE_TRIGGER friwen 2 ~True()~

// tbd, cam
// says she's summoning guards, actually does nothing
ADD_TRANS_ACTION ftobe4 BEGIN 2 END BEGIN END ~Wait(3) CreateCreature("FLAMEN",[-1.-1],S) CreateCreature("FLAMEN2",[-1.-1],S)~

// tbd, cam
// fix 'nothing to say to you' bug, NTTT/charmed issue
REPLACE_STATE_TRIGGER helsha 8 ~True()~ // remove NTTT trigger
EXTEND_BOTTOM helsha 8
  IF ~StateCheck("ithmeera",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if ithmeera not capable of dialogue
END
REPLACE_STATE_TRIGGER ithmee 9 ~True()~ // remove NTTT trigger
EXTEND_BOTTOM ithmee 9
  IF ~StateCheck("helshara",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if helshara not capable of dialogue
END

// tbd, cam
// hentold assumes he has the dagger for states 1,2
ADD_STATE_TRIGGER hentol 1 ~HasItem("DAGG03",Myself)~ 2

// tbd, cam
// carl blindly hands off dialogue to jurgen (housg1.cre, housg2.cre assigned DVs to make this work in bulk cre fixes)
EXTEND_BOTTOM housg1 0
  IF ~StateCheck("housg2",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if partner not capable of dialogue
END
EXTEND_BOTTOM housg1 1
  IF ~StateCheck("housg2",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if partner not capable of dialogue
END
EXTEND_BOTTOM housg1 2
  IF ~StateCheck("housg2",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if partner not capable of dialogue
END

// tbd, cam
// better checks for Dunkin in Marl's dialogue (see also changes to marl.bcs)
REPLACE_STATE_TRIGGER marl 0 ~NumberOfTimesTalkedTo(0)~ // remove !Dead("Dunkin") trigger
EXTEND_BOTTOM marl 0
  IF ~StateCheck("Dunkin",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if Dunkin not capable of dialogue
END
EXTEND_BOTTOM marl 1
  IF ~StateCheck("Dunkin",CD_STATE_NOTVALID)~ THEN DO ~SetNumTimesTalkedTo(1)~ EXIT // keep it here is dunkin not dead, but unavailable
END
EXTEND_BOTTOM marl 18
  IF ~StateCheck("Dunkin",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if Dunkin not capable of dialogue
END

// tbd, cam
// not checking for farm4 before handing off dialogue (assign farm4.cre a DV for this in bulk cre fixes)
EXTEND_BOTTOM mtown2 0
  IF ~StateCheck("farm4",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if farm4 not capable of dialogue
END

// tbd, cam
// has several conditions that lead to NVLOR
EXTEND_BOTTOM nobl4 0
  IF ~StateCheck("Noblewom",CD_STATE_NOTVALID)~ THEN EXIT // exit dialogue if partner not capable of dialogue
END

// tbd, cam
// should check for ring before giving it away in charmed dialogues
ADD_STATE_TRIGGER ftobe5 4 ~HasItem("ring11",Myself)~
ADD_STATE_TRIGGER nobl8  6 ~HasItem("ring17",Myself)~

// tbd, cam
// nothing to say bug: since this is a shared dialogue between multiple diggers with different soundsets, can't do the usual of re-using a common select
REPLACE_STATE_TRIGGER digger 0 ~Global("DiggersPossessed","GLOBAL",0) RandomNum(5,1)~ // change away from NTTT triggers
REPLACE_STATE_TRIGGER digger 1 ~Global("DiggersPossessed","GLOBAL",0) RandomNum(5,2)~ // change away from NTTT triggers
REPLACE_STATE_TRIGGER digger 2 ~Global("DiggersPossessed","GLOBAL",0) RandomNum(5,3)~ // change away from NTTT triggers
REPLACE_STATE_TRIGGER digger 3 ~Global("DiggersPossessed","GLOBAL",0) RandomNum(5,4)~ // change away from NTTT triggers
REPLACE_STATE_TRIGGER digger 4 ~Global("DiggersPossessed","GLOBAL",0) RandomNum(5,5)~ // change away from NTTT triggers

// tbd, cam
// these three just have chap=7 triggers so tow never play; adding rep conditions
ADD_STATE_TRIGGER ftowba 3 ~ReputationGT(Player1,9)~  // copy rep conditions from ftowb5
ADD_STATE_TRIGGER ftowba 2 ~ReputationLT(Player1,10)~ // copy rep conditions from ftowb5
ADD_STATE_TRIGGER ftowba 1 ~ReputationLT(Player1,3)~  // copy rep conditions from ftowb5

// actions queued after joinparty() get dumped
REPLACE_ACTION_TEXT ~dorn~  ~\(ActionOverride("DORN",JoinPartyOverride())\)[%LNL%%MNL%%WNL% %TAB%]*\(ActionOverride("DORN",ChangeAIScript("DORN",OVERRIDE))\)~ ~\2 \1~
REPLACE_ACTION_TEXT ~dorn~  ~\(JoinParty()\)[%LNL%%MNL%%WNL% %TAB%]*\(ActionOverride("DORN",ChangeAIScript("DORN",OVERRIDE))\)~ ~\2 \1~
REPLACE_ACTION_TEXT ~dornp~ ~\(JoinParty()\)[%LNL%%MNL%%WNL% %TAB%]*\(ActionOverride("DORN",ChangeAIScript("DORN",OVERRIDE))\)~ ~\2 \1~

// make familiars also always get non-fatal kiss, like player1
//REPLACE_TRIGGER_TEXT SHOAL ~IsGabber(Player1)~ ~OR(2) IsGabber(Player1)  IsGabber(Familiar)~
//REPLACE_TRIGGER_TEXT SHOAL ~!OR(2) IsGabber(Player1)  IsGabber(Familiar)~ ~!IsGabber(Player1) !IsGabber(Familiar)~
APPEND SHOAL
  IF WEIGHT #-1 ~!IsGabber(Player1) !IsGabber(Player2) !IsGabber(Player3) !IsGabber(Player4) !IsGabber(Player5) !IsGabber(Player6) NumberOfTimesTalkedTo(0)~ THEN BEGIN famtalk SAY #4830
    IF ~~ THEN DO ~SetNumTimesTalkedTo(0)~ EXIT
  END
END 

// can't advance iron poisoning plot with taerom since ankheg shells keep interfering
EXTEND_BOTTOM taerom 0
  IF ~PartyHasItem("potn48") Global("bd_show_once","LOCALS",0)~ THEN REPLY #32804 DO ~SetGlobal("bd_show_once","LOCALS",1)~ GOTO 16
END   
EXTEND_BOTTOM taerom 4
  IF ~PartyHasItem("potn48") Global("bd_show_once","LOCALS",0)~ THEN REPLY #32804 DO ~SetGlobal("bd_show_once","LOCALS",1)~ GOTO 16
END   
EXTEND_BOTTOM taerom 8
  IF ~PartyHasItem("potn48") Global("bd_show_once","LOCALS",0)~ THEN REPLY #32804 DO ~SetGlobal("bd_show_once","LOCALS",1)~ GOTO 16
END   
EXTEND_BOTTOM taerom 12
  IF ~PartyHasItem("potn48") Global("bd_show_once","LOCALS",0)~ THEN REPLY #32804 DO ~SetGlobal("bd_show_once","LOCALS",1)~ GOTO 16
END   

// adoy should give belt to Player1 if Neera's dead or not present; better check for neera interjection
ALTER_TRANS NEADOY BEGIN 24 END BEGIN 0 END BEGIN ACTION  ~GiveItem("NEBELT01",Player1)~ END // 0: give to Player1 if neera dead or not present
ADD_TRANS_TRIGGER NEADOY 24 ~IfValidForPartyDialog("Neera")~ DO 1 // 1: add proper interjection checks
ADD_TRANS_TRIGGER NEADOY 24 ~!Dead("NEERA")  AreaCheckObject("OH2010","NEERA")~ DO 2 3 // 2,3: only give to neera if she's alive and present
EXTEND_TOP NEADOY 24 #1 // add alternative to 0/1 where neera is alive and present, not not valid for an interjection (silenced e.g.)
  IF ~!IfValidForPartyDialog("Neera") !Dead("NEERA") AreaCheckObject("OH2010","NEERA")~ THEN REPLY #27688 DO ~GiveItem("NEBELT01","Neera")~ GOTO 25
END
EXTEND_BOTTOM NEADOY 24 // add alternatives for 2/3: if neera dead or not present, give belt to Player1
  IF ~OR(2) Dead("NEERA") !AreaCheckObject("OH2010","NEERA")~ THEN REPLY #27689 DO ~GiveItem("NEBELT01",Player1)~ GOTO 25
  IF ~OR(2) Dead("NEERA") !AreaCheckObject("OH2010","NEERA")~ THEN REPLY #27690 DO ~GiveItem("NEBELT01",Player1)~ GOTO 25
END

/////                                                  \\\\\
///// mixing instants and non-instants                 \\\\\
/////                                                  \\\\\

// https://www.gibberlings3.net/forums/topic/39370-pstee-respawned-bariaur-should-not-talk-like-you-parted-on-friendly-terms/

ALTER_TRANS DORN BEGIN 15 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(30816,INFO)
ActionOverride("DORN",ChangeAIScript("DORN",OVERRIDE))
SetGlobal("BACKFROMAMBUSH","GLOBAL",1)
ChangeEnemyAlly("DORN",NEUTRAL)
SetGlobal("DORNPARTY","GLOBAL",0)
SetDialog("DORNP")
EscapeAreaMove("AR2301",1132,727,S)~
END

ALTER_TRANS DORN BEGIN 15 END BEGIN 1 END BEGIN ACTION
~AddJournalEntry(30816,INFO)
ActionOverride("DORN",ChangeAIScript("DORN",OVERRIDE))
SetGlobal("BACKFROMAMBUSH","GLOBAL",1)
ChangeEnemyAlly("DORN",NEUTRAL)
SetGlobal("DORNPARTY","GLOBAL",0)
SetDialog("DORNP")
EscapeAreaMove("AR2301",1132,727,S)~
END

ALTER_TRANS EDWINJ BEGIN 11 END BEGIN 0 END BEGIN ACTION
~ActionOverride("Dynaheir",DialogInterrupt(FALSE))
EraseJournalEntry(27171)
EraseJournalEntry(27274)
EraseJournalEntry(27275)
EraseJournalEntry(27031)
LeaveParty()
ChangeAIScript("",DEFAULT)
ActionOverride("dynaheir",SetDialog("dynahe"))
SetGlobal("Handle_it_yourselves","GLOBAL",1)
SetGlobal("Edwinfight2","GLOBAL",1)
SetDialog("edwin")~
END

ALTER_TRANS EDWINJ BEGIN 11 END BEGIN 1 END BEGIN ACTION
~ActionOverride("Dynaheir",DialogInterrupt(FALSE))
EraseJournalEntry(27171)
EraseJournalEntry(27274)
EraseJournalEntry(27275)
EraseJournalEntry(27031)
ActionOverride("Minsc",LeaveParty())
ActionOverride("Minsc",ChangeAIScript("",DEFAULT))
ActionOverride("Minsc",SetDialog("minsc"))
LeaveParty()
ActionOverride("dynaheir",SetDialog("dynahe"))
SetGlobal("Handle_it_yourselves","GLOBAL",1)
SetGlobal("minsc_with_dynaheir","GLOBAL",1)
SetGlobal("Edwinfight2","GLOBAL",1)
SetDialog("edwin")~
END

ALTER_TRANS FLAMAL BEGIN 1 END BEGIN 0 END BEGIN ACTION // if EA doesn't work after starting a cutscene, see capcut01.bcs edit in bgee.tph
~ActionOverride("Aldeth",EscapeArea())
ActionOverride("Brandi",EscapeArea())
ActionOverride("ffhunt1",EscapeArea())
ActionOverride("ffhunt2",EscapeArea())
ActionOverride("ffhunt3",EscapeArea())
SetGlobal("Captured","GLOBAL",1)
ClearAllActions()
StartCutSceneMode()
StartCutScene("Capcut01")
EscapeArea()~
END

ALTER_TRANS HULL BEGIN 1 END BEGIN 0 END BEGIN ACTION
~AddexperienceParty(50)
TakePartyItem("SW1H12")
GivePartyGold(20)
SetGlobal("HelpHull","GLOBAL",1)
EraseJournalEntry(27149)
AddJournalEntry(27150,QUEST_DONE)
FillSlot(SLOT_WEAPON1)
EquipMostDamagingMelee()~
END

ALTER_TRANS HULL BEGIN 3 END BEGIN 0 END BEGIN ACTION
~AddexperienceParty(50)
TakePartyItem("SW1H12")
GivePartyGold(10)
SetGlobal("HelpHull","GLOBAL",1)
EraseJournalEntry(27149)
AddJournalEntry(27151,QUEST_DONE)
FillSlot(SLOT_WEAPON1)
EquipMostDamagingMelee()~
END

ALTER_TRANS IMOENP BEGIN 1 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KickedOut","LOCALS",1)
ChangeAIScript("",DEFAULT)
EscapeArea()~
END

ALTER_TRANS KIELPC BEGIN 0 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KielPC","AR0512",2)
MoveToPoint([1830.904])
OpenDoor("Door09")
MoveToPoint([2052.974])
MoveToPoint([2092.924])
Deactivate("Lever1")
Deactivate("Lever2")
Deactivate("Lever3")
Deactivate("Lever6")
Deactivate("Lever7")
Activate("Lever 8")
MoveToPoint([2135.890])
StartDialogueNoSet([PC])~
END

ALTER_TRANS KIELPC BEGIN 1 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KielPC","AR0512",3)
Deactivate("Lever4")
Deactivate("Lever5")
Activate("Lever9")
Activate("Lever10")
Activate("Lever11")
MoveToPoint([2357.930])
MoveToPoint([2488.839])
MoveToPoint([2631.966])
MoveToPoint([2350.1215])
MoveToPoint([2294.1341])
MoveToPoint([2047.1371])
StartDialogueNoSet([PC])~
END

ALTER_TRANS KIELPC BEGIN 2 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KielPC","AR0512",4)
MoveToPoint([2169.1371])
MoveToPoint([2252.1452])
MoveToPoint([2218.1517])
OpenDoor("Door13")
MoveToPoint([2115.1652])
StartDialogueNoSet([PC])~
END

ALTER_TRANS KIELPC BEGIN 3 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KielPC","AR0512",5)
MoveToPoint([1816.1815])
MoveToPoint([1623.1679])
MoveToPoint([1520.1601])
MoveToPoint([1410.1644])
MoveToPoint([1424.1841])
MoveToPoint([1560.1877])
MoveToPoint([1716.2025])
MoveToPoint([1698.2129])
MoveToPoint([1563.2212])
MoveToPoint([1410.2159])
MoveToPoint([1306.2063])
MoveToPoint([1217.1969])
MoveToPoint([1130.1929])
MoveToPoint([1040.1933])
OpenDoor("Door15")
MoveToPoint([1005.2247])
StartDialogueNoSet([PC])~
END

ALTER_TRANS NEERA BEGIN 7 END BEGIN END BEGIN ACTION
~SetGlobal("RedWizards","AR3300",5)
SetGlobal("NEERA_START","GLOBAL",1)
ApplySpellRES("OHNMODE2",Myself)~
END

ALTER_TRANS NEERA BEGIN 13 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(31608,INFO)
SetGlobal("NEERAPARTY","GLOBAL",0)
SetDialog("NEERAP")
EscapeAreaMove("AR2301",750,400,SW)~
END

ALTER_TRANS NEERAP BEGIN 2 END BEGIN 1 END BEGIN ACTION // SetDialog can't be moved after joinparty, so we AO it
~SetGlobal("KickedOut","LOCALS",0)
SetGlobal("NEERAPARTY","GLOBAL",1)
ActionOverride("NEERA",ChangeAIScript("NEERA",OVERRIDE))
SetGlobalTimer("NEERATIMER","GLOBAL",ONE_DAY)
ActionOverride("NEERA",SetDialog("NEERAJ"))
JoinParty()~
END

ALTER_TRANS PERDUE BEGIN 14 END BEGIN 0 END BEGIN ACTION
~TakePartyItem("SW1H17")
GivePartyGold(50)
AddexperienceParty(500)
SetGlobal("HelpPerdue","GLOBAL",2)
EraseJournalEntry(27354)
EraseJournalEntry(27355)
AddJournalEntry(27356,QUEST_DONE)
FillSlot(SLOT_WEAPON0)
EquipMostDamagingMelee()~
END

ALTER_TRANS RASAADP BEGIN 1 2 END BEGIN 1 END BEGIN ACTION
~SetGlobal("KickedOut","LOCALS",1)
SetGlobal("RASAAD_IN_PARTY","GLOBAL",0)
SetGlobal("RASAADKicked","AR4800",1)
SetDialog("RASAADP")
EscapeAreaMove("AR4800",1100,782,S)~
END

ALTER_TRANS RSBASSAN BEGIN 20 END BEGIN 0 END BEGIN ACTION
~ApplySpell(Myself,WIZARD_IMPROVED_INVISIBILITY)
SetGlobal("ohprisoner","oh3020",5)
SmallWait(15)
JumpToPoint([1596.1906])~
END

ALTER_TRANS SILKE BEGIN 10 END BEGIN 0 END BEGIN ACTION
~ReputationInc(-2)
GivePartyGoldGlobal("SilkePayment","GLOBAL")
SetGlobal("SilkePay","GLOBAL",1)
SetPlayerSound(Myself,4697,SELECT_COMMON1)~
END

ALTER_TRANS TENYA BEGIN 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("HelpTenya","GLOBAL",2)
TakePartyItem("MISC53")
AddexperienceParty(1000)
SetGlobal("TalkedToTenya","GLOBAL",1)
SetGlobal("HelpJebadoh","GLOBAL",3)
EraseJournalEntry(27440)
EraseJournalEntry(27439)
EraseJournalEntry(27441)
EraseJournalEntry(27442)
EraseJournalEntry(27443)
EraseJournalEntry(27444)
EraseJournalEntry(27445)
EraseJournalEntry(27446)
ForceSpell(Myself,DRYAD_TELEPORT)~
END

ALTER_TRANS ZHURLO BEGIN 4 END BEGIN 0 END BEGIN ACTION
~AddexperienceParty(300)
TakePartyItem("boot02zh")
GivePartyGold(1000000)
SetGlobal("HelpZhurlong","GLOBAL",1)
EraseJournalEntry(27519)
FillSlot(SLOT_BOOTS)~
END
