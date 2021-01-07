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

 BTW end of yarn standard library code

 BTW ==============================================================================
 BTW start of actual day's code

 OBTW
  Check if password meets part 1 criteria.
 TLDR
 HOW IZ I checkinPasswordV1 YR password
  I HAS A foundDoubleDigit ITZ FAIL
  I HAS A previousDigit
  I HAS A currentDigit

  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN I IZ STRING'Z LEN YR password MKAY
   currentDigit R MAEK I IZ STRING'Z AT YR password AN YR idx MKAY A NUMBR

   BTW skip first digit
   DIFFRINT idx AN 0, O RLY?
    YA RLY
     BTW check non-decreasing
     DIFFRINT currentDigit AN BIGGR OF currentDigit AN previousDigit, O RLY?
      YA RLY, FOUND YR FAIL
     OIC
     BOTH SAEM previousDigit AN currentDigit, O RLY?
      YA RLY, foundDoubleDigit R WIN
     OIC
   OIC
   previousDigit R currentDigit
  IM OUTTA YR loop
  FOUND YR foundDoubleDigit
 IF U SAY SO

 OBTW
  Check if password meets part 2 criteria.
 TLDR
 HOW IZ I checkinPasswordV2 YR password
  I HAS A currentDigitSequenceLength ITZ 1
  I HAS A foundDoubleDigit ITZ FAIL
  I HAS A previousDigit
  I HAS A currentDigit

  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN I IZ STRING'Z LEN YR password MKAY
   currentDigit R MAEK I IZ STRING'Z AT YR password AN YR idx MKAY A NUMBR

   BTW skip first digit
   DIFFRINT idx AN 0, O RLY?
    YA RLY
     BTW check non-decreasing
     DIFFRINT currentDigit AN BIGGR OF currentDigit AN previousDigit, O RLY?
      YA RLY, FOUND YR FAIL
     OIC
     BOTH SAEM previousDigit AN currentDigit, O RLY?
      YA RLY, currentDigitSequenceLength R SUM OF currentDigitSequenceLength AN 1
      NO WAI
       BOTH SAEM currentDigitSequenceLength AN 2, O RLY?
        YA RLY, foundDoubleDigit R WIN
       OIC
       currentDigitSequenceLength R 1
     OIC
   OIC
   previousDigit R currentDigit
  IM OUTTA YR loop
  FOUND YR ANY OF foundDoubleDigit AN BOTH SAEM currentDigitSequenceLength AN 2 MKAY
 IF U SAY SO

 HOW IZ I checkinPasswords YR input
  I HAS A splitInput ITZ I IZ splitYarnin YR input AN YR "-" MKAY
  I HAS A start ITZ splitInput'Z SRS 0
  I HAS A end ITZ splitInput'Z SRS 1
  I HAS A current ITZ start
  I HAS A possiblePasswordsV1 ITZ 0
  I HAS A possiblePasswordsV2 ITZ 0

  IM IN YR loop UPPIN YR count TIL BOTH SAEM current AN SUM OF end AN 1
   I IZ checkinPasswordV1 YR current MKAY, O RLY?
    YA RLY, possiblePasswordsV1 R SUM OF possiblePasswordsV1 AN 1
   OIC
   I IZ checkinPasswordV2 YR current MKAY, O RLY?
    YA RLY, possiblePasswordsV2 R SUM OF possiblePasswordsV2 AN 1
   OIC
   current R SUM OF current AN 1

   BTW LOLCODE interpreter is so slow, making sure stuff is happening
   BOTH SAEM MOD OF count AN 10000 AN 0, O RLY?
    YA RLY, VISIBLE "processed " count " passwords"
   OIC
  IM OUTTA YR loop

  VISIBLE "Part 1 possible password count: " possiblePasswordsV1
  VISIBLE "Part 2 possible password count: " possiblePasswordsV2
 IF U SAY SO

 BTW main program start
 I HAS A input
 VISIBLE "Enter input range: "
 GIMMEH input

 I IZ checkinPasswords YR input MKAY
KTHXBYE
