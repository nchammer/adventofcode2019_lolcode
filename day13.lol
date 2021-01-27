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

 I HAS A stateKey ITZ "state"
 I HAS A cheaterMode ITZ 1   BTW if set to 1, auto-input to track ball x location
 I HAS A ballXLocationKey ITZ "ballLoc"
 I HAS A paddleXLocationKey ITZ "paddleLoc"

 HOW IZ I inputtinValue YR context
  I IZ displayinScreen YR context'Z SRS screenKey MKAY
  VISIBLE "Input required: "
  I HAS A computerInput
  BOTH SAEM cheaterMode AN 1, O RLY?
   YA RLY
    BTW track ball and move joystick
    I HAS A ballLocation ITZ context'Z SRS ballXLocationKey
    I HAS A paddleLocation ITZ context'Z SRS paddleXLocationKey
    BOTH SAEM ballLocation AN paddleLocation, O RLY?
     YA RLY, computerInput R 0
     MEBBE DIFFRINT ballLocation AN BIGGR OF ballLocation AN paddleLocation, computerInput R -1
     NO WAI, computerInput R 1
    OIC
   NO WAI
    GIMMEH input
    BOTH SAEM "a" AN input, O RLY?
     YA RLY, computerInput R -1
     MEBBE BOTH SAEM "d" AN input, computerInput R 1
     NO WAI, computerInput R 0
    OIC
  OIC
  VISIBLE "Got input: " computerInput
  FOUND YR computerInput
 IF U SAY SO

 HOW IZ I outputtinValue YR value AN YR context
  I HAS A state ITZ context'Z SRS stateKey
  state, WTF?
   OMG "x"
    context'Z SRS "x" R value
    context'Z SRS stateKey R "y"
    GTFO
   OMG "y"
    context'Z SRS "y" R value
    BOTH OF BOTH SAEM context'Z SRS "x" AN -1 AN BOTH SAEM value AN 0, O RLY?
     YA RLY, context'Z SRS stateKey R "currentScore"
     NO WAI, context'Z SRS stateKey R "tileId"
    OIC
    GTFO
   OMG "tileId"
    I HAS A screen ITZ context'Z SRS screenKey
    I HAS A key ITZ I IZ gettinScreenKey YR context'Z SRS "x" AN YR context'Z SRS "y" MKAY
    BTW VISIBLE "Writing " value " to " key
    screen'Z SRS key R value
    BOTH SAEM value AN 2, O RLY?
     YA RLY, context'Z SRS "blockTileCount" R SUM OF context'Z SRS "blockTileCount" AN 1
     MEBBE BOTH SAEM value AN 3, context'Z SRS paddleXLocationKey R context'Z SRS "x"
     MEBBE BOTH SAEM value AN 4, context'Z SRS ballXLocationKey R context'Z SRS "x"
    OIC
    context'Z SRS stateKey R "x"
    GTFO
   OMG "currentScore"
    context'Z SRS "score" R value
    VISIBLE "New score: " value
    context'Z SRS stateKey R "x"
    GTFO
   OMGWTF
    VISIBLE "INVALID STATE: " state
  OIC
 IF U SAY SO

 BTW end intcode computer customization functions
 BTW =========================================================
 BTW day code start

 I HAS A screenKey ITZ "screen"
 I HAS A screenXSize ITZ 35
 I HAS A screenYSize ITZ 21

 HOW IZ I gettinScreenKey YR x AN YR y
  FOUND YR SMOOSH x AN "," AN y MKAY
 IF U SAY SO

 HOW IZ I initializinScreen
  I HAS A screen ITZ A BUKKIT
  IM IN YR yLoop UPPIN YR y TIL BOTH SAEM y AN screenYSize
   IM IN YR xLoop UPPIN YR x TIL BOTH SAEM x AN screenXSize
    I HAS A screenKey ITZ I IZ gettinScreenKey YR x AN YR y MKAY
    screen HAS A SRS screenKey ITZ 0
   IM OUTTA YR xLoop
  IM OUTTA YR yLoop

  FOUND YR screen
 IF U SAY SO

 HOW IZ I displayinScreen YR screen
  IM IN YR yLoop UPPIN YR y TIL BOTH SAEM y AN screenYSize
   I HAS A line ITZ ""
   IM IN YR xLoop UPPIN YR x TIL BOTH SAEM x AN screenXSize
    I HAS A key ITZ I IZ gettinScreenKey YR x AN YR y MKAY
    I HAS A displayChar ITZ "?"
    I HAS A screenValue ITZ screen'Z SRS key
    screenValue, WTF?
     OMG 0, displayChar R " ", GTFO
     OMG 1, displayChar R "@", GTFO
     OMG 2, displayChar R "*", GTFO
     OMG 3, displayChar R "-", GTFO
     OMG 4, displayChar R "o", GTFO
    OIC
    line R SMOOSH line AN displayChar MKAY
   IM OUTTA YR xLoop
   VISIBLE line
  IM OUTTA YR yLoop
 IF U SAY SO

 BTW main program start
 I HAS A input
 BTW VISIBLE "Enter program:"
 BTW GIMMEH input
 input R "1,380,379,385,1008,2109,564931,381,1005,381,12,99,109,2110,1102,0,1,383,1102,1,0,382,21001,382,0,1,21002,383,1,2,21102,1,37,0,1106,0,578,4,382,4,383,204,1,1001,382,1,382,1007,382,35,381,1005,381,22,1001,383,1,383,1007,383,21,381,1005,381,18,1006,385,69,99,104,-1,104,0,4,386,3,384,1007,384,0,381,1005,381,94,107,0,384,381,1005,381,108,1105,1,161,107,1,392,381,1006,381,161,1101,-1,0,384,1106,0,119,1007,392,33,381,1006,381,161,1102,1,1,384,20101,0,392,1,21102,19,1,2,21101,0,0,3,21101,138,0,0,1105,1,549,1,392,384,392,21001,392,0,1,21101,0,19,2,21102,1,3,3,21101,161,0,0,1106,0,549,1101,0,0,384,20001,388,390,1,20101,0,389,2,21101,0,180,0,1105,1,578,1206,1,213,1208,1,2,381,1006,381,205,20001,388,390,1,20102,1,389,2,21101,205,0,0,1105,1,393,1002,390,-1,390,1102,1,1,384,21001,388,0,1,20001,389,391,2,21101,0,228,0,1106,0,578,1206,1,261,1208,1,2,381,1006,381,253,21002,388,1,1,20001,389,391,2,21102,1,253,0,1106,0,393,1002,391,-1,391,1101,1,0,384,1005,384,161,20001,388,390,1,20001,389,391,2,21101,279,0,0,1105,1,578,1206,1,316,1208,1,2,381,1006,381,304,20001,388,390,1,20001,389,391,2,21102,1,304,0,1106,0,393,1002,390,-1,390,1002,391,-1,391,1101,1,0,384,1005,384,161,21002,388,1,1,21001,389,0,2,21102,1,0,3,21101,338,0,0,1106,0,549,1,388,390,388,1,389,391,389,20102,1,388,1,20101,0,389,2,21102,1,4,3,21101,0,365,0,1106,0,549,1007,389,20,381,1005,381,75,104,-1,104,0,104,0,99,0,1,0,0,0,0,0,0,216,15,16,1,1,17,109,3,21202,-2,1,1,21202,-1,1,2,21102,1,0,3,21102,1,414,0,1105,1,549,22102,1,-2,1,21202,-1,1,2,21102,429,1,0,1106,0,601,2102,1,1,435,1,386,0,386,104,-1,104,0,4,386,1001,387,-1,387,1005,387,451,99,109,-3,2106,0,0,109,8,22202,-7,-6,-3,22201,-3,-5,-3,21202,-4,64,-2,2207,-3,-2,381,1005,381,492,21202,-2,-1,-1,22201,-3,-1,-3,2207,-3,-2,381,1006,381,481,21202,-4,8,-2,2207,-3,-2,381,1005,381,518,21202,-2,-1,-1,22201,-3,-1,-3,2207,-3,-2,381,1006,381,507,2207,-3,-4,381,1005,381,540,21202,-4,-1,-1,22201,-3,-1,-3,2207,-3,-4,381,1006,381,529,21201,-3,0,-7,109,-8,2106,0,0,109,4,1202,-2,35,566,201,-3,566,566,101,639,566,566,1201,-1,0,0,204,-3,204,-2,204,-1,109,-4,2106,0,0,109,3,1202,-1,35,594,201,-2,594,594,101,639,594,594,20102,1,0,-2,109,-3,2106,0,0,109,3,22102,21,-2,1,22201,1,-1,1,21102,373,1,2,21102,96,1,3,21101,735,0,4,21102,630,1,0,1106,0,456,21201,1,1374,-2,109,-3,2106,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,2,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,0,0,2,0,2,2,0,0,0,2,2,0,1,1,0,0,2,2,0,0,2,2,2,2,0,2,2,2,2,0,2,0,2,2,2,2,2,0,0,2,0,0,2,2,0,0,0,1,1,0,2,0,2,2,2,0,0,0,2,2,2,2,2,2,0,0,0,0,0,2,0,2,2,0,2,2,0,2,2,0,0,0,1,1,0,0,2,0,2,2,2,2,2,2,0,2,0,2,2,0,2,0,0,0,0,2,2,0,2,2,0,2,2,0,0,2,0,1,1,0,0,2,0,2,2,0,0,0,0,2,2,2,2,0,2,0,0,0,2,0,2,2,0,2,0,2,2,0,0,2,2,0,1,1,0,2,2,0,2,2,2,0,0,2,0,2,0,2,2,0,2,2,0,2,0,2,2,0,2,0,0,2,0,2,2,2,0,1,1,0,2,2,0,2,0,0,0,0,0,0,2,2,2,0,0,2,2,2,2,0,2,2,0,0,0,0,2,0,0,0,2,0,1,1,0,2,0,0,0,2,2,2,0,0,0,0,0,2,2,0,2,0,2,0,0,2,2,2,2,0,2,2,0,0,0,0,0,1,1,0,0,2,0,2,2,0,2,2,2,0,0,0,0,0,0,0,0,2,2,0,2,2,0,2,0,2,0,0,2,2,0,0,1,1,0,0,0,0,2,2,0,2,2,0,2,0,2,0,0,0,2,0,2,2,0,0,2,0,2,2,2,0,2,2,2,2,0,1,1,0,2,0,2,0,2,2,2,0,2,0,0,2,0,0,2,0,2,0,2,0,2,2,2,0,0,2,0,0,0,0,2,0,1,1,0,0,0,2,0,2,0,0,2,0,2,2,2,0,2,0,2,0,2,0,0,0,0,2,2,2,0,2,0,0,0,0,0,1,1,0,0,2,2,0,2,0,0,0,2,2,2,0,0,2,2,2,2,2,0,2,0,2,2,2,0,2,2,0,0,2,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,47,10,65,41,19,85,49,30,6,77,1,64,75,29,81,69,6,16,97,47,19,46,54,91,41,16,16,52,35,72,84,60,84,52,54,43,5,24,10,87,18,10,53,41,77,61,12,40,71,1,6,16,35,59,37,74,32,11,59,58,19,11,35,62,36,48,48,39,56,5,56,60,34,92,84,21,63,37,95,34,29,67,30,63,12,62,69,59,3,53,82,87,21,90,85,19,21,58,97,55,46,78,44,82,67,37,52,47,22,62,43,71,28,84,8,38,38,95,57,51,20,96,47,10,23,56,6,68,40,48,52,54,23,70,77,97,78,87,41,62,33,2,96,56,32,65,71,9,60,69,39,60,51,95,59,44,19,33,52,1,54,9,42,46,53,30,17,48,90,79,69,38,74,46,72,39,64,59,29,36,40,13,81,5,27,98,46,26,3,48,75,90,40,52,26,47,61,7,16,2,27,10,78,98,76,30,95,60,64,5,95,94,74,79,7,51,11,84,10,89,78,35,84,2,65,74,95,26,61,27,5,13,70,65,92,32,58,53,32,1,9,15,61,29,16,72,46,60,37,66,55,86,47,72,57,21,23,30,5,85,12,22,79,98,28,87,94,10,15,82,40,9,27,40,79,53,47,33,61,54,10,42,75,22,27,51,96,68,16,98,3,56,12,81,18,61,86,33,96,26,63,87,74,34,23,22,12,55,26,62,87,7,23,14,26,63,71,98,50,59,67,34,78,78,63,34,57,5,17,29,23,27,27,17,8,61,89,81,19,9,36,70,28,25,31,20,41,41,21,30,69,97,7,38,97,96,60,90,41,63,64,74,81,43,71,65,47,37,76,37,6,13,17,82,49,55,67,7,87,69,58,63,30,75,54,41,6,78,68,37,49,29,12,77,85,96,17,36,60,19,18,19,74,61,76,83,70,11,5,66,72,4,32,6,45,38,43,22,32,17,84,2,24,36,54,7,77,14,53,57,96,46,5,14,3,90,12,95,10,13,65,78,19,29,54,91,57,24,51,69,94,59,87,46,47,10,51,51,89,31,78,21,65,48,5,52,62,88,18,20,56,89,4,23,87,52,83,8,68,15,3,80,21,56,75,45,83,24,12,30,45,52,71,4,32,33,48,8,44,13,76,61,57,58,83,97,54,5,17,64,13,27,69,91,47,37,70,4,78,85,43,82,30,76,21,11,48,85,14,79,1,96,68,46,64,39,59,37,69,53,30,49,36,48,14,37,97,41,44,90,10,62,53,62,88,75,33,31,33,96,96,82,37,59,17,88,69,41,40,19,23,53,27,3,3,92,79,82,97,57,16,23,75,44,46,7,61,22,45,28,3,30,23,2,41,8,17,27,41,72,88,48,2,14,53,49,3,85,31,23,11,87,18,15,69,10,26,74,19,1,39,98,44,60,73,72,61,62,60,84,14,55,93,65,49,85,75,88,54,35,95,91,15,5,24,45,97,12,4,46,8,74,60,70,2,3,8,68,57,28,14,11,75,7,57,42,6,68,13,35,63,10,70,53,42,50,46,34,89,29,19,83,53,51,55,63,62,82,97,28,78,87,57,13,20,61,98,19,53,43,71,20,73,6,91,81,73,57,83,50,75,67,18,95,66,58,7,14,39,54,53,35,85,38,51,91,35,55,82,47,69,32,60,88,46,564931"

 I HAS A context ITZ A BUKKIT
 context HAS A SRS screenKey ITZ I IZ initializinScreen MKAY
 context HAS A SRS stateKey ITZ "x"
 context HAS A SRS "x"
 context HAS A SRS "y"
 context HAS A SRS "blockTileCount" ITZ 0
 context HAS A SRS "score" ITZ -1
 context HAS A SRS ballXLocationKey ITZ -1
 context HAS A SRS paddleXLocationKey ITZ -1

 BTW part 1
 I HAS A programData ITZ I IZ splitYarnin YR input AN YR "," MKAY
 I IZ paddinProgramData YR programData AN YR 10000 MKAY   BTW hopefully 10000 is enough?
 I IZ runninProgram YR programData AN YR context MKAY

 VISIBLE "Screen after part 1:"
 I IZ displayinScreen YR context'Z SRS screenKey MKAY
 VISIBLE "Block tile count after execution: " context'Z SRS "blockTileCount"

 BTW part 2
 programData R I IZ splitYarnin YR input AN YR "," MKAY
 programData'Z SRS 0 R 2
 I IZ paddinProgramData YR programData AN YR 10000 MKAY   BTW hopefully 10000 is enough?
 I IZ runninProgram YR programData AN YR context MKAY

 VISIBLE "Final score: " context'Z SRS "score"
KTHXBYE
