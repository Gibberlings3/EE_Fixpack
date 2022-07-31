// tbd, cam
// broken DV check for bassilus
REPLACE_TRIGGER_TEXT ~ftowbe~  ~Dead("bassil")~ ~Dead("bassilus")~ 
REPLACE_TRIGGER_TEXT ~mtowbe~  ~Dead("bassil")~ ~Dead("bassilus")~ 
REPLACE_TRIGGER_TEXT ~mtowbez~ ~Dead("bassil")~ ~Dead("bassilus")~ 

// tbd, cam
// broken DV check for bassilus
REPLACE_TRIGGER_TEXT ~ftowbe~  ~Dead("FLAMHUSB")~ ~Dead("FlamingE")~ 

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
