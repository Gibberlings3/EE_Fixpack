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






