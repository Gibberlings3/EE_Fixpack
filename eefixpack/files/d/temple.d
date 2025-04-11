// making state triggers for oisig and nalla to stop checking alignments and kits
// basically, if they spawn, they're driving the quest
// alignment/kit checks in ar0900.bcs will handle it

// missing state triggers
ADD_STATE_TRIGGER BHOISIG 4 ~InPartySlot(LastTalkedToBy,0)~
ADD_STATE_TRIGGER BHOISIG 5 ~Global("CDWorkingForLathander","GLOBAL",0)~

REPLACE_ACTION_TEXT BHNALLA // set var for working for talos, like we already have for arval and oisig
~SetGlobal("BeholderPlot","GLOBAL",1)~
~SetGlobal("BeholderPlot","GLOBAL",1)
SetGlobal("CDWorkingForTalos","GLOBAL",1)~

/////                                                  \\\\\
///// Stuff for Borinall (thief of the dawn ring)      \\\\\
/////                                                  \\\\\

REPLACE BORINALL

  // replaced so we can keep the response order the same
  IF ~~ THEN BEGIN 8 SAY #37575
     // legit talos
    IF ~Global("CDWorkingForTalos","GLOBAL",1)
        Global("Stripped","GLOBAL",0)~ THEN REPLY #37577 GOTO 9

    // was legit talos, but no longer
    IF ~Global("CDWorkingForTalos","GLOBAL",1)
        !Global("Stripped","GLOBAL",0)~ THEN REPLY #37577 DO ~SetGlobal("TalosStrike","LOCALS",1)~ EXIT

    // pretending to be talos
    IF ~!Global("CDWorkingForTalos","GLOBAL",1)~ THEN REPLY #37577 DO ~SetGlobal("TalosStrike","LOCALS",1)~ EXIT

    // generic copout
    IF ~~ THEN REPLY #37578 GOTO 10

    // angry lathander dude
    IF ~Global("Stripped","GLOBAL",0)
        Kit(PLAYER1,GODLATHANDER)~ THEN REPLY #37579 GOTO 11

    // slightly different response for someone who's only working for lathander
    IF ~OR(2)
          !Global("Stripped","GLOBAL",0)
          !Kit(PLAYER1,GODLATHANDER)~ THEN REPLY #103036 GOTO 11
  END

END
