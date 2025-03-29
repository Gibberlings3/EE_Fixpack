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
