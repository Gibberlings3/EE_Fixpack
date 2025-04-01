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

// npcs who leave because they're upset at the party rep leave and go to the camp. At the camp
// you can ask them to rejoin, at which point they'll immediately leave since rep is still bad
// to them. To prevent this, the NPC will now repeat their 'angry leave' line at the camp if
// rep is bad, preventing rejoining. For NPCs without an 'angry leave' line, we simply disable
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

/////                                                  \\\\\
///// mixing instants and non-instants                 \\\\\
/////                                                  \\\\\

// https://www.gibberlings3.net/forums/topic/39370-pstee-respawned-bariaur-should-not-talk-like-you-parted-on-friendly-terms/

ALTER_TRANS BDAMMON BEGIN 11 END BEGIN 0 END BEGIN ACTION
~SetGlobalTimer("BD_Cast","LOCALS",ONE_ROUND)
Enemy()
DisplayStringHead(Myself,56560)
UseItem("POTN10",Myself)~
END

ALTER_TRANS BDBANNO BEGIN 0 END BEGIN END BEGIN ACTION // all transitions
~GiveItemCreate("BDBFLYER",Player1,0,0,0)
SetGlobal("bd_baeloth_map_note","BD1000",1)
AddMapNoteColor([2000.540],67515,SLATE)~
END

ALTER_TRANS BDBARTLE BEGIN 4 END BEGIN 0 END BEGIN ACTION // offloading to bdbartle.bcs (see bgee.tph)
~SetGlobal("cd_do_dlg_stuff","LOCALS",1)~
END

ALTER_TRANS BDCLOVIS BEGIN 5 7 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(61860,QUEST)
SetGlobal("BD_TRAINED_CLOVISTA","BD3000",1)
IncrementGlobal("BD_TROOPS_TRAINED","BD3000",1)
ActionOverride("BDDANINE",MoveToPoint([179.610]))
SetGlobal("BD_STOP_SWINGING_DANINE","BD3000",0)
SetGlobal("BD_STOP_SWINGING_CLOVIS","BD3000",0)
ActionOverride("BDDANINE",DialogInterrupt(TRUE))
ActionOverride("BDTAIELD",DialogInterrupt(TRUE))
ActionOverride("BDGARROL",DialogInterrupt(TRUE))
ActionOverride("BDMORLIS",DialogInterrupt(TRUE))
ActionOverride("BDHESTER",DialogInterrupt(TRUE))
MoveToPoint([103.653])
DialogInterrupt(TRUE)~
END

ALTER_TRANS BDCRUBBM BEGIN 0 END BEGIN 1 END BEGIN ACTION
~SetGlobal("bd_bridge_plot","bd2000",3)
AddJournalEntry(59771,QUEST)
Enemy()
ApplySpell(Myself,WIZARD_MIRROR_IMAGE)
ApplySpell(Myself,WIZARD_PROTECTION_FROM_NORMAL_WEAPONS)
ApplySpell(Myself,WIZARD_MINOR_GLOBE_OF_INVULNERABILITY)
SetGlobalTimer("bd_cast","locals",9)
SpellNoDecRES("bdsumfir",Myself)
RemoveSpell(WIZARD_MIRROR_IMAGE)
RemoveSpell(WIZARD_PROTECTION_FROM_NORMAL_WEAPONS)
RemoveSpell(WIZARD_MINOR_GLOBE_OF_INVULNERABILITY)~
END

ALTER_TRANS BDCRUBBM BEGIN 0 END BEGIN 2 END BEGIN ACTION
~SetGlobal("bd_bridge_plot","bd2000",3)
AddJournalEntry(59771,QUEST)
Enemy()
ApplySpell(Myself,WIZARD_SPIRIT_ARMOR)
ApplySpell(Myself,WIZARD_IMPROVED_INVISIBILITY)
ApplySpell(Myself,WIZARD_MIRROR_IMAGE)
ApplySpell(Myself,WIZARD_PROTECTION_FROM_NORMAL_WEAPONS)
ApplySpell(Myself,WIZARD_MINOR_GLOBE_OF_INVULNERABILITY)
SetGlobalTimer("bd_cast","locals",9)
SpellNoDecRES("bdsumfir",Myself)
RemoveSpell(WIZARD_SPIRIT_ARMOR)
RemoveSpell(WIZARD_IMPROVED_INVISIBILITY)
RemoveSpell(WIZARD_MIRROR_IMAGE)
RemoveSpell(WIZARD_PROTECTION_FROM_NORMAL_WEAPONS)
RemoveSpell(WIZARD_MINOR_GLOBE_OF_INVULNERABILITY)~
END

ALTER_TRANS BDDANINE BEGIN 5 11 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(61856,QUEST)
SetGlobal("BD_TRAINED_DANINE","BD3000",1)
IncrementGlobal("BD_TROOPS_TRAINED","BD3000",1)
ActionOverride("BDCLOVIS",MoveToPoint([103.653]))
SetGlobal("BD_STOP_SWINGING_DANINE","BD3000",0)
SetGlobal("BD_STOP_SWINGING_CLOVIS","BD3000",0)
ActionOverride("BDCLOVIS",DialogInterrupt(TRUE))
ActionOverride("BDTAIELD",DialogInterrupt(TRUE))
ActionOverride("BDGARROL",DialogInterrupt(TRUE))
ActionOverride("BDMORLIS",DialogInterrupt(TRUE))
ActionOverride("BDHESTER",DialogInterrupt(TRUE))
MoveToPoint([179.610])
DialogInterrupt(TRUE)~
END

// ignore bddebug

ALTER_TRANS BDDORN BEGIN 23 END BEGIN 0 END BEGIN ACTION
~SetGlobal("bd_release_dorn","bd2000",5)
SetGlobal("bd_dorn_join","global",1)
AddJournalEntry(59744,INFO)
SetGlobal("bd_npc_camp","locals",1)
ChangeAIScript("bdparty",DEFAULT)
Unlock("Cages_Left")
OpenDoor("Cages_Left")~
END

ALTER_TRANS BDDORN BEGIN 23 END BEGIN 0 END BEGIN ACTION
~SetGlobal("bd_release_dorn","bd2000",5)
SetGlobal("bd_dorn_join","global",1)
AddJournalEntry(59744,INFO)
SetGlobal("bd_npc_camp","locals",1)
ChangeAIScript("bdparty",DEFAULT)
Unlock("Cages_Left")
OpenDoor("Cages_Left")~
END

ALTER_TRANS BDDORN BEGIN 31 END BEGIN 1 END BEGIN ACTION
~SetGlobal("bd_release_dorn","bd2000",4)
SetGlobal("bd_dorn_join","global",1)
ChangeSpecifics(Myself,ALLIES)
ChangeEnemyAlly(Myself,GOODBUTBLUE)
ActionOverride("bdcage",Enemy())
Unlock("Cages_Left")
OpenDoor("Cages_Left")
DisplayStringHead("bdcage",42634)~
END

ALTER_TRANS BDDORN BEGIN 48 END BEGIN 1 END BEGIN ACTION
~SetGlobal("bd_release_dorn","bd2000",4)
SetGlobal("bd_dorn_join","global",1)
AddJournalEntry(59743,INFO)
ChangeSpecifics(Myself,ALLIES)
ChangeEnemyAlly(Myself,GOODBUTBLUE)
ActionOverride("bdcage",Enemy())
Unlock("Cages_Left")
OpenDoor("Cages_Left")
DisplayStringHead("bdcage",42634)~
END

ALTER_TRANS BDFLOSS BEGIN 1 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(66740,QUEST_DONE)
AddexperienceParty(5000)
SetGlobal("bd_sdd700_gf","GLOBAL",6)
ApplySpellRES("bdpspace","bdgurgle")
ApplySpellRES("bdpspace","bdfloss")
DisplayStringHead("bdgurgle",40519)~
END

ALTER_TRANS BDFLOSS BEGIN 6 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(66740,QUEST_DONE)
SetGlobal("bd_sdd700_gf","GLOBAL",4)
ActionOverride("bdgurgle",SaveObjectLocation("LOCALS","bd_default_loc","Eye1"))
ActionOverride("bdgurgle",SetGlobal("bd_retreat","locals",1))
ActionOverride("bdgurgle",SetGlobal("bd_retreat_escape","locals",1))
ActionOverride("bdgurgle",DialogInterrupt(FALSE))
SaveObjectLocation("LOCALS","bd_default_loc","Eye1")
SetGlobal("bd_retreat","locals",1)
SetGlobal("bd_retreat_escape","locals",1)
ApplySpellRES("bdpspace","bdgurgle")
ApplySpellRES("bdpspace","bdfloss")
DisplayStringHead("bdgurgle",40542)
DialogInterrupt(FALSE)~
END

ALTER_TRANS BDGARROL BEGIN 2 5 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(61858,QUEST)
SetGlobal("BD_TRAINED_GARROLD","BD3000",1)
IncrementGlobal("BD_TROOPS_TRAINED","BD3000",1)
ActionOverride("BDTAIELD",MoveToPoint([198.715]))
SetGlobal("BD_STOP_SWINGING_TAIELD","BD3000",0)
SetGlobal("BD_STOP_SWINGING_GARROLD","BD3000",0)
ActionOverride("BDTAIELD",DialogInterrupt(TRUE))
ActionOverride("BDDANINE",DialogInterrupt(TRUE))
ActionOverride("BDCLOVIS",DialogInterrupt(TRUE))
ActionOverride("BDMORLIS",DialogInterrupt(TRUE))
ActionOverride("BDHESTER",DialogInterrupt(TRUE))
MoveToPoint([310.715])
DialogInterrupt(TRUE)~
END

ALTER_TRANS BDGURGLE BEGIN 2 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(66740,QUEST_DONE)
AddexperienceParty(5000)
SetGlobal("bd_sdd700_gf","GLOBAL",6)
ApplySpellRES("bdpspace","bdgurgle")
ApplySpellRES("bdpspace","bdfloss")~
END

ALTER_TRANS BDGURGLE BEGIN 26 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(66740,QUEST_DONE)
AddexperienceParty(7500)
SetGlobal("bd_sdd700_gf","GLOBAL",6)
ApplySpellRES("bdpspace","bdgurgle")
ApplySpellRES("bdpspace","bdfloss")~
END

ALTER_TRANS BDJUNIA BEGIN 28 END BEGIN 0 END BEGIN ACTION
~SetGlobal("BD_SDD222_REVEALED","GLOBAL",1)
SetGlobal("BD_SDD222_PERP","GLOBAL",2)
ChangeAIScript("",CLASS)
ChangeAIScript("",RACE)
ChangeSpecifics(Myself,NONE)
Enemy()
SetGlobal("BD_SDD222","GLOBAL",6)
CreateCreatureObjectEffect("BDWIGHTJ","SPRAISED","ALTAR")
CreateCreatureObjectEffect("BDWIGHTJ","SPRAISED","ALTAR")
CreateCreatureObjectEffect("BDWIGHTJ","SPRAISED","ALTAR")~
END

ALTER_TRANS BDJUNIA BEGIN 34 END BEGIN 0 END BEGIN ACTION
~SetGlobal("BD_SDD222_PERP","GLOBAL",2)
ChangeAIScript("",CLASS)
ChangeAIScript("",RACE)
ChangeSpecifics(Myself,NONE)
Enemy()
SetGlobal("BD_SDD222","GLOBAL",6)
CreateCreatureObjectEffect("BDWIGHTJ","SPRAISED","ALTAR")
CreateCreatureObjectEffect("BDWIGHTJ","SPRAISED","ALTAR")
CreateCreatureObjectEffect("BDWIGHTJ","SPRAISED","ALTAR")~
END

ALTER_TRANS BDMINSC BEGIN 23 29 END BEGIN 0 END BEGIN ACTION
~SetGlobal("bd_minsc_followup","global",2)
AddJournalEntry(59696,INFO)
ReallyForceSpellRES("bdbump2",Myself)
MoveToPointNoInterrupt([283.469])~
END

ALTER_TRANS BDMORLIS BEGIN 6 12 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(61855,QUEST)
SetGlobal("BD_TRAINED_MORLIS","BD3000",1)
IncrementGlobal("BD_TROOPS_TRAINED","BD3000",1)
SetGlobal("BD_STOP_SWINGING_TAIELD","BD3000",0)
SetGlobal("BD_STOP_SWINGING_MORLIS","BD3000",0)
ActionOverride("BDDANINE",DialogInterrupt(TRUE))
ActionOverride("BDTAIELD",DialogInterrupt(TRUE))
ActionOverride("BDGARROL",DialogInterrupt(TRUE))
ActionOverride("BDCLOVIS",DialogInterrupt(TRUE))
ActionOverride("BDHESTER",DialogInterrupt(TRUE))
ActionOverride("BDTAIELD",MoveToPointNoInterrupt([198.715]))
MoveToPoint([246.807])
Wait(2)
DialogInterrupt(TRUE)~
END

ALTER_TRANS BDTAIELD BEGIN 3 6 8 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(61859,QUEST)
SetGlobal("BD_TRAINED_TAIELD","BD3000",1)
IncrementGlobal("BD_TROOPS_TRAINED","BD3000",1)
ActionOverride("BDMORLIS",MoveToPoint([246.807]))
ActionOverride("BDGARROL",MoveToPoint([310.715]))
SetGlobal("BD_STOP_SWINGING_TAIELD","BD3000",0)
SetGlobal("BD_STOP_SWINGING_GARROLD","BD3000",0)
SetGlobal("BD_STOP_SWINGING_MORLIS","BD3000",0)
ActionOverride("BDGARROL",DialogInterrupt(TRUE))
ActionOverride("BDMORLIS",DialogInterrupt(TRUE))
ActionOverride("BDDANINE",DialogInterrupt(TRUE))
ActionOverride("BDCLOVIS",DialogInterrupt(TRUE))
ActionOverride("BDHESTER",DialogInterrupt(TRUE))
MoveToPoint([198.715])
DialogInterrupt(TRUE)~
END

ALTER_TRANS BDVOGHIL BEGIN 16 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(59738,INFO)
ActionOverride("jaheira",SetGlobal("bd_npc_camp","locals",1))
ActionOverride("jaheira",ChangeAIScript("bdparty",DEFAULT))
SetGlobal("bd_npc_camp","locals",1)
ChangeAIScript("bdparty",DEFAULT)
RemoveMapNote([3700.358],68675)~
END

ALTER_TRANS BDVOGHIL BEGIN 17 END BEGIN 0 END BEGIN ACTION
~AddJournalEntry(59735,INFO)
ActionOverride("jaheira",JoinParty())
SetGlobal("bd_npc_camp","locals",1)
ChangeAIScript("bdparty",DEFAULT)
RemoveMapNote([3700.358],68675)~
END
