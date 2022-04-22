// fork options for alternative ring of invisibility in thieves hood upgrade
ALTER_TRANS botsmith BEGIN 135 END BEGIN 0 END BEGIN TRIGGER ~~ END
ALTER_TRANS botsmith BEGIN 135 END BEGIN 1 END BEGIN TRIGGER ~PartyHasItem("potn20") OR(2) PartyHasItem("ring05") PartyHasItem("bdring05")~ END

// now add new reply that consumes the alternative ring
ADD_TRANS_TRIGGER botsmith 137 ~!PartyHasItem("bdring05")~ DO 1
EXTEND_TOP botsmith 137 #2
  IF ~PartyHasItem("bdring05") PartyGoldGT(9999)~ THEN REPLY #67012 DO ~SetGlobal("ItemMaker","GLOBAL",37)
                                                                        TakePartyGold(10000)
                                                                        TakePartyItemNum("helm29",1)  // Thieves' Hood
                                                                        TakePartyItemNum("bdring05",1)  // Sandthief's Ring
                                                                        TakePartyItemNum("potn20",1)  // Antidote
                                                                        DestroyItem("potn20")  // Antidote
                                                                        DestroyItem("bdring05")  // Sandthief's Ring
                                                                        DestroyItem("helm29")  // Thieves' Hood
                                                                        DestroyGold(10000)~ GOTO 11
END

// fork options for alternative ring of fire resistance in club of detonation upgrade
ALTER_TRANS botsmith BEGIN 60 END BEGIN 0 END BEGIN TRIGGER ~~ END
ALTER_TRANS botsmith BEGIN 60 END BEGIN 1 END BEGIN TRIGGER ~OR(2) PartyHasItem("ring02") PartyHasItem("bdring12")~ END

// now add new reply that consumes the alternative ring
ADD_TRANS_TRIGGER botsmith 62 ~!PartyHasItem("bdring12")~ DO 1
EXTEND_TOP botsmith 62 #2
  IF ~PartyHasItem("bdring12") PartyGoldGT(4999)~ THEN REPLY #66753 DO ~SetGlobal("ItemMaker","GLOBAL",14)
                                                                        TakePartyGold(5000)
                                                                        TakePartyItemNum("blun26",1)  // Club of Detonation +3
                                                                        DestroyItem("blun26")  // Club of Detonation +3
                                                                        TakePartyItemNum("bdring12",1)  // Batalista's Passport
                                                                        DestroyItem("bdring12")  // Batalista's Passport
                                                                        DestroyGold(5000)~ GOTO 11
END