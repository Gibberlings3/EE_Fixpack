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