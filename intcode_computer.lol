HAI 1.4
 CAN HAS STRING?

 BTW my relevant yarn standard library code, lol

 I HAS A lengthKey ITZ "__length__"

 OBTW
  Split a string (yarn) into an array with zero-based integer keys.
  Split based on character provided in splitChar.
  This will only work if splitChar is a single character!
  Stores output length in location specified by lengthKey variable
 TLDR
 HOW IZ I splitYarnin YR yarn AN YR splitChar
  I HAS A array ITZ A BUKKIT
  I HAS A inputLength ITZ I IZ STRING'Z LEN YR yarn MKAY
  I HAS A arrayLocation ITZ 0
  I HAS A currentYarn ITZ ""
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN inputLength
   I HAS A currentChar ITZ I IZ STRING'Z AT YR yarn AN YR idx MKAY
   BOTH SAEM splitChar AN currentChar, O RLY?
    YA RLY
     BTW found the splitter character, store and increment array location
     array HAS A SRS arrayLocation ITZ currentYarn
     arrayLocation R SUM OF arrayLocation AN 1
     currentYarn R ""
    NO WAI
     BTW non-splitter, concatenate to current yarn
     currentYarn R SMOOSH currentYarn AN currentChar MKAY
   OIC

  IM OUTTA YR loop

  BTW need to add last yarn (ie. after last splitter) and set length
  array HAS A SRS arrayLocation ITZ currentYarn
  array HAS A SRS lengthKey ITZ SUM OF arrayLocation AN 1
  FOUND YR array
 IF U SAY SO

 OBTW
  Get a subyarn from a yarn, given start and one-past-end position.
 TLDR
 HOW IZ I subYarnin YR yarn AN YR startIndex AN YR endIndex
  I HAS A subYarn ITZ ""
  IM IN YR loop UPPIN YR count TIL BOTH SAEM endIndex AN SMALLR OF endIndex AN SUM OF count AN startIndex
   subYarn R SMOOSH subYarn AN I IZ STRING'Z AT YR yarn AN YR SUM OF count AN startIndex MKAY MKAY
  IM OUTTA YR loop
  FOUND YR subYarn
 IF U SAY SO

 BTW end of yarn standard library code

 BTW ==============================================================================
 BTW start of actual day's code

 I HAS A relativeBaseKey ITZ "__relativeBaseKey__"

 HOW IZ I gettinRelativeBase YR relativeBaseBukkit
  BTW VISIBLE "getting relative base: " relativeBaseBukkit'Z SRS relativeBaseKey
  FOUND YR relativeBaseBukkit'Z SRS relativeBaseKey
 IF U SAY SO

 HOW IZ I settinRelativeBase YR relativeBaseBukkit AN YR relativeBase
  BTW VISIBLE "setting relative base to: " relativeBase
  relativeBaseBukkit'Z SRS relativeBaseKey R relativeBase
 IF U SAY SO

 OBTW
  Pad program data out to a specified length
 TLDR
 HOW IZ I paddinProgramData YR programData AN YR length
  I HAS A initialLength ITZ programData'Z SRS lengthKey
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN BIGGR OF idx AN length
   programData HAS A SRS SUM OF initialLength AN idx ITZ 0
  IM OUTTA YR loop
  programData'Z SRS lengthKey R length
 IF U SAY SO

 OBTW
  Runs a program starting with the first command (location 0).
  Terminates when next command value is a negative number.
 TLDR
 HOW IZ I runninProgram YR programData AN YR context
  I HAS A currentPosition ITZ 0
  I HAS A relativeBaseBukkit ITZ A BUKKIT
  relativeBaseBukkit HAS A SRS relativeBaseKey ITZ 0    BTW relative base starts at 0
  IM IN YR loop UPPIN YR instructionCount TIL DIFFRINT 0 AN SMALLR OF 0 AN currentPosition BTW terminate when currentPosition < 0
   currentPosition R I IZ runninCommand YR programData AN YR currentPosition AN YR relativeBaseBukkit AN YR context MKAY
  IM OUTTA YR loop
 IF U SAY SO

 OBTW
  Runs a single command.
  Returns the position of the next command to run, or a negative number if no next command

  Each command takes programData, current parsed command bukkit structure, and current position in program data as input.
  Each command is expected to return the position of the next command to be executed; negative position terminates the program.
 TLDR
 HOW IZ I runninCommand YR programData AN YR currentPosition AN YR relativeBaseBukkit AN YR context
  I HAS A command ITZ I IZ parsinCommand YR programData'Z SRS currentPosition MKAY
  I HAS A opcode ITZ command'Z SRS opcodeKey
  opcode, WTF?
   OMG 1
   OMG 2
    FOUND YR I IZ runninMathCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit MKAY
   OMG 3
    FOUND YR I IZ runninInputCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit AN YR context MKAY
   OMG 4
    FOUND YR I IZ runninOutputCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit AN YR context MKAY
   OMG 5
   OMG 6
    FOUND YR I IZ runninJumpCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit MKAY
   OMG 7
   OMG 8
    FOUND YR I IZ runninComparisonCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit MKAY
   OMG 9
    FOUND YR I IZ runninRelativeBaseChangeCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit MKAY
   OMG 99
    FOUND YR -1
   OMGWTF
    VISIBLE "Invalid opcode " opcode " , stopping"
    FOUND YR -2
  OIC
 IF U SAY SO

 OBTW
  Gets the opcode from a command, as a NUMBR
 TLDR
 HOW IZ I gettinOpcode YR command
  command IS NOW A YARN
  I HAS A length ITZ I IZ STRING'Z LEN YR command MKAY
  length, WTF?
   OMG 1, OMG 2, FOUND YR MAEK command A NUMBR
  OIC

  BTW longer than 2, need to parse
  I HAS A opcode ITZ I IZ subYarnin YR command AN YR DIFF OF length AN 2 AN YR length MKAY

  BTW interpreter has a bug when casting yarns starting with 08 and 09 to NUMBR (related to C octal representation?), work around this
  BOTH SAEM "0" AN I IZ STRING'Z AT YR opcode AN YR 0 MKAY, O RLY?
   YA RLY, opcode R I IZ STRING'Z AT YR opcode AN YR 1 MKAY
  OIC

  FOUND YR MAEK opcode A NUMBR
 IF U SAY SO

 OBTW
  Parse a command yarn into a structure represented by a bukkit.
  Contains the opcode and param modes for params 1-3, if applicable, all represented as NUMBRs.
 TLDR
 I HAS A opcodeKey ITZ "opc"
 I HAS A paramMode1Key ITZ "pm1"
 I HAS A paramMode2Key ITZ "pm2"
 I HAS A paramMode3Key ITZ "pm3"
 HOW IZ I parsinCommand YR commandYarn
  commandYarn IS NOW A YARN   BTW ensure correct type
  I HAS A command ITZ A BUKKIT
  I HAS A opcode ITZ I IZ gettinOpcode YR commandYarn MKAY
  command HAS A SRS opcodeKey ITZ opcode

  I HAS A paramMode1 ITZ 0
  I HAS A paramMode2 ITZ 0
  I HAS A paramMode3 ITZ 0
  I HAS A commandLength ITZ I IZ STRING'Z LEN YR commandYarn MKAY
  BOTH SAEM 3 AN SMALLR OF 3 AN commandLength, O RLY?  BTW commandLength >= 3
   YA RLY, paramMode1 R I IZ STRING'Z AT YR commandYarn AN YR DIFF OF commandLength AN 3 MKAY
  OIC
  BOTH SAEM 4 AN SMALLR OF 4 AN commandLength, O RLY?  BTW commandLength >= 4
   YA RLY, paramMode2 R I IZ STRING'Z AT YR commandYarn AN YR DIFF OF commandLength AN 4 MKAY
  OIC
  BOTH SAEM 5 AN SMALLR OF 5 AN commandLength, O RLY?  BTW commandLength >= 5
   YA RLY, paramMode3 R I IZ STRING'Z AT YR commandYarn AN YR DIFF OF commandLength AN 5 MKAY
  OIC
  BTW VISIBLE "parsed command " commandYarn " to opcode: " opcode ", paramMode1: " paramMode1 ", paramMode2: " paramMode2 ", paramMode3: " paramMode3
  command HAS A SRS paramMode1Key ITZ MAEK paramMode1 A NUMBR
  command HAS A SRS paramMode2Key ITZ MAEK paramMode2 A NUMBR
  command HAS A SRS paramMode3Key ITZ MAEK paramMode3 A NUMBR

  FOUND YR command
 IF U SAY SO

 OBTW
  Runs addition or multiplication command
  Returns the position of the next command to run
 TLDR
 HOW IZ I runninMathCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit
  I HAS A opcode ITZ command'Z SRS opcodeKey
  I HAS A input1 ITZ I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key AN YR relativeBaseBukkit MKAY
  I HAS A input2 ITZ I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 2 AN YR command'Z SRS paramMode2Key AN YR relativeBaseBukkit MKAY
  I HAS A outputLocation ITZ I IZ gettinPositionForWriteParam YR programData AN YR currentPosition AN YR 3 AN YR command'Z SRS paramMode3Key AN YR relativeBaseBukkit MKAY

  I HAS A output
  opcode, WTF?
   OMG 1, output R SUM OF input1 AN input2, GTFO
   OMG 2, output R PRODUKT OF input1 AN input2, GTFO
  OIC
  programData'Z SRS outputLocation R output
  FOUND YR SUM OF currentPosition AN 4
 IF U SAY SO

 HOW IZ I runninInputCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit AN YR context
  I HAS A input
  I HAS A storeLocation ITZ I IZ gettinPositionForWriteParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key AN YR relativeBaseBukkit MKAY
  input R I IZ inputtinValue YR context MKAY
  input IS NOW A NUMBR
  programData'Z SRS storeLocation R input
  FOUND YR SUM OF currentPosition AN 2
 IF U SAY SO

 HOW IZ I runninOutputCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit AN YR context
  I HAS A value ITZ I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key AN YR relativeBaseBukkit MKAY
  I IZ outputtinValue YR value AN YR context MKAY
  FOUND YR SUM OF currentPosition AN 2
 IF U SAY SO

 HOW IZ I runninJumpCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit
  I HAS A param1TriggerValue
  command'Z SRS opcodeKey, WTF?
   OMG 5, param1TriggerValue R WIN, GTFO
   OMG 6, param1TriggerValue R FAIL, GTFO
  OIC

  I HAS A param1Value ITZ I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key AN YR relativeBaseBukkit MKAY
  param1Value IS NOW A TROOF
  BOTH SAEM param1Value AN param1TriggerValue, O RLY?
   YA RLY
    FOUND YR I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 2 AN YR command'Z SRS paramMode2Key AN YR relativeBaseBukkit MKAY
   NO WAI
    BTW do nothing, increment instruction pointer
    FOUND YR SUM OF currentPosition AN 3
  OIC
 IF U SAY SO

 HOW IZ I runninComparisonCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit
  I HAS A outputLocation ITZ I IZ gettinPositionForWriteParam YR programData AN YR currentPosition AN YR 3 AN YR command'Z SRS paramMode3Key AN YR relativeBaseBukkit MKAY
  I HAS A input1 ITZ I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key AN YR relativeBaseBukkit MKAY
  I HAS A input2 ITZ I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 2 AN YR command'Z SRS paramMode2Key AN YR relativeBaseBukkit MKAY
  I HAS A conditionMet

  command'Z SRS opcodeKey, WTF?
    OMG 7, conditionMet R DIFFRINT input1 AN BIGGR OF input1 AN input2, GTFO
    OMG 8, conditionMet R BOTH SAEM input1 AN input2, GTFO
  OIC
  I HAS A outputValue
  conditionMet, O RLY?
   YA RLY, outputValue R 1
   NO WAI, outputValue R 0
  OIC
  programData'Z SRS outputLocation R outputValue
  FOUND YR SUM OF currentPosition AN 4
 IF U SAY SO

 HOW IZ I runninRelativeBaseChangeCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit
  I HAS A input1 ITZ I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key AN YR relativeBaseBukkit MKAY
  I HAS A newRelativeBase ITZ SUM OF I IZ gettinRelativeBase YR relativeBaseBukkit MKAY AN input1
  I IZ settinRelativeBase YR relativeBaseBukkit AN YR newRelativeBase MKAY
  FOUND YR SUM OF currentPosition AN 2
 IF U SAY SO

 OBTW
  Get the argument at position argNum in the programData
  Just gets the value in the program data, doesn't handle parameter mode
  Output is a NUMBR
 TLDR
 HOW IZ I gettinArg YR programData AN YR currentPosition AN YR argNum
  FOUND YR MAEK programData'Z SRS SUM OF currentPosition AN argNum A NUMBR
 IF U SAY SO

 OBTW
  Gets the value to use for a given read param, given the param's position in the command
  and the paramMode.
  Output is a NUMBR
 TLDR
 HOW IZ I gettinValueForReadParam YR programData AN YR currentPosition AN YR paramNumber AN YR paramMode AN YR relativeBaseBukkit
  I HAS A paramProvidedValue ITZ I IZ gettinArg YR programData AN YR currentPosition AN YR paramNumber MKAY
  paramMode, WTF?
   OMG 0
    FOUND YR MAEK programData'Z SRS paramProvidedValue A NUMBR
   OMG 1
    FOUND YR paramProvidedValue
   OMG 2
    I HAS A lookupLocation ITZ SUM OF I IZ gettinRelativeBase YR relativeBaseBukkit MKAY AN paramProvidedValue
    FOUND YR MAEK programData'Z SRS lookupLocation A NUMBR
   OMGWTF, VISIBLE "invalid param mode " paramMode
  OIC
 IF U SAY SO

 OBTW
  Gets the program location to use for a given write param, given the param's position in the command
  and the paramMode.
  Output is a NUMBR
 TLDR
 HOW IZ I gettinPositionForWriteParam YR programData AN YR currentPosition AN YR paramNumber AN YR paramMode AN YR relativeBaseBukkit
  I HAS A paramProvidedValue ITZ I IZ gettinArg YR programData AN YR currentPosition AN YR paramNumber MKAY
  paramMode, WTF?
   OMG 0
    FOUND YR paramProvidedValue
   BTW OMG 1 - invalid for write param
   OMG 2
    I HAS A lookupLocation ITZ SUM OF I IZ gettinRelativeBase YR relativeBaseBukkit MKAY AN paramProvidedValue
    FOUND YR lookupLocation
   OMGWTF, VISIBLE "invalid param mode " paramMode
  OIC
 IF U SAY SO

 BTW end intcode computer
 BTW =========================================================
 BTW start intcode computer customization functions

 HOW IZ I inputtinValue YR context
  VISIBLE "Input required: "
  GIMMEH input
  FOUND YR input
 IF U SAY SO

 HOW IZ I outputtinValue YR value AN YR context
  VISIBLE value
 IF U SAY SO

 BTW end intcode computer customization functions
 BTW =========================================================
 BTW main program start
 I HAS A input
 VISIBLE "Enter program:"
 GIMMEH input

 I HAS A context ITZ A BUKKIT
 I HAS A programData ITZ I IZ splitYarnin YR input AN YR "," MKAY
 I IZ paddinProgramData YR programData AN YR 10000 MKAY   BTW hopefully 10000 is enough?
 I IZ runninProgram YR programData AN YR context MKAY
KTHXBYE
