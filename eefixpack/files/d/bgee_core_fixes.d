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