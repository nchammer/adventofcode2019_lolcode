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
 BTW =========================================================================
 BTW start of day's code

 I HAS A maxOre ITZ 1000000000000

 I HAS A chemicalKey ITZ "chem"
 I HAS A quantityKey ITZ "quan"
 I HAS A ingredientsKey ITZ "ings"
 I HAS A productKey ITZ "prod"
 I HAS A necessaryQuantityKey ITZ "neccQuan"
 I HAS A reactionKey ITZ "reac"

 HOW IZ I parsinReactions YR inputLines
  I HAS A reactions ITZ A BUKKIT
  I HAS A reactionsCount ITZ inputLines'Z SRS lengthKey
  reactions HAS A SRS lengthKey ITZ reactionsCount
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN reactionsCount
   reactions HAS A SRS idx ITZ I IZ parsinReaction YR inputLines'Z SRS idx MKAY
  IM OUTTA YR loop
  FOUND YR reactions
 IF U SAY SO

 OBTW
  Parse a reaction from input line
 TLDR
 HOW IZ I parsinReaction YR inputLine
  I HAS A reaction ITZ A BUKKIT
  I HAS A lineParts ITZ I IZ splitYarnin YR inputLine AN YR ">" MKAY
  I HAS A reactionIngredients ITZ I IZ parsinReactionIngredients YR lineParts'Z SRS 0 MKAY
  reaction HAS A SRS ingredientsKey ITZ reactionIngredients
  I HAS A reactionProduct ITZ I IZ parsinIngredient YR lineParts'Z SRS 1 MKAY
  reaction HAS A SRS productKey ITZ reactionProduct
  FOUND YR reaction
 IF U SAY SO

 HOW IZ I parsinReactionIngredients YR input
  I HAS A reactionIngredients ITZ A BUKKIT
  I HAS A ingredientsList ITZ I IZ splitYarnin YR input AN YR "," MKAY
  I HAS A ingredientsCount ITZ ingredientsList'Z SRS lengthKey
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN ingredientsCount
   I HAS A ingredient ITZ I IZ parsinIngredient YR ingredientsList'Z SRS idx MKAY
   reactionIngredients HAS A SRS idx ITZ ingredient
  IM OUTTA YR loop
  reactionIngredients HAS A SRS lengthKey ITZ ingredientsCount
  FOUND YR reactionIngredients
 IF U SAY SO

 HOW IZ I parsinIngredient YR ingredientYarn
  BTW check for leading space
  BOTH SAEM " " AN I IZ STRING'Z AT YR ingredientYarn AN YR 0 MKAY, O RLY?
   YA RLY, ingredientYarn R I IZ subYarnin YR ingredientYarn AN YR 1 AN YR I IZ STRING'Z LEN YR ingredientYarn MKAY MKAY
  OIC
  I HAS A ingredient ITZ A BUKKIT
  I HAS A parts ITZ I IZ splitYarnin YR ingredientYarn AN YR " " MKAY
  ingredient HAS A SRS quantityKey ITZ MAEK parts'Z SRS 0 A NUMBR
  ingredient HAS A SRS chemicalKey ITZ parts'Z SRS 1
  BTW VISIBLE "parsed ingredient: " ingredient'Z SRS quantityKey " " ingredient'Z SRS chemicalKey
  FOUND YR ingredient
 IF U SAY SO

 OBTW
  Build a map of product -> reaction to generate it
 TLDR
 HOW IZ I buildinReactionsMap YR reactions
  I HAS A reactionsMap ITZ A BUKKIT
  I HAS A reactionsCount ITZ reactions'Z SRS lengthKey

  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN reactionsCount
   I HAS A node ITZ A BUKKIT
   I HAS A reaction ITZ reactions'Z SRS idx
   I HAS A reactionProduct ITZ reaction'Z SRS productKey
   I HAS A chemical ITZ reactionProduct'Z SRS chemicalKey
   reactionsMap HAS A SRS chemical ITZ reaction
  IM OUTTA YR loop
  FOUND YR reactionsMap
 IF U SAY SO

 OBTW
  Builds a map of each chemical -> 0 (initially 0 of anything produced)
 TLDR
 HOW IZ I buildinChemicalQuantityMap YR reactions
  I HAS A chemicalMap ITZ A BUKKIT
  I HAS A reactionsCount ITZ reactions'Z SRS lengthKey

  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN reactionsCount
   I HAS A node ITZ A BUKKIT
   I HAS A reaction ITZ reactions'Z SRS idx
   I HAS A reactionProduct ITZ reaction'Z SRS productKey
   I HAS A chemical ITZ reactionProduct'Z SRS chemicalKey
   chemicalMap HAS A SRS chemical ITZ 0
  IM OUTTA YR loop
  chemicalMap HAS A SRS "ORE" ITZ 0
  FOUND YR chemicalMap
 IF U SAY SO

 HOW IZ I consumin YR chemical AN YR quantity AN YR producedMap AN YR possessMap AN YR reactionsMap
  I HAS A possessionQuantity ITZ possessMap'Z SRS chemical
  DIFFRINT possessionQuantity AN BIGGR OF possessionQuantity AN quantity, O RLY?     BTW possess less than want to consume?
   YA RLY, I IZ producin YR chemical AN YR DIFF OF quantity AN possessionQuantity AN YR producedMap AN YR possessMap AN YR reactionsMap MKAY
  OIC
  possessionQuantity R DIFF OF possessMap'Z SRS chemical AN quantity
  DIFFRINT possessionQuantity AN BIGGR OF possessionQuantity AN 0, O RLY?
   YA RLY, VISIBLE "error - possession quantity less than 0: " possessionQuantity " for chemical: " chemical
  OIC
  possessMap'Z SRS chemical R possessionQuantity
 IF U SAY SO

 HOW IZ I producin YR chemical AN YR quantity AN YR producedMap AN YR possessMap AN YR reactionsMap
  BOTH SAEM chemical AN "ORE", O RLY?
   YA RLY
    producedMap'Z SRS "ORE" R SUM OF producedMap'Z SRS "ORE" AN quantity
    DIFFRINT maxOre AN BIGGR OF maxOre AN producedMap'Z SRS "ORE", O RLY?
     YA RLY
      BTW no more fuel can be produced, nuke program
      VISIBLE "out of ore! fuel produced so far: " producedMap'Z SRS "FUEL"
      QUOSHUNT OF 1 AN 0
    OIC
    possessMap'Z SRS "ORE" R SUM OF possessMap'Z SRS "ORE" AN quantity
    GTFO
  OIC

  I HAS A reaction ITZ reactionsMap'Z SRS chemical
  I HAS A ingredients ITZ reaction'Z SRS ingredientsKey
  I HAS A product ITZ reaction'Z SRS productKey
  I HAS A productChemical ITZ product'Z SRS chemicalKey
  I HAS A batchQuantity ITZ product'Z SRS quantityKey
  I HAS A reactions ITZ QUOSHUNT OF quantity AN batchQuantity
  DIFFRINT 0 AN MOD OF quantity AN batchQuantity, O RLY?    BTW check if need one more reaction for partial quantity
   YA RLY, reactions R SUM OF reactions AN 1
  OIC

  BTW consume necessary inputs
  I HAS A ingredientsCount ITZ ingredients'Z SRS lengthKey
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN ingredientsCount
   I HAS A ingredient ITZ ingredients'Z SRS idx
   I HAS A ingredientCountPerReaction ITZ ingredient'Z SRS quantityKey
   I HAS A ingredientQuantityToConsume ITZ PRODUKT OF ingredientCountPerReaction AN reactions
   I IZ consumin YR ingredient'Z SRS chemicalKey AN YR ingredientQuantityToConsume AN YR producedMap AN YR possessMap AN YR reactionsMap MKAY
  IM OUTTA YR loop

  BTW add produced ingredients
  I HAS A producedIngredients ITZ PRODUKT OF reactions AN batchQuantity
  producedMap'Z SRS chemical R SUM OF producedMap'Z SRS chemical AN producedIngredients
  possessMap'Z SRS chemical R SUM OF possessMap'Z SRS chemical AN producedIngredients
 IF U SAY SO

 VISIBLE "Enter reactions:"
 I HAS A inputLines ITZ I IZ readinLinesTilGOGOGO MKAY
 I HAS A reactions ITZ I IZ parsinReactions YR inputLines MKAY
 I HAS A reactionsMap ITZ I IZ buildinReactionsMap YR reactions MKAY
 I HAS A producedMap ITZ I IZ buildinChemicalQuantityMap YR reactions MKAY
 I HAS A possessMap ITZ I IZ buildinChemicalQuantityMap YR reactions MKAY

 I IZ consumin YR "FUEL" AN YR 1 AN YR producedMap AN YR possessMap AN YR reactionsMap MKAY

 I HAS A oreQuantityFor1Fuel ITZ producedMap'Z SRS "ORE"
 VISIBLE "Part 1 ore required: " oreQuantityFor1Fuel

 BTW reset for part 2
 I HAS A producedMap2 ITZ I IZ buildinChemicalQuantityMap YR reactions MKAY
 I HAS A possessMap2 ITZ I IZ buildinChemicalQuantityMap YR reactions MKAY

 IM IN YR loop
  I HAS A oreRemaining ITZ DIFF OF maxOre AN producedMap2'Z SRS "ORE"
  I HAS A minFuelPossible ITZ QUOSHUNT OF oreRemaining AN oreQuantityFor1Fuel
  VISIBLE "Can produce at least " minFuelPossible " more fuel"
  BOTH SAEM minFuelPossible AN 0, O RLY?
   YA RLY, minFuelPossible R 1   BTW keep going until we run out
  OIC
  I IZ consumin YR "FUEL" AN YR minFuelPossible AN YR producedMap2 AN YR possessMap2 AN YR reactionsMap MKAY
 IM OUTTA YR loop

KTHXBYE
