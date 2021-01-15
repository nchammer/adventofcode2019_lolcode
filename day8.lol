HAI 1.4
 CAN HAS STRING?

 BTW my relevant yarn standard library code, lol

 I HAS A lengthKey ITZ "__length__"

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

 BTW =========================================================================

 BTW start of today's code
 I HAS A imageWidth ITZ 25
 I HAS A imageHeight ITZ 6
 I HAS A layerPixelCount ITZ PRODUKT OF imageWidth AN imageHeight

 HOW IZ I parsinRawImageData YR rawImageData
  I HAS A layers ITZ A BUKKIT

  I HAS A rawDataCount ITZ I IZ STRING'Z LEN YR rawImageData MKAY
  I HAS A totalLayerCount ITZ QUOSHUNT OF rawDataCount AN layerPixelCount

  IM IN YR loop UPPIN YR currentLayer TIL BOTH SAEM currentLayer AN totalLayerCount
   I HAS A startIndex ITZ PRODUKT OF currentLayer AN layerPixelCount
   I HAS A endIndex ITZ SUM OF startIndex AN layerPixelCount
   I HAS A currentLayerPixels ITZ I IZ subYarnin YR rawImageData AN YR startIndex AN YR endIndex MKAY
   layers HAS A SRS currentLayer ITZ currentLayerPixels
  IM OUTTA YR loop
  layers HAS A SRS lengthKey ITZ totalLayerCount
  FOUND YR layers
 IF U SAY SO

 HOW IZ I countinLayerPixels YR layerPixels
  I HAS A pixelCounts ITZ A BUKKIT
  pixelCounts HAS A SRS 0 ITZ 0
  pixelCounts HAS A SRS 1 ITZ 0
  pixelCounts HAS A SRS 2 ITZ 0

  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN layerPixelCount
   I HAS A pixel ITZ MAEK I IZ STRING'Z AT YR layerPixels AN YR idx MKAY A NUMBR
   pixelCounts'Z SRS pixel R SUM OF pixelCounts'Z SRS pixel AN 1
  IM OUTTA YR loop
  FOUND YR pixelCounts
 IF U SAY SO

 HOW IZ I makinSameCharYarn YR char AN YR length
  I HAS A yarn ITZ ""
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN length
   yarn R SMOOSH yarn AN char MKAY
  IM OUTTA YR loop
  FOUND YR yarn
 IF U SAY SO

 HOW IZ I renderinImage YR finalPixelData
  BTW render row by row
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN imageHeight
   I HAS A startIndex ITZ PRODUKT OF idx AN imageWidth
   I HAS A endIndex ITZ SUM OF startIndex AN imageWidth
   I HAS A line ITZ I IZ subYarnin YR finalPixelData AN YR startIndex AN YR endIndex MKAY
   VISIBLE line
  IM OUTTA YR loop
 IF U SAY SO

 HOW IZ I part1 YR rawImageData
  I HAS A imageLayerData ITZ I IZ parsinRawImageData YR rawImageData MKAY
  I HAS A fewestZeroesInLayer ITZ 99999999
  I HAS A layerWithFewestZeroes
  I HAS A fewestZeroesLayerPixelCounts
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN imageLayerData'Z SRS lengthKey
   I HAS A layerPixelCounts ITZ I IZ countinLayerPixels YR imageLayerData'Z SRS idx MKAY
   I HAS A zeroCount ITZ layerPixelCounts'Z SRS 0
   DIFFRINT zeroCount AN BIGGR OF zeroCount AN fewestZeroesInLayer, O RLY?    BTW x < y
    YA RLY
     layerWithFewestZeroes R idx
     fewestZeroesInLayer R zeroCount
     fewestZeroesLayerPixelCounts R layerPixelCounts
   OIC
  IM OUTTA YR loop
  I HAS A solution ITZ PRODUKT OF fewestZeroesLayerPixelCounts'Z SRS 1 AN fewestZeroesLayerPixelCounts'Z SRS 2
  VISIBLE "part 1 answer: " solution
 IF U SAY SO

 HOW IZ I part2 YR rawImageData
  I HAS A imageLayerData ITZ I IZ parsinRawImageData YR rawImageData MKAY
  I HAS A outputData ITZ I IZ makinSameCharYarn YR "2" AN YR layerPixelCount MKAY
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN imageLayerData'Z SRS lengthKey
   I HAS A newOutputData ITZ ""
   I HAS A layerPixelYarn ITZ imageLayerData'Z SRS idx
   IM IN YR pixelLoop UPPIN YR pixelIndex TIL BOTH SAEM pixelIndex AN layerPixelCount
    I HAS A existingPixel ITZ I IZ STRING'Z AT YR outputData AN YR pixelIndex MKAY
    BOTH SAEM existingPixel AN "2", O RLY?
     YA RLY
      I HAS A newPixel ITZ I IZ STRING'Z AT YR layerPixelYarn AN YR pixelIndex MKAY
      newPixel, WTF?
       OMG "0", newPixel R " ", GTFO
       OMG "1", newPixel R "X", GTFO
      OIC
      newOutputData R SMOOSH newOutputData AN newPixel MKAY
     NO WAI
      newOutputData R SMOOSH newOutputData AN existingPixel MKAY
    OIC
   IM OUTTA YR pixelLoop
   outputData R newOutputData
  IM OUTTA YR loop
  VISIBLE "part 2 results:"
  I IZ renderinImage YR outputData MKAY
 IF U SAY SO

 BTW start of main program

 I HAS A rawImageData
 VISIBLE "Enter image data: "
 GIMMEH rawImageData

 I IZ part1 YR rawImageData MKAY
 I IZ part2 YR rawImageData MKAY
KTHXBYE
