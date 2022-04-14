// tbd, cam (two issues here, see yoshimo.bcs)
// Yoshimo Should Have Follow-Up Banters with the PC
ADD_TRANS_ACTION byoshim BEGIN 11 END BEGIN END ~SetGlobalTimer("YoshimoTalksPC2","GLOBAL",FIVE_DAYS)~ // add timer to prompt second banter

// tbd, cam
// ranger stronghold fails if you're in Umar Hills when Delon spawn timer expires; see also ar1100.bcs
ADD_TRANS_ACTION delon BEGIN 21 END BEGIN END ~SetGlobal("CDDelonSpoke","GLOBAL",1)~