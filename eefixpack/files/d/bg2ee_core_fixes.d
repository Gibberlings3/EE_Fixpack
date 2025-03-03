// tbd, cam
// anomen not properly tracking relationship
ADD_TRANS_ACTION banomen BEGIN 434 END BEGIN END ~SetGlobal("AnomenRomanceActive","GLOBAL",2)~
ADD_TRANS_ACTION banomen BEGIN 399 437 464 END BEGIN END ~SetGlobal("AnomenRomanceActive","GLOBAL",3)~

// tbd, cam (two issues here, see yoshimo.bcs)
// Yoshimo Should Have Follow-Up Banters with the PC
ADD_TRANS_ACTION byoshim BEGIN 11 END BEGIN END ~SetGlobalTimer("YoshimoTalksPC2","GLOBAL",FIVE_DAYS)~ // add timer to prompt second banter

// tbd, cam
// ranger stronghold fails if you're in Umar Hills when Delon spawn timer expires; see also ar1100.bcs
ADD_TRANS_ACTION delon BEGIN 21 END BEGIN END ~SetGlobal("CDDelonSpoke","GLOBAL",1)~

// tbd, cam (from jmerry)
// rasaad can duplicate crit items; re-ordering actions fixes the issue
REPLACE_ACTION_TEXT ~rasaadj~ ~LeaveParty()[ %TAB%%WNL%]*GivePartyAllEquipment()~ ~GivePartyAllEquipment() LeaveParty()~ 

//tbd, cam
// missing journal entries; make outro flow better by adding player reply about cloak
ADD_TRANS_ACTION udsola01 BEGIN 121 END BEGIN 1 END ~EraseJournalEntry(97332)AddJournalEntry(97332,QUEST_DONE)AddJournalEntry(97333,QUEST)~
ALTER_TRANS udsola01 BEGIN 138 144 END BEGIN 0 END // filename, state, trans
BEGIN // list of changes, see below for flags
  ~REPLY~ ~#51710~
END 

// tbd, cam (from jmerry)
// npcs spawning/moving on impassable terrain (see also ar0800.are, ar1000.are)
REPLACE_ACTION_TEXT aeriej ~MoveGlobal("AR0607","Aerie",\[1034.1034\])~ ~MoveGlobal("AR0607","Aerie",[469.437])~
REPLACE_ACTION_TEXT baerie ~MoveGlobal("AR0607","Aerie",\[1034.1034\])~ ~MoveGlobal("AR0607","Aerie",[469.437])~

// tbd, cam (from MiH)
// the option to ask Karthis al-Hezzar about the fire giants should be there on future visits
EXTEND_TOP "hgkar01" 8 #1 IF ~~ REPLY #73162 GOTO 14 END

// tbd, cam (from MiH)
// blessed bracers should be an option to resurrect dad in saradush
EXTEND_TOP "orphan1" 3 #3
  IF ~HasItemEquiped("brac23",LastTalkedToBy(Myself))~ REPLY @102 DO 
~ClearAllActions()
StartCutSceneMode()
FadeToColor([20.0], 0)
Wait(2)
MoveViewPoint([2402.1482], INSTANT)
ActionOverride(LastTalkedToBy(Myself), JumpToPoint([2386.1386]))
ActionOverride(LastTalkedToBy(Myself), Face(S))
FadeFromColor([20.0], 0)
Wait(1)
ActionOverride(LastTalkedToBy(Myself), ForceSpellRES("jworphan","orphan2"))
Wait(5)
EndCutSceneMode()~ 
  EXIT
END

// Fixes an exploit that would allow the party to bypass the Oasis when travelling to Amkethran
// via Deepstone Clanhold (Rasaad's quest) or the Clearing (Neera's quest).
// https://www.gibberlings3.net/forums/topic/34875-bug-report-ee-content-bugs/?do=findComment&comment=339326
REPLACE_TRANS_ACTION ~sarmel01~
  BEGIN 83 END
  BEGIN 0 END
  ~RevealAreaOnMap("AR5500")~ ~\0 RemoveWorldmapAreaFlag("AR5500",ENABLED)~
  UNLESS ~RemoveWorldmapAreaFlag("AR5500",ENABLED)~
  
// can ask about voghilin's hunger without him mentioning he's hungry
ADD_TRANS_TRIGGER OHBVOGHI 4 ~False()~ DO 1

// With reputation of 15, "sir zarath" don't talk to PC. 
REPLACE_STATE_TRIGGER HEARTG3 1 ~ReputationGT(LastTalkedToBy,14)~

// trax addresses you by name despite never learning it
ALTER_TRANS trax BEGIN 13 END BEGIN 1 END BEGIN ~REPLY~ ~#520~ END // Fine, I am <CHARNAME>, an adventurer.
ALTER_TRANS trax BEGIN 15 END BEGIN 1 END BEGIN ~REPLY~ ~#522~ END // All right, I am <CHARNAME>, an adventurer.

// 'nothing to say to you' bug in hexxat's quest
ALTER_TRANS OHHSTONE BEGIN 1 END BEGIN 2 END ACTION ~~ END
ALTER_TRANS OHHSTONE BEGIN 2 END BEGIN 0 END EPILOGUE ~EXIT~ END

// combine bernard's store (see also bernard.bcs, bernard2.sto)
REPLACE_ACTION_TEXT ~bernard~ ~StartStore("bernard"~ ~StartStore("bernard2"~