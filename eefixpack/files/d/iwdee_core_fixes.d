// ie-6036, cam (two issues here, see main tph for more)
// only 4/5 random lines can fire
REPLACE_TRIGGER_TEXT dgntslav ~RandomNumLT(4,[ %TAB%]*5)~ ~RandomNum(5,5)~ // fixed bugged replies for this one first
// kuldahar rumors include a random voiced line from arundel
REPLACE_STATE_TRIGGER dkurum 11 ~False()~ // false out arundel line
REPLACE_STATE_TRIGGER dkurum 15 ~RandomNum(15,12)~ // move in #16 into #12 slot
REPLACE_TRIGGER_TEXT  dkurum ~RandomNum(16,~ ~RandomNum(15,~ // refactor into random-of-15 instead of random-of-16
  
// ie-6012, cam
// Multiclasses should have special replies with Hobart
ALTER_TRANS DHOBART BEGIN 28 END BEGIN 2 END BEGIN "TRIGGER" ~Alignment(LastTalkedToBy,MASK_EVIL) Class(LastTalkedToBy,CLERIC_ALL)~ END // from cleric
ALTER_TRANS DHOBART BEGIN 28 END BEGIN 3 END BEGIN "TRIGGER" ~Alignment(LastTalkedToBy,MASK_EVIL) Class(LastTalkedToBy,MAGE_ALL)~ END // from mage
  
// ie-6011, cam
// Grisella shouldn't give rewards unprompted - grisella should only give cash if party asked for it
REPLACE_ACTION_TEXT DGRISELL ~GivePartyGold(5)~ ~~ // remove all
ADD_TRANS_TRIGGER DGRISELL 12 ~Global("Grisella_Cash","GLOBAL",1)~ DO 4
ADD_TRANS_ACTION DGRISELL BEGIN 12 END BEGIN 3 4 END ~GivePartyGold(5)~
  
// ie-6010, cam
// Everard lacking the correct replies - IWDFP < v6 fixed this incorrectly, now setting it right
ALTER_TRANS DACCALIA BEGIN 6 END BEGIN 1 END BEGIN "TRIGGER" ~~ END // removes SetGlobal("Jered_Stone","GLOBAL", 1)
ADD_TRANS_ACTION DACCALIA BEGIN 6 END BEGIN 1 END ~SetGlobal("Jered_Stone","GLOBAL",1)~ // and add it as an action

// tbd, cam
// upgrade for bren muller's crossbow doesn't work
REPLACE_ACTION_TEXT dplanar ~TransformItem("lxbowbm","cdxbowbm")~ ~TakePartyItem("lxbowbm") DestroyItem("lxbowbm") GiveItemCreate("cdxbowbm",LastTalkedToBy,0,1,0)~

// Tarnelm's dialog lacks a non-evil reply when asking about the oubliette
EXTEND_BOTTOM DTARNELM 4 IF ~~ REPLY #11383 EXIT END

// paladin reply in 7 being blocked by ranger-only check before it
ALTER_TRANS dogre BEGIN 1 END BEGIN 4 END BEGIN ~TRIGGER~ ~OR(2) Class(LastTalkedToBy,RANGER_ALL) Class(LastTalkedToBy,PALADIN_ALL) !Kit(LastTalkedToBy,Blackguard)~ END // ranger > ranger|paladin
ALTER_TRANS dogre BEGIN 2 END BEGIN 2 END BEGIN ~TRIGGER~ ~OR(2) Class(LastTalkedToBy,RANGER_ALL) Class(LastTalkedToBy,PALADIN_ALL) !Kit(LastTalkedToBy,Blackguard)~ END

ALTER_TRANS DKUTOWNG BEGIN 0 END BEGIN 13 END BEGIN 
  ~TRIGGER~ ~Global("Kuldahar_Rumor","GLOBAL",7)~        // swap trigger
  ~ACTION~  ~SetGlobal("Kuldahar_Rumor","GLOBAL",0)~ END // swap action
  
SET_WEIGHT dcapvil 20 #999 // two lines blocked because of weighting

// contact other plane fixes
ALTER_TRANS DPLANAR BEGIN 21 31 32 END BEGIN 0 END BEGIN ACTION ~~ END // premature cutscene call
REPLACE_TRIGGER_TEXT DPLANAR ~Global("AR5405_Visited","GLOBAL",1)~ ~Global("AR5103_Visited","GLOBAL",1)~ // larrel questions checking wrong var
ALTER_TRANS DPLANAR BEGIN 45 END BEGIN 4 END BEGIN TRIGGER ~Global("AR6006_Visited","GLOBAL",1) !Global("Forge_On","GLOBAL",0)~ END // jamoth tomb question wrong var
ADD_TRANS_TRIGGER DPLANAR 57 ~Global("AR1100_Visited","GLOBAL",1)~ DO 7 // pomab answer should wait until you're in easthaven at least

// adding some var sets and journal entries to valesti
ADD_TRANS_ACTION dvalesti BEGIN 8 END BEGIN 1 END ~SetGlobal("ArborQuestGiveN","GLOBAL",1) AddJournalEntry(34235,QUEST)~

// fixes Denaini's rewards if you complete her quest before speaking with her
ALTER_TRANS ddenaini BEGIN 12 END BEGIN 2 END BEGIN ~EPILOGUE~ ~GOTO 19~ END

// kerish only setting journal entry on 1/3 paths
ADD_TRANS_ACTION dkerish BEGIN 2 3 END BEGIN 1 END ~AddJournalEntry(9081,INFO)~

// davin adding journal entry on wrong reply
ALTER_TRANS ddavin BEGIN 1 END BEGIN 0 END BEGIN ~ACTION~ ~~ END // remove here
ALTER_TRANS ddavin BEGIN 1 END BEGIN 1 END BEGIN ~ACTION~ ~AddJournalEntry(34294,QUEST)~ END // and add it back
// three different paths to inform davin you killed frostbite - one lacks journal entry, one has wrong reward (22.0 is fine)
REPLACE_ACTION_TEXT ddavin ~AddXP2DA("Level_10_Hard")~ ~AddXP2DA("Level_12_Hard")~ // fixes 7.0
ADD_TRANS_ACTION ddavin BEGIN 21 END BEGIN 0 END ~AddJournalEntry(34291,QUEST_DONE) 
                                                  EraseJournalEntry(34294)
                                                  EraseJournalEntry(2097) 
                                                  EraseJournalEntry(2119) 
                                                  EraseJournalEntry(3422) 
                                                  EraseJournalEntry(19286)
                                                  EraseJournalEntry(20256)
                                                  EraseJournalEntry(23442)~ // fixes 21.0
                                                  
// joril not setting var, journal as he does the two other places you can ask him this question
ADD_TRANS_ACTION djoril BEGIN 17 END BEGIN 0 END ~SetGlobal("Know_Sacrifices","GLOBAL",1) AddJournalEntry(34241,INFO)~

// beorn should set journal entry on both replies
ADD_TRANS_ACTION dbeorn BEGIN 0 END BEGIN 1 END ~AddJournalEntry(34420,INFO)~

// should only be able to ask Flozem about Marketh if you know him
ADD_TRANS_TRIGGER DFLOZEM 2 ~Global("Know_Marketh","GLOBAL",1)~ DO 0

/////                                                  \\\\\
///// mixing instants and non-instants                 \\\\\
/////                                                  \\\\\

// https://www.gibberlings3.net/forums/topic/39370-pstee-respawned-bariaur-should-not-talk-like-you-parted-on-friendly-terms/

ALTER_TRANS DCONLAN BEGIN 34 END BEGIN 0 END BEGIN ACTION
~TakePartyItem("stout")
TakePartyItem("cdmitham")
TakePartyGold(1000)
SetGlobal("CDStoutUpgrade","MYAREA",2)
SetGlobalTimer("CDStoutUpgradeTimer","MYAREA",ONE_DAY)
DestroyItem("stout")
DestroyItem("cdmitham")~
END

ALTER_TRANS DCONLAN BEGIN 35 END BEGIN 0 END BEGIN ACTION
~TakePartyItem("stout")
TakePartyItem("cdmitham")
TakePartyGold(4500)
SetGlobal("CDStoutUpgrade","MYAREA",2)
SetGlobalTimer("CDStoutUpgradeTimer","MYAREA",ONE_DAY)
DestroyItem("stout")
DestroyItem("cdmitham")~
END

ALTER_TRANS DCONLAN BEGIN 42 END BEGIN 0 END BEGIN ACTION
~TakePartyItem("cdscales")  // White Dragon Scales
TakePartyGold(5000)
SetGlobal("CDScales","MYAREA",2)
SetGlobalTimer("CDScalesTimer","MYAREA",THREE_DAYS)
DestroyItem("cdscales")~
END

ALTER_TRANS DDIRTYLL BEGIN 25 END BEGIN 0 END BEGIN ACTION
~TakePartyGold(8000)
TakePartyItem("cdrem")
SetGlobal("CDRem","MYAREA",1)
SetGlobalTimer("CDRemTimer","MYAREA",THREE_DAYS)
DestroyItem("cdrem")~
END

ALTER_TRANS DDIRTYLL BEGIN 26 END BEGIN 0 END BEGIN ACTION
~TakePartyGold(7000)
TakePartyItem("cdrem")
SetGlobal("CDRem","MYAREA",1)
SetGlobalTimer("CDRemTimer","MYAREA",THREE_DAYS)
DestroyItem("cdrem")~
END

ALTER_TRANS DDIRTYLL BEGIN 27 END BEGIN 0 END BEGIN ACTION
~TakePartyGold(5000)
TakePartyItem("cdrem")
SetGlobal("CDRem","MYAREA",1)
SetGlobalTimer("CDRemTimer","MYAREA",THREE_DAYS)
DestroyItem("cdrem")~
END

ALTER_TRANS DEDION BEGIN 16 END BEGIN 4 END BEGIN ACTION
~TakePartyItem("misc58")
TakePartyItem("misc58")
TakePartyItem("misc58")
TakePartyItem("mystery")
SetGlobalTimer("CDMysteryTimer","MYAREA",1200)
SetGlobal("CDMystery","MYAREA",2)
DestroyItem("mystery")~
END

ALTER_TRANS DEDION BEGIN 22 END BEGIN 0 END BEGIN ACTION
~TakePartyGold(300)
TakePartyItem("young")
GiveItemCreate("cdyoung",LastTalkedToBy,0,0,0)
SetGlobal("CDYoung","GLOBAL",8)
DestroyItem("young")~
END

ALTER_TRANS DEDION BEGIN 23 END BEGIN 0 END BEGIN ACTION
~TakePartyGold(300)
TakePartyItem("young")
GiveItemCreate("cdyoung",LastTalkedToBy,0,0,0)
SetGlobal("CDYoung","GLOBAL",8)
DestroyItem("young")~
END

ALTER_TRANS DEDION BEGIN 27 END BEGIN 0 END BEGIN ACTION
~TakePartyItem("misc58")
TakePartyItem("misc58")
TakePartyItem("misc58")
TakePartyItem("mystery")
SetGlobalTimer("CDMysteryTimer","MYAREA",1200)
SetGlobal("CDMystery","MYAREA",2)
DestroyItem("mystery")~
END

ALTER_TRANS DMURDAUG BEGIN 54 END BEGIN 0 END BEGIN ACTION
~GiveItemCreate("cddaen",LastTalkedToBy,1000,0,0)
SetGlobal("CDMurduaghDaen","MYAREA",3)
DestroyItem("cddaen")~
END

ALTER_TRANS DORRICK BEGIN 26 END BEGIN 0 END BEGIN ACTION
~TakePartyGold(15000)
TakePartyItem("beetshld")
SetGlobal("CDOrrickShield","MYAREA",2)
SetGlobalTimer("CDOrrickShieldTimer","MYAREA",THREE_DAYS)
DestroyItem("beetshld")~
END

ALTER_TRANS DORRICK BEGIN 27 END BEGIN 0 END BEGIN ACTION
~TakePartyGold(30000)
TakePartyItem("beetshld")
SetGlobal("CDOrrickShield","MYAREA",2)
SetGlobalTimer("CDOrrickShieldTimer","MYAREA",THREE_DAYS)
DestroyItem("beetshld")~
END

ALTER_TRANS DOSWALD BEGIN 35 36 37 END BEGIN 0 END BEGIN ACTION
~TakePartyItem("beltgon")
SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
SetGlobal("CDOswaldItem","MYAREA",5)
DestroyItem("beltgon")~
END

ALTER_TRANS DOSWALD BEGIN 37 END BEGIN 1 END BEGIN ACTION
~TakePartyItem("beltgon")
SetGlobalTimer("CDOswaldTimer","MYAREA",ONE_DAY)
GiveGoldForce(50)
SetGlobal("CDOswaldItem","MYAREA",4)
DestroyItem("beltgon")~
END

ALTER_TRANS DTEALNIS BEGIN 16 END BEGIN 0 END BEGIN ACTION
~GiveItemCreate("cddaen",LastTalkedToBy,1000,0,0)
SetGlobal("CDTelanisDaen","MYAREA",3)
DestroyItem("cddaen")~
END

ALTER_TRANS DTIERNON BEGIN 68 END BEGIN 0 END BEGIN ACTION
~TakePartyItem("young")
GiveItemCreate("cdyoung",LastTalkedToBy,0,0,0)
SetGlobal("CDYoung","GLOBAL",8)
DestroyItem("young")~
END

ALTER_TRANS DWYLF BEGIN 58 END BEGIN 0 1 END BEGIN ACTION
~TakePartyItem("Mirror")
TakePartyItem("Mirror2")
SetGlobal("Looked_Mirror","GLOBAL",1)
DestroyItem("Mirror")
DestroyItem("Mirror2")~
END
