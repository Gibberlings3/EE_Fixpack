// Monster Jug in Vrischika's Curiosity Shop should cost 123 coppers when it is bought
REPLACE_TRANS_TRIGGER DVRISCH BEGIN 34 END BEGIN 0 END ~PartyGoldGT(99)~ ~PartyGoldGT(122)~
REPLACE_TRANS_ACTION  DVRISCH BEGIN 34 END BEGIN 0 END ~DestroyPartyGold(100)~ ~DestroyPartyGold(123)~

// Kitla's dialog should not create duplicate journal entries
ALTER_TRANS DKITLA BEGIN 5 9 END BEGIN 0 END BEGIN "JOURNAL" "#49473" END
ALTER_TRANS DKITLA BEGIN 9 END BEGIN 1 END BEGIN "JOURNAL" "" END  // remove journal entry

// Fall-from-Grace's dialog should not create duplicate journal entries
ALTER_TRANS DGRACE BEGIN 72 73 213 214 END BEGIN 0 1 2 END BEGIN "JOURNAL" "#27465" END

// Fall-from-Grace's dialog should show correct reply string (strref 28454 -> 28448)
ALTER_TRANS DGRACE BEGIN 96 END BEGIN 2 END BEGIN "REPLY" "#28448" END

// Pillar of Skulls dialog should not create duplicate journal entries
// Note: Choosing string where "Trias the Betrayer" is enclosed in single quotes.
ALTER_TRANS DPILLAR BEGIN 35 36 END BEGIN 3 END BEGIN "JOURNAL" "#53500" END

// Ingress' teeth should preserve the correct damage type when transforming to a more powerful weapon
ALTER_TRANS IPTEETH BEGIN 3 END BEGIN 1 END BEGIN ~ACTION~ ~TransformPartyItem("IPTeeth","M1PTeeth",1,0,0)~ END
ALTER_TRANS IPTEETH BEGIN 4 END BEGIN 1 END BEGIN ~ACTION~ ~TransformPartyItem("M1PTeeth","M2PTeeth",1,0,0)~ END
ALTER_TRANS IPTEETH BEGIN 5 END BEGIN 1 END BEGIN ~ACTION~ ~TransformPartyItem("M2PTeeth","M3PTeeth",1,0,0)~ END

// TTO/Companion cutscenes in Fortress of Regrets should clear all actions to prevent TNO from being killed
REPLACE_TRANS_ACTION DMACH1 BEGIN 2 4 6 END BEGIN 0 END ~StartCutSceneMode()~ ~ClearAllActions() StartCutSceneMode()~ UNLESS ~ClearAllActions()~
REPLACE_TRANS_ACTION DMACH3 BEGIN 2 3 5 END BEGIN 0 END ~StartCutSceneMode()~ ~ClearAllActions() StartCutSceneMode()~ UNLESS ~ClearAllActions()~
REPLACE_TRANS_ACTION DMACH4 BEGIN 2 3 5 END BEGIN 0 END ~StartCutSceneMode()~ ~ClearAllActions() StartCutSceneMode()~ UNLESS ~ClearAllActions()~

// Vhailor's ForceAttack() actions should use the correct script name
REPLACE_TRANS_ACTION DTRIAS BEGIN 70 END BEGIN 0 1 2 END ~"Vhailor"~ ~"Vhail"~

// Removing a use action with a non-existing item in Marissa's dialog
REPLACE_TRANS_ACTION DMARISSA BEGIN 49 END BEGIN 0 END ~UseItem("M_Gaze",Protagonist)~ ~~

// Nihl Xander should give you an existing 'Pacify' scroll when following the Dreambuilder conversation branch
REPLACE_TRANS_ACTION DXANDER BEGIN 22 END BEGIN 1 END ~GiveItemCreate("PacScrll",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("SPWI108",Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DXANDER BEGIN 25 END BEGIN 0 1 END ~GiveItemCreate("PacScrll",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("SPWI108",Protagonist,1,1,0)~

// Items should be created with the right number of charges
REPLACE_TRANS_ACTION DCANDRI BEGIN 36 END BEGIN 0 END ~GiveItemCreate("NToken",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("NToken",Protagonist,17,0,0)~
REPLACE_TRANS_ACTION DIANNIS BEGIN 29 30 104 END BEGIN 0 END ~GiveItemCreate("Dlegacy2",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("Dlegacy2",Protagonist,1,0,0)~
REPLACE_TRANS_ACTION DIANNIS BEGIN 29 30 104 END BEGIN 0 END ~GiveItemCreate("HearChrm",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("HearChrm",Protagonist,1,0,0)~
REPLACE_TRANS_ACTION DIANNIS BEGIN 70 END BEGIN 0 END ~GiveItemCreate("Maslow",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("Maslow",Protagonist,33,0,0)~

// Spell scrolls should be created with the right number of charges
REPLACE_TRANS_ACTION DGHIVERM BEGIN 47 END BEGIN 0 1 END ~GiveItemCreate("SPWI107",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("SPWI107",Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DKITLA BEGIN 37 END BEGIN 0 1 END ~GiveItemCreate(\("[^"]+"\),Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate(\1,Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DDAKKON BEGIN 294 END BEGIN 2 8 10 END ~GiveItemCreate(\("[^"]+"\),Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate(\1,Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DDAKKON BEGIN 299 END BEGIN 0 END ~GiveItemCreate("Circle03",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("Circle03",Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DDAKKON BEGIN 305 END BEGIN 0 END ~GiveItemCreate("Circle04",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("Circle04",Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DDAKKON BEGIN 320 END BEGIN 0 END ~GiveItemCreate("Circle07",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("Circle07",Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DDAKKON BEGIN 324 END BEGIN 0 END ~GiveItemCreate("Circle08",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("Circle08",Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DEBB BEGIN 65 74 END BEGIN 0 END ~GiveItemCreate("SPWI505",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("SPWI505",Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DIGNUS BEGIN 67 71 76 80 END BEGIN 0 END ~GiveItemCreate(\("[^"]+"\),Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate(\1,Protagonist,1,1,0)~
REPLACE_TRANS_ACTION DNORDOM BEGIN 84 END BEGIN 0 END ~GiveItemCreate("Enoll",Protagonist,[0-9]+,[0-9]+,[0-9]+)~ ~GiveItemCreate("Enoll",Protagonist,1,1,0)~

// fixes for nodd/amarysse quest
ALTER_TRANS dnodd BEGIN 7 END BEGIN 0 END BEGIN ~TRIGGER~ ~PartyGoldGT(1)~ END // was gt 2
ALTER_TRANS damarys BEGIN 4 END BEGIN 0 1 END BEGIN ~TRIGGER~ ~GlobalLT("Nodd_Quest","GLOBAL",3)~ END // excluded 1
ALTER_TRANS damarys BEGIN 5 END BEGIN 0 3 END BEGIN ~TRIGGER~ ~GlobalLT("Nodd_Quest","GLOBAL",3)~ END // excluded 1
ALTER_TRANS damarys BEGIN 7 END BEGIN 0 2 END BEGIN ~TRIGGER~ ~GlobalLT("Nodd_Quest","GLOBAL",3)~ END // excluded 1

// all branches leading to Black-Barbed Seed sprouting should consume the seed
ADD_TRANS_ACTION dmftree BEGIN 56 57 END BEGIN 2 END ~DestroyPartyItem("BSeed1",TRUE)~

// NVLOR in morte's dialogue: !NearbyDialog("Dgrace") > OR(2) !NearbyDialog("Dgrace") Global("Ravel_Grace","GLOBAL",0) 
ALTER_TRANS dmorte BEGIN 558 END BEGIN 2 END BEGIN ~TRIGGER~ ~GlobalGT("Ravel_Morte","GLOBAL",0) GlobalLT("Torment_Fell","GLOBAL",2) OR(2) !NearbyDialog("Dgrace") Global("Ravel_Grace","GLOBAL",0)~ END
ALTER_TRANS dmorte BEGIN 558 END BEGIN 3 END BEGIN ~TRIGGER~ ~GlobalGT("Ravel_Morte","GLOBAL",0) Global("Torment_Fell","GLOBAL",2) OR(2) !NearbyDialog("Dgrace") Global("Ravel_Grace","GLOBAL",0)~ END

/////                                                  \\\\\
///// mixing instants and non-instants                 \\\\\
/////                                                  \\\\\

// https://www.gibberlings3.net/forums/topic/39370-pstee-respawned-bariaur-should-not-talk-like-you-parted-on-friendly-terms/

ALTER_TRANS BLADEIM BEGIN 2 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Immortal_Blade_Death","GLOBAL",1)
SetGlobal("Game_Over","GLOBAL",4)
SetAnimState(Protagonist,ANIM_MIMEDIE)
StartMovie("T1Death")~
END

ALTER_TRANS D300MER5 BEGIN 12 13 END BEGIN 0 END BEGIN ACTION
~SetGlobal("cd_int_1","LOCALS",1)
SetGlobal("Buy_LL","GLOBAL",3)
RunAwayFrom(Protagonist,2)~
END

ALTER_TRANS DADYZOEL BEGIN 9 20 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Adyzoel","AR0400",3)
IncrementGlobalOnceEx("GLOBALChaotic_Adyzoel_1","GLOBALLaw",-1)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DANAM BEGIN 0 END BEGIN 3 END BEGIN ACTION
~SetGlobal("Talked_With_Anamoli","AR0108",1)  // Trash Warrens
SetAnimState(Myself,ANIM_STANDTOSTANCE)~
END

ALTER_TRANS DANNAH BEGIN 250 END BEGIN 0 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALEvil_Vrischika_2","GLOBALGood",-2)
SetGlobal("Sell_Annah","GLOBAL",2)
LeaveParty()
Enemy()
Attack(Protagonist)
ChangeAIScript("MDKTNO",DEFAULT)~
END

ALTER_TRANS DANNAH BEGIN 344 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",5)
SetNamelessClass(THIEF)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,2500)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DANNAH BEGIN 344 END BEGIN 1 END BEGIN ACTION
~SetNamelessClass(THIEF)
SetGlobal("Thief_Training","GLOBAL",5)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3125)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DANNAH BEGIN 344 END BEGIN 2 END BEGIN ACTION
~SetNamelessClass(THIEF)
SetGlobal("Thief_Training","GLOBAL",5)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3438)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DANNAH BEGIN 344 END BEGIN 3 END BEGIN ACTION
~SetNamelessClass(THIEF)
SetGlobal("Thief_Training","GLOBAL",5)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3750)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DANNAH BEGIN 349 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Annah_Stealth","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,1000)
PermanentStatChange(Protagonist,STEALTH,RAISE,3)~
END

ALTER_TRANS DANNAH BEGIN 351 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Annah_Open_Locks","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,1000)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,3)~
END

ALTER_TRANS DANNAH BEGIN 353 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Annah_Traps","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,1000)
PermanentStatChange(Protagonist,TRAPS,RAISE,3)~
END

ALTER_TRANS DANNAH BEGIN 364 END BEGIN 0 END BEGIN ACTION
~SetGlobal("PC_Annah_Stealth ","GLOBAL",1)
SetGlobal("Annah_Training","GLOBAL",0)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience("Annah",1000)
PermanentStatChange("Annah",STEALTH,RAISE,3)~
END

ALTER_TRANS DANNAH BEGIN 364 END BEGIN 1 END BEGIN ACTION
~SetGlobal("PC_Annah_Open_Locks","GLOBAL",1)
SetGlobal("Annah_Training","GLOBAL",0)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience("Annah",1000)
PermanentStatChange("Annah",LOCKPICKING,RAISE,3)~
END

ALTER_TRANS DANNAH BEGIN 364 END BEGIN 3 END BEGIN ACTION
~SetGlobal("PC_Annah_Traps","GLOBAL",1)
SetGlobal("Annah_Training","GLOBAL",0)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience("Annah",1000)
PermanentStatChange("Annah",TRAPS,RAISE,3)~
END

ALTER_TRANS DAWAIT BEGIN 47 END BEGIN 0 END BEGIN ACTION
~PlaySoundNotRanged("SPE_11")
AddexperienceParty(35)
IncrementGlobalOnceEx("GLOBALChaotic_Await_5","GLOBALLaw",-1)
IncrementGlobalOnceEx("GLOBALEvil_Await_6","GLOBALGood",-1)
SetAnimState(Myself,ANIM_MIMEDIE)~
END

ALTER_TRANS DBARIA BEGIN 11 END BEGIN 0 1 END BEGIN ACTION
~SetGlobal("BariA","AR0400",3)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DBARIA BEGIN 27 END BEGIN 1 END BEGIN ACTION
~SetGlobal("BariA","AR0400",3)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DBERROG BEGIN 13 END BEGIN 0 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALGood_Berrog_1","GLOBALGood",1)
IncrementGlobal("Curst_Counter","GLOBAL",1)
SetGlobal("Cart_Trap","GLOBAL",1)
FadeToColor([20.0],0)
Wait(1)
FadeFromColor([20.0],0)
AddexperienceParty(225000)~
END

ALTER_TRANS DBERROG BEGIN 18 END BEGIN 1 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALGood_Berrog_1","GLOBALGood",1)
IncrementGlobal("Curst_Counter","GLOBAL",1)
SetGlobal("Cart_Trap","GLOBAL",1)
Kill("Burgher")
FadeToColor([20.0],0)
Wait(1)
FadeFromColor([20.0],0)
AddexperienceParty(125000)~
END

ALTER_TRANS DBISH BEGIN 2 7 END BEGIN 3 END BEGIN ACTION
~IncrementGlobal("Law","GLOBAL",-1)
SetAnimState(Myself,ANIM_STANDTOSTANCE)~
END

ALTER_TRANS DBISH BEGIN 4 END BEGIN 2 END BEGIN ACTION
~IncrementGlobal("Law","GLOBAL",-1)
SetAnimState(Myself,ANIM_STANDTOSTANCE)~
END

ALTER_TRANS DBLADEIM BEGIN 2 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Immortal_Blade_Death","GLOBAL",1)
SetGlobal("Game_Over","GLOBAL",4)
SetAnimState(Protagonist,ANIM_MIMEDIE)
StartMovie("T1Death")~
END

ALTER_TRANS DBURGHER BEGIN 5 END BEGIN 0 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALGood_Burgher_1","GLOBALGood",1)
IncrementGlobal("Curst_Counter","GLOBAL",1)
SetGlobal("Cart_Trap","GLOBAL",2)
FadeToColor([20.0],0)
Wait(1)
FadeFromColor([20.0],0)
AddexperienceParty(125000)~
END

ALTER_TRANS DBURGHER BEGIN 26 END BEGIN 0 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALGood_Burgher_1","GLOBALGood",1)
IncrementGlobal("Curst_Counter","GLOBAL",1)
SetGlobal("Cart_Trap","GLOBAL",3)
FadeToColor([20.0],0)
Wait(1)
FadeFromColor([20.0],0)
AddexperienceParty(225000)~
END

ALTER_TRANS DCARVER BEGIN 18 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,2500)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DCARVER BEGIN 18 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3125)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DCARVER BEGIN 18 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3438)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DCARVER BEGIN 18 END BEGIN 3 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3750)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DCOAX BEGIN 46 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Coaxmetal_Weapon","GLOBAL",1)
GiveItemCreate("BladeIm",Protagonist,1,0,0)
AddexperienceParty(10000)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DCOAX BEGIN 57 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Coaxmetal","GLOBAL",5)
AddexperienceParty(12000)
FadeToColor([20.0],0)
Wait(3)
TeleportParty("AR0500",[3530.1654],0)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DCOAX BEGIN 58 END BEGIN 0 END BEGIN ACTION
~DestroyPartyItem("Cube",TRUE)
AddexperienceParty(12000)
IncrementGlobalOnceEx("GLOBALChaotic_Coaxmetal_1","GLOBALLaw",-5)
IncrementGlobalOnceEx("GLOBALEvil_Coaxmetal_1","GLOBALGood",-5)
SetGlobal("Coaxmetal","GLOBAL",5)
FadeToColor([20.0],0)
Wait(3)
TeleportParty("AR0500",[3530.1654],0)
FadeFromColor([20.0],0)
GiveItemCreate("EDag",Protagonist,1,0,0)~
END

ALTER_TRANS DCOAX BEGIN 59 END BEGIN 0 END BEGIN ACTION
~DestroyPartyItem("Cube",TRUE)
AddexperienceParty(12000)
IncrementGlobalOnceEx("GLOBALChaotic_Coaxmetal_1","GLOBALLaw",-5)
IncrementGlobalOnceEx("GLOBALEvil_Coaxmetal_1","GLOBALGood",-5)
SetGlobal("Coaxmetal","GLOBAL",5)
FadeToColor([20.0],0)
Wait(3)
TeleportParty("AR0500",[3530.1654],0)
FadeFromColor([20.0],0)
GiveItemCreate("EDag",Protagonist,1,0,0)~
END

ALTER_TRANS DCRADDO BEGIN 16 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Craddock_Quest","GLOBAL",4)
GivePartyGold(10)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DCRADDO BEGIN 16 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Craddock_Quest","GLOBAL",4)
GivePartyGold(20)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DCRADDO BEGIN 16 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Craddock_Quest","GLOBAL",4)
GivePartyGold(30)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DDAKKON BEGIN 8 9 END BEGIN 3 END BEGIN ACTION
~Enemy()
ChangeAIScript("MDKTNO",DEFAULT)
IncrementGlobal("BD_DAKKON_MORALE","GLOBAL",-2)
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DDAKKON BEGIN 10 END BEGIN 2 END BEGIN ACTION
~Enemy()
ChangeAIScript("MDKTNO",DEFAULT)
IncrementGlobal("BD_DAKKON_MORALE","GLOBAL",-2)
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DDAKKON BEGIN 342 END BEGIN 0 END BEGIN ACTION
~IncrementGlobal("Githzerai","GLOBAL",1)
SetGlobal("Know_Githzerai_Speak","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,600)~
END

ALTER_TRANS DDEATHAD BEGIN 41 END BEGIN 0 END BEGIN ACTION
~SetGlobal("CW_Suicide_Reason","GLOBAL",1)
SetGlobal("Death_Lecture","GLOBAL",2)
IncrementGlobal("Death","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DDEATHAD BEGIN 47 END BEGIN 0 END BEGIN ACTION
~SetGlobal("CW_Suicide_Reason","GLOBAL",2)
SetGlobal("Death_Lecture","GLOBAL",2)
IncrementGlobal("Death","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DDEATHAD BEGIN 50 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Death_Lecture","GLOBAL",4)
SetGlobal("Lecture_Death","GLOBAL",2)
IncrementGlobalOnceEx("GLOBALEvil_DA_1","GLOBALGood",-2)
Enemy()
ForceAttack(Protagonist,Myself)
RunAwayFrom(Protagonist,150)~
END

ALTER_TRANS DDOLORA BEGIN 7 END BEGIN 3 5 END BEGIN ACTION
~SetGlobal("Memory_Dolora_1","AR0605",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DDUST BEGIN 38 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Mortuary_Alert","GLOBAL",1)
PlaySoundNotRanged("AMB_M01")
Enemy()
IncrementGlobal("Law","GLOBAL",-1)
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DDUST BEGIN 38 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Mortuary_Alert","GLOBAL",1)
PlaySoundNotRanged("AMB_M01")
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DDUSTFEM BEGIN 38 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Mortuary_Alert","GLOBAL",1)
PlaySoundNotRanged("AMB_M01")
Enemy()
IncrementGlobal("Law","GLOBAL",-1)
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DEIVENE BEGIN 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Mortuary_Alert","GLOBAL",1)
PlaySoundNotRanged("AMB_M01")
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DELI BEGIN 39 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,2500)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DELI BEGIN 39 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3125)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DELI BEGIN 39 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3438)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DELI BEGIN 39 END BEGIN 3 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3750)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DELOBRAN BEGIN 0 END BEGIN 0 END BEGIN ACTION
~SetGlobal("CW_Fortune","AR0600",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DELOBRAN BEGIN 2 END BEGIN 1 END BEGIN ACTION
~SetGlobal("CW_Fortune","AR0600",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DFINNOTE BEGIN 0 END BEGIN 0 END BEGIN ACTION
~SetGlobal("P_Journal","GLOBAL",4)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
PlaySoundNotRanged("SPTR_01")~
END

ALTER_TRANS DGHIVERM BEGIN 44 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Hive_OT_B","GLOBAL",1)
Enemy()
EscapeArea()~
END

ALTER_TRANS DGIANTSK BEGIN 2 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Mortuary_Alert","GLOBAL",1)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DGITH BEGIN 10 11 END BEGIN 3 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALChaotic_Githzerai_1","GLOBALLaw",-1)
IncrementGlobalOnceEx("GLOBALEvil_Githzerai_1","GLOBALGood",-1)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DGITH BEGIN 62 END BEGIN 3 END BEGIN ACTION
~SetGlobal("BD_DAKKON_MORALE","GLOBAL",0)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DGITH BEGIN 67 END BEGIN 2 END BEGIN ACTION
~IncrementGlobal("BD_DAKKON_MORALE","GLOBAL",-2)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DGITH BEGIN 68 END BEGIN 4 END BEGIN ACTION
~IncrementGlobal("BD_DAKKON_MORALE","GLOBAL",-2)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DGITH BEGIN 72 END BEGIN 0 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALChaotic_Githzerai_3","GLOBALLaw",-1)
IncrementGlobalOnceEx("GLOBALEvil_Githzerai_3","GLOBALGood",-1)
IncrementGlobal("BD_DAKKON_MORALE","GLOBAL",-2)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DGITH BEGIN 73 END BEGIN 1 END BEGIN ACTION
~IncrementGlobal("BD_DAKKON_MORALE","GLOBAL",-2)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DGONCAL BEGIN 6 7 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Goncalves","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DHGCORV BEGIN 32 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Byron_Arrested","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DHGUARD BEGIN 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Call_MK","GLOBAL",1)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DHIVEF1 BEGIN 39 40 END BEGIN 0 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALChaotic_Hive_Fright_3","GLOBALLaw",-1)
IncrementGlobalOnceEx("GLOBALEvil_Hive_Fright_4","GLOBALGood",-1)
Enemy()
RunAwayFrom(Protagonist,60)~
END

ALTER_TRANS DHPATROL BEGIN 10 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Call_MK","GLOBAL",1)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DIANNIS BEGIN 29 30 104 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Know_Deionarra_Legacy","GLOBAL",2)
GiveItemCreate("DLegacy1",Protagonist,0,0,0)
GiveItemCreate("Dlegacy2",Protagonist,1,0,0)
GiveItemCreate("HearChrm",Protagonist,1,0,0)
GiveItemCreate("DWedRing",Protagonist,0,0,0)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
AddexperienceParty(8000)~
END

ALTER_TRANS DIGNUS BEGIN 13 END BEGIN 1 END BEGIN ACTION
~IncrementGlobalOnceEx("GLOBALEvil_Mourns_3","GLOBALGood",-2)
Attack("MFTree")~
END

ALTER_TRANS DKELDOR BEGIN 48 END BEGIN 0 END BEGIN ACTION
~SetGlobal("G_Test2","GLOBAL",9)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DKELDOR BEGIN 49 END BEGIN 0 END BEGIN ACTION
~SetGlobal("G_Test2","GLOBAL",11)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DKIMASXI BEGIN 18 END BEGIN 0 END BEGIN ACTION
~IncrementGlobal("Morte_Taunt","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DKITLA BEGIN 27 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Mage_Training","GLOBAL",4)
FadeToColor([20.0],0)
Wait(2)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DLINGASH BEGIN 5 END BEGIN 0 END BEGIN ACTION
~SetGlobal("P_Journal","GLOBAL",4)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
PlaySoundNotRanged("SPTR_01")~
END

ALTER_TRANS DMAR BEGIN 11 15 END BEGIN 0 END BEGIN ACTION // for Cardassia!
~IncrementGlobalOnceEx("GLOBALEvil_Mar_1","GLOBALGood",-1)
GivePartyGold(500)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DMORTE BEGIN 94 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Vaxis_Zombie_XP","GLOBAL",1)
FadeToColor([20.0],0)
Wait(1)
SetNamelessDisguise(ZOMBIE)
Wait(2)
FadeFromColor([20.0],0)
AddexperienceParty(500)~
END

ALTER_TRANS DNABAT BEGIN 34 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",4)
SetNamelessClass(THIEF)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3000)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DNABAT BEGIN 34 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",4)
SetNamelessClass(THIEF)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3500)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DNABAT BEGIN 34 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",4)
SetNamelessClass(THIEF)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3750)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DNORDOM BEGIN 81 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Nordom_Fighter_Order","GLOBAL",1)
AddexperienceParty(36000)
SetAnimState("Nordom",ANIM_STANDTOSTANCE)~
END

ALTER_TRANS DPOX BEGIN 12 END BEGIN 1 2 END BEGIN ACTION
~SetGlobal("Pox_Smuggle_XP","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
AddexperienceParty(500)~
END

ALTER_TRANS DRAVEL BEGIN 168 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Ravel_EiVene","GLOBAL",2)
PermanentStatChange(Protagonist,MAXHITPOINTS,RAISE,3)
FullHeal(Protagonist)
SetAnimState("Ravel",ANIM_MIMESTANDFIDGET1)~
END

ALTER_TRANS DRKCHSR BEGIN 23 END BEGIN 0 1 END BEGIN ACTION
~SetGlobal("RChaser","AR0400",3)
RunAwayFrom(Protagonist,30)~
END

ALTER_TRANS DR_BONE BEGIN 18 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,2500)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DR_BONE BEGIN 18 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3125)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DR_BONE BEGIN 18 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3438)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DR_BONE BEGIN 18 END BEGIN 3 END BEGIN ACTION
~SetGlobal("Thief_Training","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
GiveExperience(Protagonist,3750)
PermanentStatChange(Protagonist,STEALTH,RAISE,17)
PermanentStatChange(Protagonist,TRAPS,RAISE,13)
PermanentStatChange(Protagonist,PICKPOCKET,RAISE,22)
PermanentStatChange(Protagonist,LOCKPICKING,RAISE,18)~
END

ALTER_TRANS DSABAST BEGIN 59 END BEGIN 0 END BEGIN ACTION
~SetNamelessClass(MAGE)
SetGlobal("Mage_Training","GLOBAL",3)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DSARHAVA BEGIN 8 END BEGIN END BEGIN ACTION // all transitions
~SetGlobal("Sarhava","GLOBAL",3)
EscapeArea()~
END

ALTER_TRANS DSCPAT2 BEGIN 0 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Drusilla","GLOBAL",2)
SetAnimState("Ignus",ANIM_MIMESPELL2)
SetAnimState(Myself,ANIM_MIMEDIE)
DestroySelf()~
END

ALTER_TRANS DSTALEMA BEGIN 11 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Speak_With_Dead","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
ApplySpell(Protagonist,SPECIAL_ADD_STORIES_BONES_TELL)
GiveExperience(Protagonist,3750)~
END

ALTER_TRANS DSYBIL BEGIN 13 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Tenement_Alarm","GLOBAL",1)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

// ignore dtest

ALTER_TRANS DTHORNCO BEGIN 30 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Thorncombe","GLOBAL",5)
FadeToColor([20.0],0)
Wait(2)
FadeFromColor([20.0],0)~
END

ALTER_TRANS DTIRES BEGIN 11 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Tenement_Alarm","GLOBAL",1)
Enemy()
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DVAXIS BEGIN 65 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Vaxis_Zombie_XP","GLOBAL",1)
FadeToColor([20.0],0)
Wait(1)
SetNamelessDisguise(ZOMBIE)
Wait(2)
FadeFromColor([20.0],0)
AddexperienceParty(500)~
END

ALTER_TRANS DVHAIL BEGIN 11 END BEGIN 0 END BEGIN ACTION
~LeaveParty()
Enemy()
ChangeAIScript("MDKTNO",DEFAULT)
SetGlobal("Vhailor_Kill_Nameless","GLOBAL",1)
Attack(Protagonist)
ForceAttack(Protagonist,Myself)~
END

ALTER_TRANS DVHAIL BEGIN 11 END BEGIN 1 END BEGIN ACTION
~LeaveParty()
Enemy()
ChangeAIScript("MDKTNO",DEFAULT)
SetGlobal("Vhailor_Kill_Nameless","GLOBAL",1)
Attack(Protagonist)~
END

ALTER_TRANS DVHAIL BEGIN 20 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Memory_Vhailor","GLOBAL",1)
GiveExperience(Protagonist,60000)
SetAnimState("Vhail",ANIM_MIMESTAND)~
END

ALTER_TRANS DVHAIL BEGIN 66 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Vhailor_Teach","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
PermanentStatChange(Protagonist,STR,RAISE,1)
PermanentStatChange(Protagonist,DAMAGEBONUS,RAISE,1)
GiveExperience(Protagonist,90000)
SetAnimState("Vhail",ANIM_MIMESTAND)~
END

ALTER_TRANS DVHAIL BEGIN 66 END BEGIN 1 END BEGIN ACTION
~SetGlobal("Vhailor_Teach","GLOBAL",2)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
PermanentStatChange(Protagonist,STR,RAISE,2)
PermanentStatChange(Protagonist,DAMAGEBONUS,RAISE,2)
GiveExperience(Protagonist,120000)
SetAnimState("Vhail",ANIM_MIMESTAND)~
END

ALTER_TRANS DVHAIL BEGIN 66 END BEGIN 2 END BEGIN ACTION
~SetGlobal("Vhailor_Teach","GLOBAL",3)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
PermanentStatChange(Protagonist,STR,RAISE,3)
PermanentStatChange(Protagonist,DAMAGEBONUS,RAISE,3)
GiveExperience(Protagonist,150000)
SetAnimState("Vhail",ANIM_MIMESTAND)~
END

ALTER_TRANS DVHAIL BEGIN 137 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Memory_Caging_Vhailor","GLOBAL",1)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
SetAnimState("Vhail",ANIM_MIMESTAND)
GiveExperience(Protagonist,90000)~
END

ALTER_TRANS DZM985 BEGIN 3 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Topple_985","GLOBAL",1)
PlaySoundNotRanged("SPE_11")
CreateItem("Limb985",1,0,0)
SetAnimState(Myself,ANIM_MIMEDIE)
Kill(Myself)
Deactivate(Myself)~
END

ALTER_TRANS DZM985 BEGIN 3 END BEGIN 0 END BEGIN ACTION
~SetGlobal("Topple_985","GLOBAL",1)
PlaySoundNotRanged("SPE_11")
CreateItem("Limb985",1,0,0)
SetAnimState(Myself,ANIM_MIMEDIE)
Kill(Myself)
Deactivate(Myself)~
END

ALTER_TRANS FINNOTE BEGIN 0 END BEGIN 0 END BEGIN ACTION
~SetGlobal("P_Journal","GLOBAL",4)
FadeToColor([20.0],0)
Wait(3)
FadeFromColor([20.0],0)
PlaySoundNotRanged("SPTR_01")~
END
