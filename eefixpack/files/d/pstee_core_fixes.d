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
