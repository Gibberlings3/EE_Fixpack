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
ALTER_TRANS OHHSTONE BEGIN 1 END BEGIN 2 END BEGIN ACTION ~~ END
ALTER_TRANS OHHSTONE BEGIN 2 END BEGIN 0 END BEGIN EPILOGUE ~EXIT~ END

// consolidate bernard's store (see also bernard.bcs, bernard2.sto)
REPLACE_ACTION_TEXT ~bernard~ ~StartStore("bernard"~ ~StartStore("bernard2"~

// keldorn fixes
REPLACE_ACTION_TEXT_REGEXP ~keldor\(j\|p\)?~ ~EscapeAreaMove("AR0903",[0-9]+,[0-9]+~ ~EscapeAreaMove("AR0903",644,501~ // have keldorn escape to the same place  in NORH
ALTER_TRANS bkeldor BEGIN 166 END BEGIN 0 END BEGIN ACTION // in keldorn-hexxat fight, if keldorn leaves he was setting hexxat leave vars, not his own [jmerry]
 ~SetGlobal("KickedOut","LOCALS",1) LeaveParty() SetLeavePartyDialogueFile() ChangeAIScript("",DEFAULT) EscapeAreaMove("AR0903",644,501,0)~
END 

// trying to make the exit statue from spellhold dungeon level 1 more reliable - ppridd.dlg and ar1512.bcs
ADD_STATE_TRIGGER PPRIDD 3 ~Global("openHead","AR1512",0)~
ALTER_TRANS PPRIDD BEGIN 3 END BEGIN END BEGIN ACTION ~SetGlobal("openHead","AR1512",1)~ END 

// neera's underdark comment only makes sense if party skipped sahuagin city (hexxat.bcs, neera.bcs, neeraj.dlg)
ADD_STATE_TRIGGER neeraj 137 ~Global("SahauginTravel","GLOBAL",0)~

// szass tam not settiing final journal entries on all dialogue paths
ADD_TRANS_ACTION ohnszass BEGIN 40 END BEGIN END ~AddJournalEntry(96075,QUEST_DONE)~

// you can navigate through gaal's dialogue without discovering the unseeing eye is a beholder
// all journal entries &c. assume that you learn this, so we strucutre the dialogue so that you have to
// set variable on anything going to 3, as it leads to the beholder reveal in 4
ADD_TRANS_ACTION gaal BEGIN 17      END BEGIN 0 END ~SetGlobal("cd_gaal_beholder","MYAREA",1)~
ADD_TRANS_ACTION gaal BEGIN  0 6 24 END BEGIN 1 END ~SetGlobal("cd_gaal_beholder","MYAREA",1)~
ADD_TRANS_ACTION gaal BEGIN 26      END BEGIN 2 END ~SetGlobal("cd_gaal_beholder","MYAREA",1)~
// check variable on anything going to 7, as it leads to the job in 8 via 27
ADD_TRANS_TRIGGER gaal 6  ~Global("cd_gaal_beholder","MYAREA",1)~ DO 0
ADD_TRANS_TRIGGER gaal 2  ~Global("cd_gaal_beholder","MYAREA",1)~ DO 1
ADD_TRANS_TRIGGER gaal 26 ~Global("cd_gaal_beholder","MYAREA",1)~ DO 1
ADD_TRANS_TRIGGER gaal 17 ~Global("cd_gaal_beholder","MYAREA",1)~ DO 2

// Korgan shouldn't ask about the book of kaza if he already had it
ADD_TRANS_TRIGGER nevaziah 12 ~Global("TalkedAboutShagbag","GLOBAL",0)~ DO 1

// cernd nvlor
ALTER_TRANS cernd BEGIN 6 END BEGIN 0 END BEGIN ~TRIGGER~ ~~ END // failsafe transition
ALTER_TRANS cernd BEGIN 6 END BEGIN 2 END BEGIN ~TRIGGER~ 
~OR(3) !InParty("Jaheira") !AreaCheckObject("AR2009","Jaheira") Dead("Jaheira")   // transition 1 n/a 
        InParty("Minsc")    AreaCheckObject("AR2009","Minsc")  !Dead("Minsc")~    // minsc available
END // minsc's transition should check all three of jaheira's conditions, not just InParty
ALTER_TRANS cernd BEGIN 6 END BEGIN 3 END BEGIN ~TRIGGER~ 
~OR(2) Class(Player1,DRUID_ALL) Class(Player1,RANGER_ALL) !Class(Player1,SHAMAN) // p1 is a ranger/druid (but not shaman)
OR(3) !InParty("Jaheira") !AreaCheckObject("AR2009","Jaheira") Dead("Jaheira")   // transition 1 n/a 
OR(3) !InParty("Minsc")   !AreaCheckObject("AR2009","Minsc")   Dead("Minsc")~    // transition 2 n/a
END // p1 gets comment only if minsc/jaheira comments unavailable

// does have another 'done' entry if you give talisman to daxus
REPLACE_ACTION_TEXT ohnknock ~AddJournalEntry(100041,QUEST)~ ~AddJournalEntry(100041,QUEST_DONE)~

// dawn ring quest sets a couple of ongoing journal entries in the finished section
ALTER_TRANS scyarryl BEGIN 31 END BEGIN 1 2 3 4 END BEGIN ~UNSOLVED_JOURNAL~ ~#2071~ END
ALTER_TRANS sctelwyn BEGIN 30 END BEGIN 1 2 3 4 END BEGIN ~UNSOLVED_JOURNAL~ ~#2074~ END

// rasaad quest entry should go into ongoing journal section, not done
REPLACE_ACTION_TEXT ohralor ~AddJournalEntry(85086,QUEST_DONE)~ ~AddJournalEntry(85086,QUEST)~

// 'Selfish' hell trial: improve conditions how to choose hostage
ALTER_TRANS hellself BEGIN 23 END BEGIN 1 END BEGIN ~TRIGGER~ ~NumInPartyGT(1) InParty(Player2Fill)~ END
REPLACE_STATE_TRIGGER hellself 30 ~Global("OpenedDoor5","AR2904",1) !InMyArea("hellvict")~
REPLACE_STATE_TRIGGER hellself 31 ~Global("OpenedDoor5","AR2904",1) InMyArea("hellvict")~

/////                                                  \\\\\
///// mixing instants and non-instants                 \\\\\
/////                                                  \\\\\

// https://www.gibberlings3.net/forums/topic/39370-pstee-respawned-bariaur-should-not-talk-like-you-parted-on-friendly-terms/

// offload aataqah actions to area script
ALTER_TRANS AATAQAH BEGIN 12 END BEGIN 0 END BEGIN ACTION ~SetGlobal("cd_AataqahFight","AR0602",1)~ END
ALTER_TRANS AATAQAH BEGIN 13 END BEGIN 0 END BEGIN ACTION ~SetGlobal("cd_AataqahFight","AR0602",2)~ END

ALTER_TRANS AERIE BEGIN 4 21 25 END BEGIN 0 1 END BEGIN ACTION
~SetGlobal("LoveTalk","LOCALS",1)
SetGlobal("AerieRomanceActive","GLOBAL",1)
SetGlobal("AerieTransform","GLOBAL",2)
SetGlobal("AerieJoined","GLOBAL",1)
RealSetGlobalTimer("AerieRomance","GLOBAL",ONE_DAY)~
END

ALTER_TRANS AERIE BEGIN 4 21 25 END BEGIN 2 END BEGIN ACTION
~SetGlobal("LoveTalk","LOCALS",1)
SetGlobal("AerieRomanceActive","GLOBAL",1)
SetGlobal("AerieTransform","GLOBAL",2)
SetGlobal("AerieJoined","GLOBAL",1)
RealSetGlobalTimer("AerieRomance","GLOBAL",ONE_DAY)
JoinParty()~
END

ALTER_TRANS AERIEJ BEGIN 58 END BEGIN 0 END BEGIN ACTION
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
MoveGlobal("AR0607","Aerie",[469.437])~
END

ALTER_TRANS AERIEJ BEGIN 129 END BEGIN 0 1 END BEGIN ACTION
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
MoveGlobal("AR0607","Aerie",[469.437])~
END

ALTER_TRANS ANOMEN BEGIN 6 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("LoveTalk","LOCALS",1)
SetGlobal("AnomenRomanceActive","GLOBAL",1)
SetGlobalTimer("AnomenJoined","GLOBAL",FIVE_DAYS)
RealSetGlobalTimer("AnomenRomance","GLOBAL",2000)~
END

ALTER_TRANS ARNTRA04 BEGIN 0 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KillArntra04","AR0307",1)
Face(NE)~
END

ALTER_TRANS ARNWAR07 BEGIN 0 END BEGIN 0 END BEGIN ACTION
~TriggerActivation("Guillotine1",TRUE)
TriggerActivation("Guillotine2",TRUE)
SetGlobal("TalkedDedral","ar0329",1)
MoveToPointNoInterrupt([1332.955])
DestroySelf()~
END

ALTER_TRANS BAERIE BEGIN 41 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KorganAerieGrump","GLOBAL",1)
MoveToObject(Player1)~
END

ALTER_TRANS BAERIE BEGIN 178 210 448 END BEGIN 0 END BEGIN ACTION
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
MoveGlobal("AR0607","Aerie",[469.437])~
END

ALTER_TRANS BAERIE BEGIN 236 END BEGIN 0 END BEGIN ACTION
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
MoveGlobal("AR0607","Aerie",[469.437])
Wait(2)
RestParty()~
END

ALTER_TRANS BAERIE BEGIN 436 END BEGIN 0 END BEGIN ACTION
~SetGlobal("AerieRomanceActive","GLOBAL",3)
ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
MoveGlobal("AR0607","Aerie",[469.437])  // Aerie
Wait(2)
RestParty()~
END

ALTER_TRANS BJAHEIR BEGIN 417 418 END BEGIN END BEGIN ACTION // five transitions on two states
~SetGlobal("TerminselSpawn","GLOBAL",4)
SetGlobal("JaheiraRomanceActive","GLOBAL",2)
RealSetGlobalTimer("TerminselAppear","GLOBAL",TWELVE_HOURS)~
END

ALTER_TRANS BODHI BEGIN 28 END BEGIN END BEGIN ACTION // all transitions
~SetGlobal("BodhiAppear","GLOBAL",2)
SetGlobal("BodhiJob","GLOBAL",1)
SetGlobal("WorkingForBodhi","GLOBAL",1)
MoveToPointNoInterrupt([648.1028])
Unlock("DOOR12")
OpenDoor("DOOR12")
EscapeArea()~
END

ALTER_TRANS BVICONI BEGIN 190 END BEGIN 0 END BEGIN ACTION
~SetGlobal("ViconiaRomanceActive","GLOBAL",3)
ChangeAIScript("",DEFAULT)
SetGlobal("Left","LOCALS",1)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
EscapeAreaMove("AR0800",1422,701,S)~
END

ALTER_TRANS C6ELHAN2 BEGIN 63 END BEGIN 0 END BEGIN ACTION
~ActionOverride("c6warsa1",ReallyForceSpell(Myself,DRYAD_TELEPORT))
ActionOverride("c6warsa2",ReallyForceSpell(Myself,DRYAD_TELEPORT))
SetGlobal("ElhanFinishedSpeaking","GLOBAL",1)
ForceSpell("Viconia",FLASHY_1)~
END

ALTER_TRANS DEGARD BEGIN 9 END BEGIN 0 END BEGIN ACTION
~SetGlobal("TalkedDegardan","GLOBAL",2)
ForceSpell("edwin",EDWIN_CHANGE_BACK)
Wait(1)~
END

ALTER_TRANS ELEARB11 BEGIN 5 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Deactivate","AR1508",1)
CreateCreatureObjectEffect("elmind01","SPFLESHS",Myself)
Deactivate(Myself)~
END

ALTER_TRANS ESCORT4 BEGIN 3 END BEGIN 0 END BEGIN ACTION
~SetGlobal("MadamUpset","GLOBAL",1)
MoveToObject("Madam")~
END

ALTER_TRANS FIRWLF01 BEGIN 3 END BEGIN 0 END BEGIN ACTION
~SetGlobal("WerewolfMove","LOCALS",1)
ActionOverride("firwlf02",MoveToPointNoInterrupt([986.2033]))
OpenDoor("DOOR43")
OpenDoor("DOOR44")
MoveToPointNoInterrupt([1066.2095])~
END

ALTER_TRANS GORALT1 BEGIN 7 END BEGIN 0 END BEGIN ACTION
~SetGlobal("ReturnRitualItems","AR3001",1)
SetGlobal("SpawnGorAlt1","AR3001",0)
ApplyDamage(LastTalkedToBy,50,MAGIC)
DestroySelf()~
END

ALTER_TRANS GORCAMB BEGIN 64 END BEGIN 0 END BEGIN ACTION
~ClearAllActions()
MoveViewObject(Myself,INSTANT)
ReallyForceSpell(Myself,DECK_WHEEL)
SetGlobal("DrawEffect","GLOBAL",2)
SetGlobal("CambionDraw","GLOBAL",5)
Wait(3)
StartDialogueNoSet(LastTalkedToBy)~
END

ALTER_TRANS GORODR1 BEGIN 41 56 END BEGIN 0 END BEGIN ACTION
~EraseJournalEntry(62402)
EraseJournalEntry(62423)
EraseJournalEntry(62461)
EraseJournalEntry(62481)
EraseJournalEntry(62987)
EraseJournalEntry(63049)
EraseJournalEntry(63048)
EraseJournalEntry(63091)
AddXP2DA("PLOT01D")
SetGlobal("CloseDemogorgonTemple","GLOBAL",2)
ActionOverride("shugar01",DialogInterrupt(FALSE))
ActionOverride("shupol01",DialogInterrupt(FALSE))
ActionOverride("shugfg01",DialogInterrupt(FALSE))
ActionOverride("shugmg01",DialogInterrupt(FALSE))
ActionOverride("shugpr01",DialogInterrupt(FALSE))
ActionOverride("shugar01",EscapeArea())
ActionOverride("shupol01",EscapeArea())
ActionOverride("shugfg01",EscapeArea())
ActionOverride("shugmg01",EscapeArea())
ActionOverride("shugpr01",EscapeArea())
Wait(1)
DialogInterrupt(FALSE)
EscapeArea()~
END

ALTER_TRANS HAERDAJ BEGIN 12 END BEGIN 0 END BEGIN ACTION
~SetGlobal("RaelisLeaving","GLOBAL",1)
ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetDialog("haerda")~
END

ALTER_TRANS HAERDAJ BEGIN 19 END BEGIN 0 END BEGIN ACTION
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetGlobal("FightingTheTroupe","GLOBAL",1)
SetLeavePartyDialogFile()~
END

ALTER_TRANS HELLSELF BEGIN 30 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Player1Selfish","GLOBAL",1)
ForceSpell(Player2Fill,HELL_DISPELL)~
END

ALTER_TRANS HEXXATJ BEGIN 310 END BEGIN 0 END BEGIN ACTION
~SetGlobal("OHH_hexxatjoined","LOCALS",0)
ChangeAIScript("",DEFAULT)
LeaveParty()
SetLeavePartyDialogFile()
RealSetGlobalTimer("OHH_hexxatcoronettimer","GLOBAL",FOUR_HOURS)
EscapeAreaMove("AR0406",600,1045,SW)~
END

ALTER_TRANS HLSHANG BEGIN 4 7 END BEGIN 0 END BEGIN ACTION
~SetGlobal("ShangalarMove","AR1008",1)
CreateVisualEffect("SPHEALIN",[962.554])
Wait(1)
CreateVisualEffect("SPFLSRIN",[962.554])
JumpToPoint([532.744])~
END

ALTER_TRANS JAERTOF BEGIN 13 END BEGIN 0 END BEGIN ACTION
~SetGlobal("JaheiraBanditPlot","GLOBAL",3)
ReallyForceSpell("Jaheira",FIFTY_PERCENT_DAMAGE)
Wait(1)
ActionOverride("Jaheira",StartDialogueNoSet(Player1))~
END

ALTER_TRANS JAERTOF BEGIN 15 END BEGIN 0 END BEGIN ACTION
~SetGlobal("JaheiraBanditPlot","GLOBAL",5)
ReallyForceSpell(Player1,FIFTY_PERCENT_DAMAGE_ARROW)
Wait(1)
ActionOverride("Jaheira",StartDialogueNoSet(Player1))~
END

ALTER_TRANS JAERTOF BEGIN 18 END BEGIN 0 END BEGIN ACTION
~SetGlobal("JaheiraBanditPlot","GLOBAL",7)
ActionOverride("Jaheira",ReallyForceSpell("Ertof",FIFTY_PERCENT_DAMAGE))
Wait(1)
ActionOverride("Jaheira",StartDialogueNoSet(Player1))~
END

ALTER_TRANS JAHEIRAJ BEGIN 474 END BEGIN END BEGIN ACTION // all three transitions
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
EscapeAreaMove("AR0300",1257,3007,SE)~
END

ALTER_TRANS KELDORJ BEGIN 7 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KeldornLeave","GLOBAL",1)
SetGlobal("KeldornComplain","LOCALS",3)
ChangeAIScript("",DEFAULT)
LeaveParty()
SetGlobalTimer("KeldornGuild","GLOBAL",ONE_DAY)
SetLeavePartyDialogFile()
EscapeArea()~
END

ALTER_TRANS KELDORJ BEGIN 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KeldornComplain","LOCALS",3)
SetGlobal("KeldornLeave","GLOBAL",1)
ChangeAIScript("",DEFAULT)
LeaveParty()
SetGlobalTimer("KeldornGuild","GLOBAL",TWO_DAYS)
SetLeavePartyDialogFile()
EscapeArea()~
END

ALTER_TRANS KELDORJ BEGIN 24 END BEGIN 0 END BEGIN ACTION
~SetGlobal("LadyMaria","GLOBAL",1)
SetGlobal("KeldornLeave","GLOBAL",2)
SetGlobal("WilliamDead","GLOBAL",1)
ChangeAIScript("",DEFAULT)
LeaveParty()
SetGlobalTimer("KeldornGuild","GLOBAL",THREE_HOURS)
SetLeavePartyDialogFile()
EscapeArea()~
END

ALTER_TRANS KELDORJ BEGIN 30 END BEGIN 0 END BEGIN ACTION
~ChangeAIScript("",DEFAULT)
LeaveParty()
SetGlobal("WilliamDead","GLOBAL",1)
SetGlobalTimer("KeldornGuildWilliam","GLOBAL",ONE_DAY)
SetLeavePartyDialogFile()
EscapeArea()~
END

ALTER_TRANS KELDORJ BEGIN 38 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KeldornFamilyGone","GLOBAL",1)
SetGlobal("KeldornLeave","GLOBAL",4)
ChangeAIScript("",DEFAULT)
LeaveParty()
SetGlobalTimer("KeldornGuild","GLOBAL",THREE_DAYS)
SetGlobal("KeldornSpawnGuild","GLOBAL",0)
SetLeavePartyDialogFile()
EscapeArea()~
END

ALTER_TRANS KELDORJ BEGIN 42 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KeldornLeave","GLOBAL",4)
ChangeAIScript("",DEFAULT)
LeaveParty()
SetGlobalTimer("KeldornGuild","GLOBAL",THREE_DAYS)
SetLeavePartyDialogFile()
EscapeArea()~
END

ALTER_TRANS KELDORJ BEGIN 111 143 END BEGIN END BEGIN ACTION // all 8 transitions
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
EscapeAreaMove("AR0903",644,501,S)~
END

ALTER_TRANS KELDORJ BEGIN 151 152 END BEGIN 0 END BEGIN ACTION
~ActionOverride("renfeld",DestroySelf())
ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
EscapeAreaMove("AR0903",644,501,S)~
END

ALTER_TRANS KORGANJ BEGIN 205 END BEGIN 0 END BEGIN ACTION
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
LeaveParty()
SetLeavePartyDialogFile()
EscapeAreaMove("AR0406",950,1867,E)~
END

ALTER_TRANS NALIAP BEGIN 1 END BEGIN 0 END BEGIN ACTION
~SetGlobal("NaliaMove","GLOBAL",1)
SetDialog("Nalia")
EscapeAreaMove("AR1300",748,3227,SE)~
END

ALTER_TRANS NALIAP BEGIN 4 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KickedOut","LOCALS",1)
SetGlobal("NaliaMove","GLOBAL",1)
SetDialog("Nalia")
EscapeAreaMove("AR1300",748,3227,SE)~
END

ALTER_TRANS OHBDANCE BEGIN 5 END BEGIN 0 END BEGIN ACTION
~SetGlobal("OHB_DORMAMUS_DOOR","GLOBAL",1)
SetGlobal("ohb_dancers_panic","oh8100",1)
Unlock("Dormamus_door")
OpenDoor("Dormamus_door")~
END

ALTER_TRANS OHBGC01 BEGIN 9 END BEGIN 0 END BEGIN ACTION
~TakePartyGold(5000)
SetGlobal("OHB_GCENTRY","OH8100",5)
AmbientActivate("lounge_barrier1",FALSE)
AmbientActivate("lounge_barrier2",FALSE)
PlaySound("EFF_M10")
Unlock("LoungeDoor")
OpenDoor("LoungeDoor")
Face(SW)~
END

ALTER_TRANS OHBGC01 BEGIN 19 END BEGIN 0 END BEGIN ACTION
~SetGlobal("OHB_GCENTRY","OH8100",5)
AddJournalEntry(101252,QUEST_DONE)
EraseJournalEntry(101238)
EraseJournalEntry(101239)
EraseJournalEntry(101240)
EraseJournalEntry(101241)
EraseJournalEntry(101242)
EraseJournalEntry(101243)
EraseJournalEntry(101244)
EraseJournalEntry(101245)
EraseJournalEntry(101246)
EraseJournalEntry(101247)
EraseJournalEntry(101248)
EraseJournalEntry(101249)
EraseJournalEntry(101250)
TakePartyItemNum("ohbring2",1)
AmbientActivate("lounge_barrier1",FALSE)
AmbientActivate("lounge_barrier2",FALSE)
PlaySound("EFF_M10")
Unlock("LoungeDoor")
OpenDoor("LoungeDoor")
Face(SW)~
END

ALTER_TRANS OHBGC01 BEGIN 20 END BEGIN 0 END BEGIN ACTION
~SetGlobal("OHB_GCENTRY","OH8100",5) 
AddJournalEntry(101251,QUEST_DONE)
EraseJournalEntry(101238)
EraseJournalEntry(101239)
EraseJournalEntry(101240)
EraseJournalEntry(101241)
EraseJournalEntry(101242)
EraseJournalEntry(101243)
EraseJournalEntry(101244)
EraseJournalEntry(101245)
EraseJournalEntry(101246)
EraseJournalEntry(101247)
EraseJournalEntry(101248)
EraseJournalEntry(101249)
EraseJournalEntry(101250)
AmbientActivate("lounge_barrier1",FALSE)
AmbientActivate("lounge_barrier2",FALSE)
PlaySound("EFF_M10")
Unlock("LoungeDoor")
OpenDoor("LoungeDoor")
Face(SW)~
END

ALTER_TRANS OHDDOOR1 BEGIN 1 END BEGIN 2 END BEGIN ACTION
~SetGlobal("OHD_WEDDING_HOSTILE","OH5000",1)
SetGlobal("OHD_frontroomfight","OH5000",1)
OpenDoor("DOOR09")~
END

ALTER_TRANS OHDDOOR1 BEGIN 1 END BEGIN 3 END BEGIN ACTION
~SetGlobal("OHD_WEDDING_HOSTILE","OH5000",1)
SetGlobal("OHD_frontroomfight","OH5000",1)
OpenDoor("DOOR07")~
END

ALTER_TRANS OHDDOOR1 BEGIN 3 END BEGIN END BEGIN ACTION // both transitions
~SetGlobal("OHD_WEDDING_HOSTILE","OH5000",2)
SetGlobal("OHD_frontroomfight","OH5000",1)
OpenDoor("DOOR07")~
END

ALTER_TRANS OHHSTONE BEGIN 14 15 END BEGIN 0 END BEGIN ACTION
~SetGlobal("OHH_stoneface","OH7200",2)
Unlock("DOOR04")
OpenDoor("DOOR04")~
END

ALTER_TRANS OHRJASSA BEGIN 0 END BEGIN 1 2 END BEGIN ACTION
~SetGlobalTimer("OHR_TIMER_SHANI","GLOBAL",FIVE_ROUNDS)
Enemy()
Shout(ALERT)
CloseDoor("DOOR04")
Lock("DOOR04")~
END

ALTER_TRANS PIRMUR04 BEGIN 1 7 8 9 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("SpawnCaptain","GLOBAL",1)
SetGlobal("GalvenaHostile","GLOBAL",1)
CreateCreature("pirmur05",[323.262],SW)
OpenDoor("Door01")~
END

ALTER_TRANS PIRMUR08 BEGIN 2 END BEGIN 0 END BEGIN ACTION
~SetGlobal("SpawnCaptain","GLOBAL",1)
SetGlobal("GalvenaHostile","GLOBAL",1)
CreateCreature("pirmur05",[323.261],SW)
OpenDoor("Door01")~
END

ALTER_TRANS PLFARM06 BEGIN 6 7 END BEGIN 0 END BEGIN ACTION
~SetGlobal("FarmerFight","GLOBAL",1)
EscapeArea()~
END

ALTER_TRANS PLGIRL01 BEGIN 5 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Tyrianna","GLOBAL",1)
SetGlobal("PaladinGirlSpawn","GLOBAL",2)
MoveToPointNoInterrupt([285.271])
StartCutSceneMode()
StartCutScene("cut26a")~
END

ALTER_TRANS PPDOOR BEGIN 6 END BEGIN 0 END BEGIN ACTION
~SetGlobal("PirateOpen","GLOBAL",1)
SetGlobal("AsylumPlot","GLOBAL",10)
Unlock("PirateDoor")
OpenDoor("PirateDoor")~
END

ALTER_TRANS PPDOOR BEGIN 7 END BEGIN 0 END BEGIN ACTION
~SetGlobal("PirateOpen","GLOBAL",3)
SetGlobal("AsylumPlot","GLOBAL",10)
Unlock("PirateDoor")
OpenDoor("PirateDoor")~
END

ALTER_TRANS PPDOOR BEGIN 8 END BEGIN 0 END BEGIN ACTION
~SetGlobal("PirateOpen","GLOBAL",2)
SetGlobal("AsylumPlot","GLOBAL",10)
Unlock("PirateDoor")
OpenDoor("PirateDoor")~
END

ALTER_TRANS PPIRENI2 BEGIN 39 END BEGIN 0 END BEGIN ACTION
~SetGlobal("OpenJonBedroom","GLOBAL",1)
SetGlobal("YoshimoTeleport","GLOBAL",1)
AddXPObject(Player1,68500)
AddXPObject(Player2,68500)
AddXPObject(Player3,68500)
AddXPObject(Player4,68500)
AddXPObject(Player5,68500)
AddXPObject(Player6,68500)
Unlock("Door01")
Unlock("Door02")
Unlock("Door05")
Unlock("Door06")
Unlock("Door07")
Unlock("Door08")
Unlock("Door10")
OpenDoor("Door01")
OpenDoor("Door02")
OpenDoor("Door05")
OpenDoor("Door06")
OpenDoor("Door07")
OpenDoor("Door08")
OpenDoor("Door10")
ApplySpell(Myself,DRYAD_TELEPORT)~
END

ALTER_TRANS PPSAEM BEGIN 27 END BEGIN 0 END BEGIN ACTION
~SetGlobal("AsylumPlot","GLOBAL",4)
SetGlobal("TourMove","AR1600",1)
SaveGame(0)~
END

ALTER_TRANS RASAA25J BEGIN 241 END BEGIN 1 END BEGIN ACTION
~SetGlobal("OHR_sarevok25","GLOBAL",4)
SetGlobal("OHR_KickedOut","LOCALS",1)
MoveToPointNoInterrupt([2260.1239])
Face(SWW)
SetLeavePartyDialogFile()~
END

ALTER_TRANS RASAA25J BEGIN 241 END BEGIN 2 END BEGIN ACTION
~SetGlobal("OHR_sarevok25","GLOBAL",4)
SetGlobal("OHR_KickedOut","LOCALS",1)
CreateVisualEffectObject("SPDIMNDR",Myself)
Wait(2)
SetLeavePartyDialogFile()
MoveBetweenAreas("AR4500",[2260.1239],SWW)~
END

ALTER_TRANS RASAADJ BEGIN 295 END BEGIN 2 END BEGIN ACTION
~SetGlobal("OHR_anomenconflict","GLOBAL",1)
RealSetGlobalTimer("OHR_anomenconflict_timer","GLOBAL",SIX_HOURS)~
END

ALTER_TRANS RASAADJ BEGIN 461 END BEGIN 0 END BEGIN ACTION
~LeaveParty()
ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
SetLeavePartyDialogFile()
EscapeAreaMove("AR2000",1673,1503,S)~
END

ALTER_TRANS RGRWLF01 BEGIN 8 18 END BEGIN 0 END BEGIN ACTION
~SetGlobal("AnathTemple","GLOBAL",1)
Polymorph(WEREWOLF)
EscapeArea()~
END

ALTER_TRANS RIFTG01 BEGIN 5 13 END BEGIN 0 END BEGIN ACTION
~SetGlobal("SpawnGuardian","AR0204",0)
CreateCreatureObjectEffect("RIFTCR01","SPCLOUD1",Myself)
DestroySelf()~
END

ALTER_TRANS RIFTG01 BEGIN 16 18 END BEGIN 0 END BEGIN ACTION
~SetGlobal("SpawnGuardian","AR0204",0)
CreateCreatureObjectEffect("RIFTCR02","SPCLOUD1",Myself)
DestroySelf()~
END

ALTER_TRANS RIFTG01 BEGIN 29 END BEGIN 0 END BEGIN ACTION
~SetGlobal("SpawnGuardian","AR0204",0)
CreateCreatureObjectEffect("RIFTCR03","SPCLOUD1",Myself)
DestroySelf()~
END

ALTER_TRANS RIFTG01 BEGIN 32 END BEGIN 0 END BEGIN ACTION
~SetGlobal("BridgeOpen","AR0204",1)
AddexperienceParty(42250)
DisplayStringHead(Myself,52979)
DestroySelf()~
END

ALTER_TRANS RNGWLF01 BEGIN 18 END BEGIN 0 END BEGIN ACTION
~SetGlobal("AnathTemple","GLOBAL",1)
Polymorph(WEREWOLF)
MoveToPointNoInterrupt([456.677])
EscapeArea()~
END

ALTER_TRANS SHAPE BEGIN 5 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Frennedan","AR0603",3)
SmallWait(7)
CreateVisualEffectObject("SPFLESHS",Myself)
Polymorph(BOY)
Wait(1)
StartDialogueNoSet([PC])~
END

// skip stonedl, unused/debug

ALTER_TRANS SUELLEAP BEGIN 11 END BEGIN 0 END BEGIN ACTION
~SetGlobal("saveme","AR2806",1)
CreateVisualEffectObject("SPFLESHS",Myself)
Wait(1)
CreateVisualEffectObject("SPDISPMA",Myself)
DestroySelf()~
END

ALTER_TRANS TRSKIN03 BEGIN 4 10 12 END BEGIN 0 END BEGIN ACTION
~SetGlobal("SkinWentHostile","GLOBAL",1)
ActionOverride("trskin06",CreateCreatureObject("TRSKIN3B",Myself,0,0,0))
ActionOverride("trskin06",ChangeAnimationNoEffect("TRSKIND2"))
ReallyForceSpell(Myself,SKIN_DANCER_RESTORE_2)  // SPIN725.SPL (No such index)
CreateItem("MISC79",0,0,0)
DropItem("MISC79",[-1.-1])
SmallWait(1)
ChangeAnimationNoEffect("TRSKIND1")~
END

ALTER_TRANS UDDROW04 BEGIN 9 END BEGIN 0 END BEGIN ACTION
~SetGlobal("PitFight","GLOBAL",1)
SetGlobal("PitOpen","AR2202",1)
SetGlobalTimer("PitShut","GLOBAL",4)
Unlock("Gate1")
OpenDoor("Gate1")~
END

ALTER_TRANS UDDROW04 BEGIN 15 36 END BEGIN 0 END BEGIN ACTION
~SetGlobal("PitOpen","AR2202",1)
SetGlobalTimer("PitShut","GLOBAL",4)
Unlock("Gate1")
OpenDoor("Gate1")~
END

ALTER_TRANS UDPHAE01 BEGIN 161 END BEGIN END BEGIN ACTION // all transitions
~SetGlobal("udDrowPlot","GLOBAL",44)
SetGlobalTimer("udEscape","GLOBAL",THREE_TURNS)
SetGlobal("udDemonHasDoneTheKill","GLOBAL",1)
ReallyForceSpell(Myself,CLERIC_FLAME_STRIKE)  // SPPR503.SPL (Flame Strike)
Wait(1)
Unlock("Door02")
Unlock("Door01")
Kill(Myself)~
END

ALTER_TRANS UDVITH BEGIN 34 END BEGIN 0 END BEGIN ACTION
~SetGlobal("dwVithal","GLOBAL",3)
SetGlobalTimer("dwVith","GLOBAL",FOUR_MINUTES)
ForceSpell(Myself,FLASHY_2)  // SPIN796.SPL (No such index)
CreateVisualEffectObject("SPPLANAR","udvith")  // Vithal
Deactivate(Myself)~
END

ALTER_TRANS UDVITH BEGIN 37 END BEGIN 0 END BEGIN ACTION
~SetGlobal("dwVithal","GLOBAL",11)
ForceSpell(Myself,FLASHY_2)
Wait(1)
CreateVisualEffect("SPPORTAL",[2732.2991])
CreateVisualEffect("SPFLSRIN",[2732.2991])
Wait(1)
CreateCreature("udeldf",[2732.2991],W)~
END

ALTER_TRANS UDVITH BEGIN 40 END BEGIN 0 END BEGIN ACTION
~SetGlobal("dwVithal","GLOBAL",15)
ForceSpell(Myself,FLASHY_2)
Wait(1)
CreateVisualEffect("SPPORTAL",[845.2896])
CreateVisualEffect("SPFLSRIN",[845.2896])
Wait(1)
CreateCreature("udelda",[845.2896],W)~
END

ALTER_TRANS UDVITH BEGIN 50 END BEGIN 0 END BEGIN ACTION
~SetGlobal("dwVithal","GLOBAL",13)
SetGlobalTimer("dwVith","GLOBAL",FOUR_MINUTES)
ForceSpell(Myself,FLASHY_2)
CreateVisualEffectObject("SPPLANAR","udvith")
Deactivate(Myself)~
END

ALTER_TRANS UDVITH BEGIN 51 END BEGIN 0 END BEGIN ACTION
~SetGlobal("dwVithal","GLOBAL",17)
SetGlobalTimer("dwVith","GLOBAL",FOUR_MINUTES)
ForceSpell(Myself,FLASHY_2)
CreateVisualEffectObject("SPPLANAR","udvith")
Deactivate(Myself)~
END

ALTER_TRANS VALYGAR BEGIN 38 END BEGIN 0 END BEGIN ACTION
~SetGlobal("ValygarHome","GLOBAL",1)
SetGlobal("KickedOut","LOCALS",1)
SetDialog("VALYGARP")
EscapeAreaMove("AR0326",451,233,S)~
END

ALTER_TRANS VALYGARJ BEGIN 69 END BEGIN 0 END BEGIN ACTION
~ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
ActionOverride("Viconia",LeaveParty())
ActionOverride("Viconia",Attack("Valygar"))
SetLeavePartyDialogFile()
LeaveParty()
ReallyForceSpellRES("OHSMODE3",Myself)
ReallyForceSpellRES("OHSMODE3","Viconia")
Attack("Viconia")~
END

ALTER_TRANS VICONI BEGIN 4 END BEGIN 0 1 END BEGIN ACTION
~SetGlobal("LoveTalk","LOCALS",1)
SetGlobal("ViconiaRomanceActive","GLOBAL",1)
RealSetGlobalTimer("ViconiaRomance","GLOBAL",ONE_DAY)~
END

ALTER_TRANS VICONI BEGIN 4 END BEGIN 2 END BEGIN ACTION
~SetGlobal("LoveTalk","LOCALS",1)
SetGlobal("ViconiaRomanceActive","GLOBAL",1)
RealSetGlobalTimer("ViconiaRomance","GLOBAL",ONE_DAY)
JoinParty()~
END

ALTER_TRANS VICONIJ BEGIN 85 END BEGIN 0 END BEGIN ACTION
~SetGlobal("KickedOut","LOCALS",1)
ChangeAIScript("",DEFAULT)
SetLeavePartyDialogFile()~
END

ALTER_TRANS VICONIJ BEGIN 286 END BEGIN 0 END BEGIN ACTION
~LeaveParty()
ChangeAIScript("",DEFAULT)
SetGlobal("KickedOut","LOCALS",1)
SetLeavePartyDialogFile()
EscapeAreaMove("AR0800",496,1090,SE)~
END

// kangaxx triggers, again
REPLACE_TRIGGER_TEXT hlkang ~HP(Myself,1)~ ~Global("KangaxxHurt","LOCALS",1)~ // sync with script trigger

// (romanced) neera-bodhi kidnapping issues - see also ar0800,bcs changes in main bg2ee.tph
ALTER_TRANS bodhiamb BEGIN 38 END BEGIN 0 END BEGIN ACTION // moving Setglobal after vamp spawns
~DialogInterrupt(FALSE)
CreateCreatureObject("VAMPIM01","bodhiamb",0,0,0)  // Vampire
CreateCreatureObject("VAMPIM01","bodhiamb",0,0,0)  // Vampire
CreateCreatureObject("VAMPIM01","bodhiamb",0,0,0)  // Vampire
CreateCreatureObject("VAMPIM01","bodhiamb",0,0,0)  // Vampire
SetGlobal("OHN_bodhiamb","AR0800",2)
ActionOverride("bodhiamb",ForceSpell(Myself,DRYAD_TELEPORT))  // SPWI995.SPL (Dimension Door)
Wait(1)
SetGlobal("Deactivate0801","AR0800",3)  // Graveyard
ActionOverride("bodhiamb",DestroySelf())~
END