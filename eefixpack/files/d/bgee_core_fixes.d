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
