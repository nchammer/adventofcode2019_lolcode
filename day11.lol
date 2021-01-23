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
  BTW VISIBLE "Input required: "
  BTW GIMMEH input
  input R I IZ inputtinValue YR context MKAY
  input IS NOW A NUMBR
  programData'Z SRS storeLocation R input
  FOUND YR SUM OF currentPosition AN 2
 IF U SAY SO

 HOW IZ I runninOutputCommand YR programData AN YR command AN YR currentPosition AN YR relativeBaseBukkit AN YR context
  I HAS A value ITZ I IZ gettinValueForReadParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key AN YR relativeBaseBukkit MKAY
  BTW VISIBLE value
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

 BTW day code start
 BTW context keys
 I HAS A stateKey ITZ "state"
 I HAS A xLocationKey ITZ "xLoc"
 I HAS A yLocationKey ITZ "yLoc"
 I HAS A directionKey ITZ "dir"
 I HAS A gridKey ITZ "grid"

 BTW grid keys
 I HAS A gridXMaxKey ITZ "xMax"
 I HAS A gridYMaxKey ITZ "yMax"
 I HAS A gridXMinKey ITZ "xMin"
 I HAS A gridYMinKey ITZ "yMin"

 BTW grid entry keys
 I HAS A colorKey ITZ "color"
 I HAS A paintedKey ITZ "painted"

 HOW IZ I initializinGrid YR initialColor
  I HAS A grid ITZ A BUKKIT
  I HAS A entry ITZ A BUKKIT
  entry HAS A SRS colorKey ITZ initialColor
  entry HAS A SRS paintedKey ITZ FAIL
  grid HAS A SRS "0,0" ITZ entry
  grid HAS A SRS gridXMaxKey ITZ 0
  grid HAS A SRS gridXMinKey ITZ 0
  grid HAS A SRS gridYMaxKey ITZ 0
  grid HAS A SRS gridYMinKey ITZ 0
  FOUND YR grid
 IF U SAY SO

 HOW IZ I initializinContext YR initialColor
  I HAS A context ITZ A BUKKIT
  context HAS A SRS gridKey ITZ I IZ initializinGrid YR initialColor MKAY
  context HAS A SRS xLocationKey ITZ 0
  context HAS A SRS yLocationKey ITZ 0
  context HAS A SRS directionKey ITZ 0    BTW up
  context HAS A SRS stateKey ITZ "lookin"
  FOUND YR context
 IF U SAY SO

 HOW IZ I gettinGridKey YR x AN YR y
  FOUND YR SMOOSH x AN "," AN y MKAY
 IF U SAY SO

 HOW IZ I paintinGridLocation YR grid AN YR x AN YR y AN YR color
  I HAS A coordinate ITZ I IZ gettinGridKey YR x AN YR y MKAY
  I HAS A entry ITZ grid'Z SRS coordinate
  entry'Z SRS colorKey R color
  entry'Z SRS paintedKey R WIN
 IF U SAY SO

 HOW IZ I gettinGridLocationColor YR grid AN YR x AN YR y
  BTW VISIBLE "gettinGridLocationColor at (" x "," y ")"
  BTW check if grid needs to be expanded
  BTW if x outside current grid
  EITHER OF DIFFRINT x AN SMALLR OF x AN grid'Z SRS gridXMaxKey AN DIFFRINT x AN BIGGR OF x AN grid'Z SRS gridXMinKey, O RLY?
   YA RLY, I IZ expandinGrid YR grid AN YR "x" AN YR x MKAY
  OIC
  BTW if y outside current grid
  EITHER OF DIFFRINT y AN SMALLR OF y AN grid'Z SRS gridYMaxKey AN DIFFRINT y AN BIGGR OF y AN grid'Z SRS gridYMinKey, O RLY?
   YA RLY, I IZ expandinGrid YR grid AN YR "y" AN YR y MKAY
  OIC

  BTW get grid location value
  I HAS A coordinate ITZ I IZ gettinGridKey YR x AN YR y MKAY
  I HAS A entry ITZ grid'Z SRS coordinate
  FOUND YR entry'Z SRS colorKey
 IF U SAY SO

 HOW IZ I gettinGridLocationPainted YR grid AN YR x AN YR y
  I HAS A coordinate ITZ I IZ gettinGridKey YR x AN YR y MKAY
  I HAS A entry ITZ grid'Z SRS coordinate
  FOUND YR entry'Z SRS paintedKey
 IF U SAY SO

 HOW IZ I expandinGrid YR grid AN YR axis AN YR location
  BOTH SAEM axis AN "x", O RLY?
   YA RLY
    BTW VISIBLE "addin new column at " x
    I HAS A minY ITZ grid'Z SRS gridYMinKey
    I HAS A maxY ITZ grid'Z SRS gridYMaxKey
    I HAS A spacesToPaint ITZ SUM OF 1 AN DIFF OF maxY AN minY
    IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN spacesToPaint
     I HAS A coordinate ITZ I IZ gettinGridKey YR location AN YR SUM OF minY AN idx MKAY
     I HAS A entry ITZ A BUKKIT
     entry HAS A SRS colorKey ITZ 0
     entry HAS A SRS paintedKey ITZ FAIL
     grid HAS A SRS coordinate ITZ entry
    IM OUTTA YR loop

    BTW update max/min
    DIFFRINT location AN BIGGR OF location AN grid'Z SRS gridXMinKey, O RLY?
     YA RLY, grid'Z SRS gridXMinKey R location
     NO WAI, grid'Z SRS gridXMaxKey R location
    OIC
   NO WAI
    BTW VISIBLE "addin new row at " y
    I HAS A minX ITZ grid'Z SRS gridXMinKey
    I HAS A maxX ITZ grid'Z SRS gridXMaxKey
    I HAS A spacesToPaint ITZ SUM OF 1 AN DIFF OF maxX AN minX
    IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN spacesToPaint
     I HAS A coordinate ITZ I IZ gettinGridKey YR SUM OF minX AN idx AN YR location MKAY
     I HAS A entry ITZ A BUKKIT
     entry HAS A SRS colorKey ITZ 0
     entry HAS A SRS paintedKey ITZ FAIL
     grid HAS A SRS coordinate ITZ entry
    IM OUTTA YR loop

    BTW update max/min
    DIFFRINT location AN BIGGR OF location AN grid'Z SRS gridYMinKey, O RLY?
     YA RLY, grid'Z SRS gridYMinKey R location
     NO WAI, grid'Z SRS gridYMaxKey R location
    OIC
  OIC
 IF U SAY SO

 HOW IZ I countinPaintedPanels YR grid
  I HAS A xMin ITZ grid'Z SRS gridXMinKey
  I HAS A xMax ITZ grid'Z SRS gridXMaxKey
  I HAS A yMin ITZ grid'Z SRS gridYMinKey
  I HAS A yMax ITZ grid'Z SRS gridYMaxKey

  I HAS A rows ITZ SUM OF 1 AN DIFF OF yMax AN yMin
  I HAS A columns ITZ SUM OF 1 AN DIFF OF xMax AN xMin

  I HAS A paintedCount ITZ 0

  IM IN YR rowLoop UPPIN YR rowIdx TIL BOTH SAEM rowIdx AN rows
   I HAS A currentRow ITZ DIFF OF yMax AN rowIdx
   IM IN YR columnLoop UPPIN YR columnIdx TIL BOTH SAEM columnIdx AN columns
    I HAS A currentColumn ITZ SUM OF xMin AN columnIdx
    I IZ gettinGridLocationPainted YR grid AN YR currentColumn AN YR currentRow MKAY, O RLY?
     YA RLY, paintedCount R SUM OF paintedCount AN 1
    OIC
   IM OUTTA YR columnLoop
  IM OUTTA YR rowLoop
  FOUND YR paintedCount
 IF U SAY SO

 HOW IZ I printinSituation YR context
  I HAS A grid ITZ context'Z SRS gridKey
  I HAS A xMin ITZ grid'Z SRS gridXMinKey
  I HAS A xMax ITZ grid'Z SRS gridXMaxKey
  I HAS A yMin ITZ grid'Z SRS gridYMinKey
  I HAS A yMax ITZ grid'Z SRS gridYMaxKey

  I HAS A rows ITZ SUM OF 1 AN DIFF OF yMax AN yMin
  I HAS A columns ITZ SUM OF 1 AN DIFF OF xMax AN xMin

  IM IN YR rowLoop UPPIN YR rowIdx TIL BOTH SAEM rowIdx AN rows
   I HAS A currentRow ITZ DIFF OF yMax AN rowIdx
   I HAS A rowYarn ITZ ""
   IM IN YR columnLoop UPPIN YR columnIdx TIL BOTH SAEM columnIdx AN columns
    I HAS A currentColumn ITZ SUM OF xMin AN columnIdx
    I HAS A color ITZ I IZ gettinGridLocationColor YR grid AN YR currentColumn AN YR currentRow MKAY
    I HAS A displayable
    BOTH SAEM color AN 1, O RLY?
     YA RLY, displayable R "#"
     NO WAI, displayable R "."
    OIC
    rowYarn R SMOOSH rowYarn AN displayable MKAY
   IM OUTTA YR columnLoop
   VISIBLE rowYarn
  IM OUTTA YR rowLoop
 IF U SAY SO

 HOW IZ I turninAnDrivin YR context AN YR turnDirection
  I HAS A grid ITZ context'Z SRS gridKey
  I HAS A xLocation ITZ context'Z SRS xLocationKey
  I HAS A yLocation ITZ context'Z SRS yLocationKey
  I HAS A direction ITZ context'Z SRS directionKey

  BTW turn
  BOTH SAEM turnDirection AN 0, O RLY?
   YA RLY
    turnDirection R 3
    BTW VISIBLE "turnin left"
   NO WAI
    BTW VISIBLE "turnin right"
  OIC
  direction R MOD OF SUM OF direction AN turnDirection AN 4
  context'Z SRS directionKey R direction

  BTW drive
  direction, WTF?
   OMG 0    BTW up
    context'Z SRS yLocationKey R SUM OF context'Z SRS yLocationKey AN 1
    GTFO
   OMG 1    BTW right
    context'Z SRS xLocationKey R SUM OF context'Z SRS xLocationKey AN 1
    GTFO
   OMG 2    BTW down
    context'Z SRS yLocationKey R DIFF OF context'Z SRS yLocationKey AN 1
    GTFO
   OMG 3    BTW left
    context'Z SRS xLocationKey R DIFF OF context'Z SRS xLocationKey AN 1
    GTFO
   OMGWTF, VISIBLE "INVALID DIRECTION: " direction
  OIC
 IF U SAY SO

 HOW IZ I inputtinValue YR context
  I HAS A state ITZ context'Z SRS stateKey
  state, WTF?
   OMG "lookin"
    context'Z SRS stateKey R "paintin"
    FOUND YR I IZ gettinGridLocationColor YR context'Z SRS gridKey AN YR context'Z SRS xLocationKey AN YR context'Z SRS yLocationKey MKAY
   OMGWTF, VISIBLE "INVALID STATE FOR INPUT: " state
  OIC
 IF U SAY SO

 HOW IZ I outputtinValue YR value AN YR context
  I HAS A grid ITZ context'Z SRS gridKey
  I HAS A state ITZ context'Z SRS stateKey
  I HAS A xLocation ITZ context'Z SRS xLocationKey
  I HAS A yLocation ITZ context'Z SRS yLocationKey
  I HAS A direction ITZ context'Z SRS directionKey
  state, WTF?
   OMG "paintin"
    I IZ paintinGridLocation YR grid AN YR xLocation AN YR yLocation AN YR value MKAY
    context'Z SRS stateKey R "drivin"
    BTW VISIBLE "painted (" xLocation "," yLocation ") color " value "."
    BTW VISIBLE "Printing situation...", I IZ printinSituation YR context MKAY
    GTFO
   OMG "drivin"
    I IZ turninAnDrivin YR context AN YR value MKAY
    context'Z SRS stateKey R "lookin"
    BTW VISIBLE "drove to (" context'Z SRS xLocationKey "," context'Z SRS yLocationKey ")"
    GTFO
   OMGWTF
    VISIBLE "INVALID STATE FOR OUTPUT: " state
  OIC
 IF U SAY SO

 BTW main program start
 I HAS A input
 VISIBLE "Enter program:"
 GIMMEH input

 BTW part 1
 VISIBLE "Running part 1..."
 I HAS A programData1 ITZ I IZ splitYarnin YR input AN YR "," MKAY
 I IZ paddinProgramData YR programData1 AN YR 10000 MKAY   BTW hopefully 10000 is enough?
 I HAS A context1 ITZ I IZ initializinContext YR 0 MKAY
 I IZ runninProgram YR programData1 AN YR context1 MKAY
 VISIBLE "Part 1 painted:"
 I IZ printinSituation YR context1 MKAY
 VISIBLE "painted panel count: " I IZ countinPaintedPanels YR context1'Z SRS gridKey MKAY

 BTW part 2
 VISIBLE "Running part 2..."
 I HAS A programData2 ITZ I IZ splitYarnin YR input AN YR "," MKAY
 I IZ paddinProgramData YR programData2 AN YR 10000 MKAY   BTW hopefully 10000 is enough?
 I HAS A context2 ITZ I IZ initializinContext YR 1 MKAY
 I IZ runninProgram YR programData2 AN YR context2 MKAY
 VISIBLE "Part 2 painted:"
 I IZ printinSituation YR context2 MKAY
 VISIBLE "painted panel count: " I IZ countinPaintedPanels YR context2'Z SRS gridKey MKAY
KTHXBYE
