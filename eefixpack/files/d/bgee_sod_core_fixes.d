// tbd, cam
// can enter branch with bd_sdd305_den_of_thieves < 4, but always set to 1 on exit, potentially breaking quest
EXTEND_BOTTOM bdstoneh 54
  IF ~!Global("bd_sdd305_den_of_thieves","global",0)~ THEN DO ~AddJournalEntry(61530,QUEST)~ EXIT
END  

// tbd, cam
// threatening Waizahb as a paladin doesn't spawn Rhynwis, stalling the quest
ADD_TRANS_ACTION BDWAIZAH BEGIN 3 END BEGIN 0 END ~SaveLocation("LOCALS","bd_default_loc",[2337.300])
SetGlobal("bd_retreat","locals",1)
CreateCreature("bdrhynwi",[2246.246],SW)~

// tbd, cam
// can still question about traitor in gap between solving the quest and getting your reward
ADD_TRANS_TRIGGER bdbelega  0 ~!Dead("BDHELVDA") !Dead("BDSIMONE") !Global("SDD303_ACCUSED_COL","GLOBAL",1) !Global("sdd303_seal_found","bd3000",2)~ 1        DO 1
ADD_TRANS_TRIGGER bdhalasa  2 ~!Dead("BDHELVDA") !Dead("BDSIMONE") !Global("SDD303_ACCUSED_COL","GLOBAL",1) !Global("sdd303_seal_found","bd3000",2)~          DO 1
ADD_TRANS_TRIGGER bdhelvda  3 ~!Dead("BDHELVDA") !Dead("BDSIMONE") !Global("SDD303_ACCUSED_COL","GLOBAL",1) !Global("sdd303_seal_found","bd3000",2)~          DO 1
ADD_TRANS_TRIGGER bdmizhen 27 ~!Dead("BDHELVDA") !Dead("BDSIMONE") !Global("SDD303_ACCUSED_COL","GLOBAL",1) !Global("sdd303_seal_found","bd3000",2)~ 38 77 78 DO 0
ADD_TRANS_TRIGGER bdmizhen 27 ~!Dead("BDHELVDA") !Dead("BDSIMONE") !Global("SDD303_ACCUSED_COL","GLOBAL",1) !Global("sdd303_seal_found","bd3000",2)~ 38       DO 1
ADD_TRANS_TRIGGER bdsimone 1  ~!Dead("BDHELVDA") !Dead("BDSIMONE") !Global("SDD303_ACCUSED_COL","GLOBAL",1) !Global("sdd303_seal_found","bd3000",2)~ 2        DO 0

// tbd, cam
// kharm only gives out reward on one dialogue branch
ADD_TRANS_ACTION bdkharm BEGIN 1 END BEGIN 1 2 3 END ~GiveGoldForce(250)~

// tbd, cam
// don't tell shadow to kill bugbears if they're already dead (see also bdshadow.bcs)
ADD_TRANS_TRIGGER bdshadow  2 ~Global("cdBugbearsDead","LOCALS",0)~ DO 2 3 4

// tbd, cam
// dialogues for blind albino cave can fire elsewhere (see also bd5100aw.bcs)
ADD_STATE_TRIGGER bddynahj 85 ~Range("wyrm_sense",20)~
ADD_STATE_TRIGGER bdjaheij 47 ~Range("wyrm_sense",20)~ 
ADD_STATE_TRIGGER bdminscj 85 ~Range("wyrm_sense",20)~
ADD_STATE_TRIGGER bdmkhiij 80 ~Range("wyrm_sense",20)~

// insufficient daytime checks can lead to premature termination of dialogs if triggered at certain times of the day
REPLACE_TRANS_TRIGGER bdsafanj BEGIN 63 END BEGIN 0 END ~TimeOfDay(DAY)~ ~!TimeOfDay(NIGHT)~
REPLACE_TRANS_TRIGGER bddornj  BEGIN  7 END BEGIN 0 END ~TimeOfDay(DAY)~ ~!TimeOfDay(NIGHT)~
REPLACE_TRANS_TRIGGER bdrasaaj BEGIN 24 END BEGIN 0 END ~TimeOfDay(DAY)~ ~!TimeOfDay(NIGHT)~

// tbd, cam
// you can charm zelma to get your stuff back, but she'll have nothing to say between you getting your stuff returned and the charm expiring
APPEND bdzelma
  IF ~NumTimesTalkedToGT(0) Global("bd_zelma_charmed","BD0020",1) StateCheck(Myself,STATE_CHARMED)~ THEN BEGIN bdzelma_intermediate SAY #67420 // Hello again.
    IF ~~ THEN EXIT
  END
END

// buy and sell markup arguments are specified in the wrong order
REPLACE_ACTION_TEXT ~bdjegg~ ~ChangeStoreMarkup("\([^"]+\)",\([0-9]+\),\([0-9]+\))~ ~ChangeStoreMarkup("\1",\3,\2)~

// actions queued after joinparty() get dumped
REPLACE_ACTION_TEXT ~dorn~  ~\(ActionOverride("DORN",JoinPartyOverride())\)[%LNL%%MNL%%WNL% %TAB%]*\(ActionOverride("DORN",ChangeAIScript("DORN",OVERRIDE))\)~ ~\2 \1~
REPLACE_ACTION_TEXT ~dorn~  ~\(JoinParty()\)[%LNL%%MNL%%WNL% %TAB%]*\(ActionOverride("DORN",ChangeAIScript("DORN",OVERRIDE))\)~ ~\2 \1~
REPLACE_ACTION_TEXT ~dornp~ ~\(JoinParty()\)[%LNL%%MNL%%WNL% %TAB%]*\(ActionOverride("DORN",ChangeAIScript("DORN",OVERRIDE))\)~ ~\2 \1~