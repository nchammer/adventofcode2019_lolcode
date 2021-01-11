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

 BTW standard io code
 I HAS A eof, eof R "GOGOGO"

 BTW input functions
 HOW IZ I readinLinesTilGOGOGO
  VISIBLE "Give me the input:"
  I HAS A lines ITZ A BUKKIT
  IM IN YR loop UPPIN YR idx
   I HAS A line ITZ A YARN
   GIMMEH line
   BOTH SAEM line AN eof, O RLY?
    YA RLY
     lines HAS A SRS lengthKey ITZ idx
     FOUND YR lines
   OIC
   lines HAS A SRS idx ITZ line
  IM OUTTA YR loop
 IF U SAY SO

 BTW end of standard io code
 BTW ==========================================================
 BTW start of day's code

 OBTW
  Builds an array with the path from a given object to the root object (COM).
  COM will be the last element in the array.
 TLDR
 HOW IZ I gettinObjectPath YR object AN YR orbitzMap
  I HAS A path ITZ A BUKKIT
  I HAS A length ITZ 0
  IM IN YR loop
   path HAS A SRS length ITZ object
   BOTH SAEM object AN "COM", O RLY?
    YA RLY, GTFO
   OIC
   object R orbitzMap'Z SRS object
   length R SUM OF length AN 1
  IM OUTTA YR loop
  path HAS A SRS lengthKey ITZ length
  FOUND YR path
 IF U SAY SO

 I HAS A input ITZ A BUKKIT
 input R I IZ readinLinesTilGOGOGO MKAY
 I HAS A inputCount ITZ input'Z SRS lengthKey

 BTW generate list of objects, and bukkit mapping each object to what it's orbiting
 BTW TODO: generalize this approach into a general purpose hashmap/dict structure?
 I HAS A objectzList ITZ A BUKKIT
 I HAS A orbitzMap ITZ A BUKKIT
 IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN inputCount
  I HAS A orbitRecord ITZ I IZ splitYarnin YR input'Z SRS idx AN YR ")" MKAY
  I HAS A orbited ITZ orbitRecord'Z SRS 0
  I HAS A orbiting ITZ orbitRecord'Z SRS 1

  objectzList HAS A SRS idx ITZ orbiting
  orbitzMap HAS A SRS orbiting ITZ orbited
 IM OUTTA YR loop

 BTW part1: count total orbits
 I HAS A orbitzCount ITZ 0
 IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN inputCount
  I HAS A object ITZ objectzList'Z SRS idx
  I HAS A current ITZ object

  BTW for each object, iterate to root and add 1 for each step
  BTW more efficient to memoize
  BTW but BUKKIT doesn't have an equivalent to a contains/checkKeyPresent method
  BTW it just crashes the entire program if you try to look up a nonexistent key
  BTW same problem I had in day 3, luckily here the inefficeint approach is fast enough
  IM IN YR countinLoop
   BOTH SAEM current AN "COM", O RLY?
    YA RLY, GTFO
   OIC
   current R orbitzMap'Z SRS current
   orbitzCount R SUM OF orbitzCount AN 1
  IM OUTTA YR countinLoop
 IM OUTTA YR loop

 VISIBLE "total orbit count: " orbitzCount

 BTW part2: find orbital transfers for YOU and SAN to be orbiting same object
 I HAS A youPath ITZ I IZ gettinObjectPath YR "YOU" AN YR orbitzMap MKAY
 I HAS A sanPath ITZ I IZ gettinObjectPath YR "SAN" AN YR orbitzMap MKAY

 BTW approach: step through both paths (to YOU and SAN) starting at COM
 BTW when they diverge, we've found the nearest common parent
 BTW then just add the lengths from the nearest common parent to YOU and SAN together
 I HAS A youPathLocation ITZ DIFF OF youPath'Z SRS lengthKey AN 1
 I HAS A sanPathLocation ITZ DIFF OF sanPath'Z SRS lengthKey AN 1
 IM IN YR loop UPPIN YR count TIL EITHER OF BOTH SAEM youPathLocation AN 0 AN BOTH SAEM sanPathLocation AN 0
  DIFFRINT youPath'Z SRS youPathLocation AN sanPath'Z SRS sanPathLocation, O RLY?
   YA RLY, GTFO   BTW found nearest common parent
  OIC
  youPathLocation R DIFF OF youPathLocation AN 1
  sanPathLocation R DIFF OF sanPathLocation AN 1
 IM OUTTA YR loop
 I HAS A requiredTransfers ITZ SUM OF youPathLocation AN sanPathLocation

 VISIBLE "required transfers: " requiredTransfers
KTHXBYE
