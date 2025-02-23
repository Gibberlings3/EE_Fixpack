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
REPLACE_ACTION_TEXT ~bdrasaad~ ~\(JoinParty()\)[%LNL%%MNL%%WNL% %TAB%]*\(RemoveMapNote(\[[0-9]+\.[0-9]+\],34352)\)~ ~\2 \1~
REPLACE_ACTION_TEXT ~bdmkhiin~ ~\(JoinParty()\)[%LNL%%MNL%%WNL% %TAB%]*\(AddexperienceParty(3000)\)~ ~\2 \1~

// fixing loop where you can't inform Corwin that the Bridgforters are ready to attack
ADD_TRANS_ACTION BDKHALID BEGIN 70 END BEGIN 2 END ~SetGlobal("bd_bf_attack","GLOBAL",1)~  

// two journal entries never removed
ADD_TRANS_ACTION BDRHYNWI BEGIN 0 END BEGIN END ~EraseJournalEntry(61532) EraseJournalEntry(61531)~  

// two journal entries never removed
ADD_TRANS_ACTION bdstoneh BEGIN 63 END BEGIN END ~EraseJournalEntry(61530) EraseJournalEntry(61537)~

/////                                                  \\\\\
///// angry rejoins                                    \\\\\
/////                                                  \\\\\

// npcs who leave because they're upset at the party rep levae and go to the camp. At the camp
// you can ask them to rejoin, at which point they'll immediately leave since rep is still bad
// to them. To prevent this, the NPC will now repeat their 'angry leave' line at the camp if
// rep is bad, rpeventing rejoining. For NPCs without an 'angry leave' line, we simply disable
// replies which would lead to a rejoin. 
// https://www.gibberlings3.net/forums/topic/37077-angry-leave-because-of-rep-in-sod-somehow-weird/

ADD_STATE_TRIGGER BDBAELOT 38 ~!HappinessLT(Myself,-290)~
APPEND BDBAELOT 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60614
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDDORN 72 ~!HappinessLT(Myself,-290)~
APPEND BDDORN 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60672
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDDYNAHE 69 ~!HappinessLT(Myself,-290)~
APPEND BDDYNAHE 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60531
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDEDWIN 67 ~!HappinessLT(Myself,-290)~
APPEND BDEDWIN 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60600
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDJAHEIR 86 ~!HappinessLT(Myself,-290)~
APPEND BDJAHEIR 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60631
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDKHALID 119 ~!HappinessLT(Myself,-290)~
APPEND BDKHALID 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60649
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDMINSC 72 ~!HappinessLT(Myself,-290)~
APPEND BDMINSC 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60509
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDNEERA 163 ~!HappinessLT(Myself,-290)~
APPEND BDNEERA 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #36602
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDRASAAD 100 ~!HappinessLT(Myself,-290)~
APPEND BDRASAAD 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0) !NumTimesTalkedTo(0)~ BEGIN AngryNoRejoin SAY #60548
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDSAFANA 130 ~!HappinessLT(Myself,-290)~
APPEND BDSAFANA 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60567
    IF ~~ THEN EXIT
  END
END

ADD_STATE_TRIGGER BDVICONI 63 ~!HappinessLT(Myself,-290)~
APPEND BDVICONI 
  IF ~HappinessLT(Myself,-290) Global("bd_joined","locals",0)~ BEGIN AngryNoRejoin SAY #60583
    IF ~~ THEN EXIT
  END
END

// for npcs without an angry leave line, just disable the rejon replies in their re-recruitment dialogues
ADD_TRANS_TRIGGER BDCORWIN 53 ~!HappinessLT(Myself,-290)~ DO 0 1
ADD_TRANS_TRIGGER BDGLINT  57 ~!HappinessLT(Myself,-290)~ DO 0 1
ADD_TRANS_TRIGGER BDMKHIIN 31 ~!HappinessLT(Myself,-290)~ DO 0 1
ADD_TRANS_TRIGGER BDVOGHIL 99 ~!HappinessLT(Myself,-290)~ DO 0 1 2
