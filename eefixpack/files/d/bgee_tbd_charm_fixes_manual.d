/////                                                  \\\\\
///// re-weight to put charm dialogue at top of stack  \\\\\
/////                                                  \\\\\

SET_WEIGHT alyth     6 #-1 
SET_WEIGHT amnis2    4 #-1
SET_WEIGHT amnis4    1 #-1
SET_WEIGHT bandct    8 #-1
SET_WEIGHT bandic    5 #-1
SET_WEIGHT beggba   12 #-1
SET_WEIGHT bentan   13 #-1
SET_WEIGHT boyba2    2 #-1
SET_WEIGHT boyba3    3 #-1
SET_WEIGHT boybe1    2 #-1
SET_WEIGHT boybe2    2 #-1
SET_WEIGHT brevli   30 #-1
SET_WEIGHT dabron    8 #-1
SET_WEIGHT druidc    5 #-1
SET_WEIGHT farm2     3 #-1
SET_WEIGHT farm5     5 #-1
SET_WEIGHT farmbe    6 #-1
SET_WEIGHT fcook2    2 #-1
SET_WEIGHT fcook3    2 #-1
SET_WEIGHT flam2     5 #-1
SET_WEIGHT flam5    15 #-1
SET_WEIGHT flam7     4 #-2 // has two charmed states
SET_WEIGHT flam7     5 #-1
SET_WEIGHT flam8     1 #-1
SET_WEIGHT flam9     5 #-1
SET_WEIGHT friend    6 #-1
SET_WEIGHT friwen    3 #-1
SET_WEIGHT ftowba    5 #-1
SET_WEIGHT ftowbe    7 #-1
SET_WEIGHT ftowfr    6 #-1
SET_WEIGHT ftowna    6 #-1
SET_WEIGHT gantol    8 #-1
SET_WEIGHT girba1    2 #-1
SET_WEIGHT girba2    3 #-1
SET_WEIGHT girba3    4 #-1
SET_WEIGHT greywo    7 #-1
SET_WEIGHT haffg2   10 #-1
SET_WEIGHT halffg    1 #-1
SET_WEIGHT halfg2    9 #-1
SET_WEIGHT halfg3    9 #-1
SET_WEIGHT halfg4    1 #-1
SET_WEIGHT halfg6    1 #-1
SET_WEIGHT hobgo5    6 #-1
SET_WEIGHT housg1    3 #-1
SET_WEIGHT housg4    5 #-1
SET_WEIGHT housg6    5 #-1
SET_WEIGHT iron11    5 #-1
SET_WEIGHT iron12    5 #-1
SET_WEIGHT iron14    8 #-1
SET_WEIGHT iron2     1 #-1
SET_WEIGHT iron3     4 #-1
SET_WEIGHT iron4     1 #-1
SET_WEIGHT iron5     3 #-1
SET_WEIGHT iron6     1 #-1
SET_WEIGHT ironm4   11 #-1
SET_WEIGHT kivanp    2 #99 // reweight post dialogue so you can get his charmed dialogue
SET_WEIGHT mcook2    2 #-1
SET_WEIGHT mcook5    3 #-1
SET_WEIGHT minern    0 #-2 // put ahead of random
SET_WEIGHT minern    1 #-1 // put ahead of random
SET_WEIGHT minern    3 #-3 // charmed
SET_WEIGHT monken    1 #-1
SET_WEIGHT mtbe3     5 #-1
SET_WEIGHT mtbe4     4 #-1
SET_WEIGHT mtbe5     7 #-1
SET_WEIGHT mtbe7     3 #-1
SET_WEIGHT mtbe8     2 #-1
SET_WEIGHT mtbe9     3 #-1
SET_WEIGHT mtob2     5 #-1
SET_WEIGHT mtob3     2 #-1
SET_WEIGHT mtob4     1 #-1
SET_WEIGHT mtob5     4 #-1
SET_WEIGHT mtowf2    8 #-1
SET_WEIGHT nemagreb 10 #-1
SET_WEIGHT nobl10    6 #-1
SET_WEIGHT nobl11    2 #-1
SET_WEIGHT nobl12    2 #-1
SET_WEIGHT nobl14    3 #-1
SET_WEIGHT nobl2     1 #-1
SET_WEIGHT nobl3     1 #-1
SET_WEIGHT nobl5     8 #-1
SET_WEIGHT nobl6     8 #-1
SET_WEIGHT nobl7     6 #-1
SET_WEIGHT nobl8     6 #-1
SET_WEIGHT nobw2     1 #-1
SET_WEIGHT nobw5     2 #-1
SET_WEIGHT nobw6     4 #-1
SET_WEIGHT nobw9     6 #-1
SET_WEIGHT perdue   10 #-1
SET_WEIGHT poghm7    3 #-1
SET_WEIGHT prost3    2 #-1
SET_WEIGHT prost5    4 #-1
SET_WEIGHT prost7    6 #-1
SET_WEIGHT prost8    3 #-1
SET_WEIGHT pumberl  11 #-1
SET_WEIGHT read3     3 #-1
SET_WEIGHT rielta    3 #-1
SET_WEIGHT servan    5 #-1
SET_WEIGHT serwen    3 #-1
SET_WEIGHT sil      10 #-1
SET_WEIGHT smith     1 #-1
SET_WEIGHT tiaxp     2 #99 // reweight post dialogue so you can get his charmed dialogue
SET_WEIGHT trave2    2 #-1
SET_WEIGHT travel    9 #-1
SET_WEIGHT viconi   10 #-1
SET_WEIGHT viconp    2 #99 // reweight post dialogue so you can get his charmed dialogue
SET_WEIGHT xanp      2 #99 // reweight post dialogue so you can get his charmed dialogue
SET_WEIGHT yeslic    6 #-1

/////                                                  \\\\\
///// other fixes                                      \\\\\
/////                                                  \\\\\

// when charmed be'land says to enjoy museum for free, so prevent him from asking for payment later
ADD_TRANS_ACTION beland BEGIN 10 END BEGIN END ~SetGlobal("BelandEntranceFee","GLOBAL",1)~

// brandilar shouldn't set journal entries if quest concluded; branch charm dialogue
EXTEND_BOTTOM brandi 12
  IF ~Global("HelpAldeth","GLOBAL",2)~ THEN EXIT // block journal entry if quest concluded
  IF ~NumTimesTalkedTo(0)~ THEN UNSOLVED_JOURNAL #26824         DO ~SetNumTimesTalkedTo(0)~ EXIT // now add NTTT-preserve branches
  IF ~NumTimesTalkedTo(0) Global("HelpAldeth","GLOBAL",2)~ THEN DO ~SetNumTimesTalkedTo(0)~ EXIT
END

// first instance of delainy/durlyle has a charmed line, but shouldn't (second instance has this)
REPLACE_STATE_TRIGGER delainy1 65 ~~
REPLACE_STATE_TRIGGER durlyle1 65 ~~

// Flaming Fist Enforcer
EXTEND_BOTTOM ffhunt 1
  IF ~NumTimesTalkedTo(0)~ THEN UNSOLVED_JOURNAL #26843        DO ~SetNumTimesTalkedTo(0)~ EXIT
  IF ~NumTimesTalkedTo(0) !Global("Captured","GLOBAL",0)~ THEN DO ~SetNumTimesTalkedTo(0)~ EXIT
END

// charmed state has replies, so do this manually
ADD_TRANS_TRIGGER ftown2 9 ~!NumberOfTimesTalkedTo(0)~ DO 0 1
EXTEND_BOTTOM ftown2 9
  IF ~NumberOfTimesTalkedTo(0) GlobalLT("Chapter","GLOBAL",3)~ THEN REPLY #3331 DO ~SetNumTimesTalkedTo(0)~ GOTO 12
  IF ~NumberOfTimesTalkedTo(0)~                                THEN REPLY #3329 DO ~SetNumTimesTalkedTo(0)~ EXIT
END

// charmed state has replies, so do this manually
EXTEND_BOTTOM harbor 12
  IF ~Global("HelpEltan","GLOBAL",2)~ THEN EXIT
  IF ~NumTimesTalkedTo(0)~ THEN UNSOLVED_JOURNAL #27147        DO ~SetNumTimesTalkedTo(0)~ EXIT
  IF ~NumTimesTalkedTo(0) Global("HelpEltan","GLOBAL",2)~ THEN DO ~SetNumTimesTalkedTo(0)~ EXIT
END

// preserve laurel's special 'i'm leaving' trigger if bypassed via charmed dialogue
EXTEND_BOTTOM laurel 6
  IF ~NumTimesTalkedTo(0)~ THEN DO ~SetNumTimesTalkedTo(0)~ EXIT
  IF ~NumTimesTalkedToGT(10)~ THEN DO ~SetNumTimesTalkedTo(11)~ EXIT
END

// has split charmed replies, so do manually
EXTEND_BOTTOM minern 3
  IF ~NumTimesTalkedTo(0)~ THEN UNSOLVED_JOURNAL #27271        DO ~SetNumTimesTalkedTo(0)~ EXIT
  IF ~NumTimesTalkedTo(0) GlobalGT("CHAPTER","GLOBAL",2)~ THEN DO ~SetNumTimesTalkedTo(0)~ EXIT
  IF ~NumTimesTalkedTo(1)~ THEN UNSOLVED_JOURNAL #27271        DO ~SetNumTimesTalkedTo(1)~ EXIT
  IF ~NumTimesTalkedTo(1) GlobalGT("CHAPTER","GLOBAL",2)~ THEN DO ~SetNumTimesTalkedTo(1)~ EXIT
END

// commoner shouldn't set journal entries if quest concluded; branch charm dialogue
EXTEND_BOTTOM mtbe2 0
  IF ~Global("ACH_THE_WRITTEN","GLOBAL",1)~ THEN EXIT // block journal entry if quest concluded
  IF ~NumTimesTalkedTo(0)~ THEN UNSOLVED_JOURNAL #27279              DO ~SetNumTimesTalkedTo(0)~ EXIT // now add NTTT-preserve branches
  IF ~NumTimesTalkedTo(0) Global("ACH_THE_WRITTEN","GLOBAL",1)~ THEN DO ~SetNumTimesTalkedTo(0)~ EXIT
END

// commoner shouldn't set journal entries if quest concluded; branch charm dialogue
EXTEND_BOTTOM mtbe6 0
  IF ~Global("ACH_THE_WRITTEN","GLOBAL",1)~ THEN EXIT // block journal entry if quest concluded
  IF ~NumTimesTalkedTo(0)~ THEN UNSOLVED_JOURNAL #8058               DO ~SetNumTimesTalkedTo(0)~ EXIT // now add NTTT-preserve branches
  IF ~NumTimesTalkedTo(0) Global("ACH_THE_WRITTEN","GLOBAL",1)~ THEN DO ~SetNumTimesTalkedTo(0)~ EXIT
END

// has nothing to say if 6/13 random number and OublekBounty1 < 1
APPEND mtowna 
  IF ~RandomNum(13,6) !GlobalLT("OublekBounty1","GLOBAL",1)~ THEN BEGIN common1 SAY #324 // dupe the 13,5 line
    IF ~~ THEN EXIT
  END
END
