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
  IM IN YR loop UPPIN YR count TIL DIFFRINT endIndex AN BIGGR OF endIndex AN SUM OF count AN startIndex
   subYarn R SMOOSH subYarn AN I IZ STRING'Z AT YR yarn AN YR SUM OF count AN startIndex MKAY MKAY
  IM OUTTA YR loop
  FOUND YR subYarn
 IF U SAY SO

 BTW end of yarn standard library code

 BTW ==============================================================================
 BTW start of actual day's code

 I HAS A resumeFromIndexKey ITZ "resumeFromIndex"

 OBTW
  Runs a program starting with the command specified in the "resumeFromIndex" location in the program data
  Terminates when next command value is a negative number.
  Returns WIN if program is suspended, or FAIL if program is complete.
  Uses program code from programIndex location in programDataArray
 TLDR
 HOW IZ I runninProgram YR programDataArray AN YR programIndex AN YR inputDataArray AN YR phaseSetting AN YR readPhaseSetting
  I HAS A programData ITZ programDataArray'Z SRS programIndex
  I HAS A currentPosition ITZ programData'Z SRS resumeFromIndexKey
  I HAS A readPhaseSettingArray ITZ A BUKKIT
  readPhaseSettingArray HAS A SRS 0 ITZ readPhaseSetting
  IM IN YR loop UPPIN YR instructionCount TIL DIFFRINT 0 AN SMALLR OF 0 AN currentPosition BTW terminate when currentPosition < 0
   currentPosition R I IZ runninCommand YR programData AN YR currentPosition AN YR inputDataArray AN YR programIndex AN YR phaseSetting AN YR readPhaseSettingArray MKAY
  IM OUTTA YR loop
  FOUND YR BOTH SAEM currentPosition AN -10
 IF U SAY SO

 OBTW
  Runs a single command.
  Returns the position of the next command to run, or a negative number if no next command

  Each command takes programData, current parsed command bukkit structure, and current position in program data as input.
  Each command is expected to return the position of the next command to be executed; negative position terminates the program.
 TLDR
 HOW IZ I runninCommand YR programData AN YR currentPosition AN YR inputDataArray AN YR ampNumber AN YR phaseSetting AN YR readPhaseSettingArray
  I HAS A command ITZ I IZ parsinCommand YR programData'Z SRS currentPosition MKAY
  I HAS A opcode ITZ command'Z SRS opcodeKey
  opcode, WTF?
   OMG 1
   OMG 2
    FOUND YR I IZ runninMathCommand YR programData AN YR command AN YR currentPosition MKAY
   OMG 3
    I HAS A inputData
    readPhaseSettingArray'Z SRS 0, O RLY?
     YA RLY
      inputData R phaseSetting
      readPhaseSettingArray'Z SRS 0 R FAIL   BTW only read phase setting at most once
     NO WAI
      inputData R inputDataArray'Z SRS ampNumber
    OIC
    FOUND YR I IZ runninInputCommand YR programData AN YR command AN YR currentPosition AN YR inputData MKAY
   OMG 4
    I HAS A nextLocation ITZ I IZ runninOutputCommand YR programData AN YR command AN YR currentPosition AN YR inputDataArray AN YR ampNumber MKAY
    programData'Z SRS resumeFromIndexKey R nextLocation
    FOUND YR -10    BTW suspended
   OMG 5
   OMG 6
    FOUND YR I IZ runninJumpCommand YR programData AN YR command AN YR currentPosition MKAY
   OMG 7
   OMG 8
    FOUND YR I IZ runninComparisonCommand YR programData AN YR command AN YR currentPosition MKAY
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
  Contains the opcode and param modes for params 1 and 2, if applicable, all represented as NUMBRs.
 TLDR
 I HAS A opcodeKey ITZ "opc"
 I HAS A paramMode1Key ITZ "pm1"
 I HAS A paramMode2Key ITZ "pm2"
 HOW IZ I parsinCommand YR commandYarn
  commandYarn IS NOW A YARN   BTW ensure correct type
  I HAS A command ITZ A BUKKIT
  I HAS A opcode ITZ I IZ gettinOpcode YR commandYarn MKAY
  command HAS A SRS opcodeKey ITZ opcode

  I HAS A paramMode1 ITZ 0
  I HAS A paramMode2 ITZ 0
  I HAS A commandLength ITZ I IZ STRING'Z LEN YR commandYarn MKAY
  BOTH SAEM 3 AN SMALLR OF 3 AN commandLength, O RLY?  BTW commandLength >= 3
   YA RLY, paramMode1 R I IZ STRING'Z AT YR commandYarn AN YR DIFF OF commandLength AN 3 MKAY
  OIC
  BOTH SAEM 4 AN SMALLR OF 4 AN commandLength, O RLY?  BTW commandLength >= 4
   YA RLY, paramMode2 R I IZ STRING'Z AT YR commandYarn AN YR DIFF OF commandLength AN 4 MKAY
  OIC
  BTW VISIBLE "parsed command " commandYarn " to opcode: " opcode ", paramMode1: " paramMode1 ", paramMode2: " paramMode2
  command HAS A SRS paramMode1Key ITZ MAEK paramMode1 A NUMBR
  command HAS A SRS paramMode2Key ITZ MAEK paramMode2 A NUMBR

  FOUND YR command
 IF U SAY SO

 OBTW
  Runs addition or multiplication command
  Returns the position of the next command to run
 TLDR
 HOW IZ I runninMathCommand YR programData AN YR command AN YR currentPosition
  I HAS A opcode ITZ command'Z SRS opcodeKey
  I HAS A input1 ITZ I IZ gettinValueForParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key MKAY
  I HAS A input2 ITZ I IZ gettinValueForParam YR programData AN YR currentPosition AN YR 2 AN YR command'Z SRS paramMode2Key MKAY
  I HAS A outputLocation ITZ I IZ gettinArg YR programData AN YR currentPosition AN YR 3 MKAY    BTW output is always in position mode

  I HAS A output
  opcode, WTF?
   OMG 1, output R SUM OF input1 AN input2, GTFO
   OMG 2, output R PRODUKT OF input1 AN input2, GTFO
  OIC
  programData'Z SRS outputLocation R output
  FOUND YR SUM OF currentPosition AN 4
 IF U SAY SO

 HOW IZ I runninInputCommand YR programData AN YR command AN YR currentPosition AN YR inputData
  I HAS A storeLocation ITZ I IZ gettinArg YR programData AN YR currentPosition AN YR 1 MKAY
  BTW VISIBLE "Using as input: " inputData
  inputData IS NOW A NUMBR
  programData'Z SRS storeLocation R inputData
  FOUND YR SUM OF currentPosition AN 2
 IF U SAY SO

 HOW IZ I runninOutputCommand YR programData AN YR command AN YR currentPosition AN YR inputDataArray AN YR ampNumber
  I HAS A value ITZ I IZ gettinValueForParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key MKAY
  BTW VISIBLE "outputting: " value
  I HAS A outputIdx ITZ MOD OF SUM OF ampNumber AN 1 AN 5
  BTW VISIBLE "output index: " outputIdx
  inputDataArray'Z SRS outputIdx R value
  FOUND YR SUM OF currentPosition AN 2
 IF U SAY SO

 HOW IZ I runninJumpCommand YR programData AN YR command AN YR currentPosition
  I HAS A param1TriggerValue
  command'Z SRS opcodeKey, WTF?
   OMG 5, param1TriggerValue R WIN, GTFO
   OMG 6, param1TriggerValue R FAIL, GTFO
  OIC

  I HAS A param1Value ITZ I IZ gettinValueForParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key MKAY
  param1Value IS NOW A TROOF
  BOTH SAEM param1Value AN param1TriggerValue, O RLY?
   YA RLY
    FOUND YR I IZ gettinValueForParam YR programData AN YR currentPosition AN YR 2 AN YR command'Z SRS paramMode2Key MKAY
   NO WAI
    BTW do nothing, increment instruction pointer
    FOUND YR SUM OF currentPosition AN 3
  OIC
 IF U SAY SO

 HOW IZ I runninComparisonCommand YR programData AN YR command AN YR currentPosition
  I HAS A outputLocation ITZ I IZ gettinArg YR programData AN YR currentPosition AN YR 3 MKAY
  I HAS A input1 ITZ I IZ gettinValueForParam YR programData AN YR currentPosition AN YR 1 AN YR command'Z SRS paramMode1Key MKAY
  I HAS A input2 ITZ I IZ gettinValueForParam YR programData AN YR currentPosition AN YR 2 AN YR command'Z SRS paramMode2Key MKAY
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

 OBTW
  Get the argument at position argNum in the programData
  Just gets the value in the program data, doesn't handle parameter mode
  Output is a NUMBR
 TLDR
 HOW IZ I gettinArg YR programData AN YR currentPosition AN YR argNum
  FOUND YR MAEK programData'Z SRS SUM OF currentPosition AN argNum A NUMBR
 IF U SAY SO

 OBTW
  Gets the value to use for a given param, given the param's position in the command
  and the paramMode.
  Output is a NUMBR
 TLDR
 HOW IZ I gettinValueForParam YR programData AN YR currentPosition AN YR paramNumber AN YR paramMode
  I HAS A paramProvidedValue ITZ I IZ gettinArg YR programData AN YR currentPosition AN YR paramNumber MKAY
  paramMode, WTF?
   OMG 0
    FOUND YR MAEK programData'Z SRS paramProvidedValue A NUMBR
   OMG 1
    FOUND YR paramProvidedValue
   OMGWTF, VISIBLE "invalid param mode " paramMode
  OIC
 IF U SAY SO

 OBTW
  Generate phase settings permutations
  Returns a list of 5 character yarns
  startValue provides the first value (0 or 5),
  and that along with next 4 integers will be used to make the permutations
 TLDR
 HOW IZ I generatinYrPhaseSettingsPermutations YR startValue
  I HAS A phaseSettingsList ITZ A BUKKIT
  phaseSettingsList HAS A SRS lengthKey ITZ 0
  I HAS A options ITZ A BUKKIT
  options HAS A SRS 0 ITZ startValue
  options HAS A SRS 1 ITZ SUM OF startValue AN 1
  options HAS A SRS 2 ITZ SUM OF startValue AN 2
  options HAS A SRS 3 ITZ SUM OF startValue AN 3
  options HAS A SRS 4 ITZ SUM OF startValue AN 4
  options HAS A SRS lengthKey ITZ 5
  I IZ generatinYrPhaseSetting YR "" AN YR options AN YR phaseSettingsList MKAY
  FOUND YR phaseSettingsList
 IF U SAY SO

 OBTW
  Recursive function to generate phase settings
 TLDR
 HOW IZ I generatinYrPhaseSetting YR prefix AN YR options AN YR results
  I HAS A optionsLength ITZ options'Z SRS lengthKey
  BOTH SAEM 1 AN optionsLength, O RLY?
   YA RLY
    I HAS A phaseSetting ITZ SMOOSH prefix AN options'Z SRS 0 MKAY
    I HAS A resultsLength ITZ results'Z SRS lengthKey
    results HAS A SRS resultsLength ITZ phaseSetting
    results'Z SRS lengthKey R SUM OF resultsLength AN 1
    FOUND YR WIN
  OIC
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN optionsLength
   I HAS A currentOption ITZ options'Z SRS idx
   I HAS A newPrefix ITZ SMOOSH prefix AN currentOption MKAY
   I HAS A newOptions ITZ A BUKKIT
   I HAS A newOptionsCount ITZ 0
   IM IN YR newOptionsLoop UPPIN YR optionIdx TIL BOTH SAEM optionIdx AN optionsLength
    DIFFRINT idx AN optionIdx, O RLY?
     YA RLY
      newOptions HAS A SRS newOptionsCount ITZ options'Z SRS optionIdx
      newOptionsCount R SUM OF newOptionsCount AN 1
    OIC
   IM OUTTA YR newOptionsLoop
   newOptions HAS A SRS lengthKey ITZ newOptionsCount
   I IZ generatinYrPhaseSetting YR newPrefix AN YR newOptions AN YR results MKAY
  IM OUTTA YR loop
 IF U SAY SO

 OBTW
  Builds a single input data array
 TLDR
 HOW IZ I buildinInputDataArray
  I HAS A array ITZ A BUKKIT
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN 5
   array HAS A SRS idx ITZ 0
  IM OUTTA YR loop
  FOUND YR array
 IF U SAY SO

 OBTW
  get result for phase setting yarn
 TLDR
 HOW IZ I runninProgramForPhaseSettingYarn YR phaseSettingYarn AN YR programInput
  I HAS A inputDataArray ITZ I IZ buildinInputDataArray MKAY
  I HAS A programDataArray ITZ A BUKKIT
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN 5
   I HAS A programData ITZ I IZ splitYarnin YR programInput AN YR "," MKAY
   programDataArray HAS A SRS idx ITZ programData
   programData HAS A SRS resumeFromIndexKey ITZ 0
   I HAS A phaseSetting ITZ I IZ STRING'Z AT YR phaseSettingYarn AN YR idx MKAY
   I IZ runninProgram YR programDataArray AN YR idx AN YR inputDataArray AN YR phaseSetting AN YR WIN MKAY
  IM OUTTA YR loop
  IM IN YR runUntilCompleteLoop UPPIN YR count   BTW run until completion
   I HAS A ampIndex ITZ MOD OF count AN 5
   BTW VISIBLE "running amp " ampIndex
   I HAS A suspended ITZ I IZ runninProgram YR programDataArray AN YR ampIndex AN YR inputDataArray AN YR 0 AN YR FAIL MKAY
   BOTH OF BOTH SAEM ampIndex AN 4 AN NOT suspended, O RLY?
    YA RLY, GTFO
   OIC
  IM OUTTA YR runUntilCompleteLoop
  FOUND YR inputDataArray'Z SRS 0
 IF U SAY SO

 OBTW
  Run program for each phase setting permutation
 TLDR
 HOW IZ I runninProgramForPhaseSettingsPermutations YR phaseSettingsPermutations AN YR programInput
  I HAS A phaseSettingsCount ITZ phaseSettingsPermutations'Z SRS lengthKey
  I HAS A maxResult ITZ -99999999
  I HAS A phaseSettingYarnForMax ITZ "not found"
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN phaseSettingsCount
   I HAS A phaseSettingYarn ITZ phaseSettingsPermutations'Z SRS idx
   BTW VISIBLE "Trying phase setting yarn: " phaseSettingYarn
   I HAS A result ITZ I IZ runninProgramForPhaseSettingYarn YR phaseSettingYarn AN YR input MKAY
   BTW VISIBLE "Got result " result " for phase setting yarn " phaseSettingYarn
   DIFFRINT result AN SMALLR OF result AN maxResult, O RLY?   BTW result > maxResult
    YA RLY
     maxResult R result
     phaseSettingYarnForMax R phaseSettingYarn
   OIC
  IM OUTTA YR loop

  VISIBLE "max result: " maxResult
  VISIBLE "phase settings for max result: " phaseSettingYarnForMax
 IF U SAY SO

 BTW main program start
 I HAS A input
 VISIBLE "Enter program:"
 GIMMEH input

 VISIBLE "Running program with phase settings 0-4 (part 1)..."
 I HAS A phaseSettingsPermutations1 ITZ I IZ generatinYrPhaseSettingsPermutations YR 0 MKAY
 I IZ runninProgramForPhaseSettingsPermutations YR phaseSettingsPermutations1 AN YR input MKAY

 VISIBLE "Running program with phase settings 5-9 (part 2)..."
 I HAS A phaseSettingsPermutations2 ITZ I IZ generatinYrPhaseSettingsPermutations YR 5 MKAY
 I IZ runninProgramForPhaseSettingsPermutations YR phaseSettingsPermutations2 AN YR input MKAY
KTHXBYE
