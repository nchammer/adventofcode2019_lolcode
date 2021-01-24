HAI 1.4
 BTW standard math library

 OBTW
  Calculate absolute value of number
 TLDR
 HOW IZ I absoluteValuin YR number
  BOTH SAEM 0 AN SMALLR OF 0 AN number, O RLY?
   YA RLY, FOUND YR number
   NO WAI, FOUND YR DIFF OF 0 AN number
  OIC
 IF U SAY SO

 OBTW
  Calculate greatest common divisor of two numbers
 TLDR
 HOW IZ I findinGreatestCommonDivisor YR num1 AN YR num2
  BTW Euclidean algorithm
  DIFFRINT num1 AN BIGGR OF num1 AN num2, O RLY?    BTW num1 < num2?
   YA RLY
    I HAS A temp ITZ num1
    num1 R num2
    num2 R temp
  OIC
  IM IN YR loop
   I HAS A remainder ITZ MOD OF num1 AN num2
   BOTH SAEM remainder AN 0, O RLY?
    YA RLY, FOUND YR num2
   OIC
   num1 R num2
   num2 R remainder
  IM OUTTA YR loop
 IF U SAY SO

 OBTW
  Calculate least common multiple of two numbers
 TLDR
 HOW IZ I findinLeastCommonMultiple YR num1 AN YR num2
  I HAS A greatestCommonDivisor ITZ I IZ findinGreatestCommonDivisor YR num1 AN YR num2 MKAY
  FOUND YR QUOSHUNT OF PRODUKT OF num1 AN num2 AN greatestCommonDivisor
 IF U SAY SO

 BTW end of standard math library
 BTW ==============================
 BTW start of day code

 I HAS A positionKey ITZ "pos"
 I HAS A velocityKey ITZ "vel"
 I HAS A xKey ITZ 0
 I HAS A yKey ITZ 1
 I HAS A zKey ITZ 2

 I HAS A moonCount ITZ 4
 I HAS A dimensionCount ITZ 3

 OBTW
  Define parameter structure for a single moon, given initial x/y/z position coordinates.
 TLDR
 HOW IZ I initializinMoonParams YR xPos AN YR yPos AN YR zPos
  I HAS A params ITZ A BUKKIT
  I HAS A positionParams ITZ A BUKKIT
  I HAS A velocityParams ITZ A BUKKIT

  positionParams HAS A SRS xKey ITZ xPos
  positionParams HAS A SRS yKey ITZ yPos
  positionParams HAS A SRS zKey ITZ zPos
  params HAS A SRS positionKey ITZ positionParams

  velocityParams HAS A SRS xKey ITZ 0
  velocityParams HAS A SRS yKey ITZ 0
  velocityParams HAS A SRS zKey ITZ 0
  params HAS A SRS velocityKey ITZ velocityParams

  FOUND YR params
 IF U SAY SO

 OBTW
  Define initial parameter structure for all moons.
  Just hard-code the day input data as it's small.
 TLDR
 HOW IZ I initializinAllMoonParams
  I HAS A params ITZ A BUKKIT

  params HAS A SRS 0 ITZ I IZ initializinMoonParams YR -16 AN YR 15 AN YR -9 MKAY
  params HAS A SRS 1 ITZ I IZ initializinMoonParams YR -14 AN YR  5 AN YR  4 MKAY
  params HAS A SRS 2 ITZ I IZ initializinMoonParams YR   2 AN YR  0 AN YR  6 MKAY
  params HAS A SRS 3 ITZ I IZ initializinMoonParams YR  -3 AN YR 18 AN YR  9 MKAY
OBTW test values
  params HAS A SRS 0 ITZ I IZ initializinMoonParams YR -1 AN YR   0 AN YR  2 MKAY
  params HAS A SRS 1 ITZ I IZ initializinMoonParams YR  2 AN YR -10 AN YR -7 MKAY
  params HAS A SRS 2 ITZ I IZ initializinMoonParams YR  4 AN YR  -8 AN YR  8 MKAY
  params HAS A SRS 3 ITZ I IZ initializinMoonParams YR  3 AN YR   5 AN YR -1 MKAY
TLDR
  FOUND YR params
 IF U SAY SO

 HOW IZ I runninTimeSteps YR moonParams AN YR stepCount
  IM IN YR loop UPPIN YR count TIL BOTH SAEM count AN stepCount
   BTW VISIBLE "Ran " count " steps"
   I IZ runninTimeStep YR moonParams MKAY
   BTW VISIBLE "Current state after step:"
   BTW I IZ printinCurrentState YR moonParams MKAY
  IM OUTTA YR loop
 IF U SAY SO

 HOW IZ I runninTimeStep YR moonParams
  IM IN YR dimensionLoop UPPIN YR idx TIL BOTH SAEM idx AN dimensionCount
   I IZ runninTimeStepForDimension YR moonParams AN YR idx MKAY
  IM OUTTA YR dimensionLoop
 IF U SAY SO

 HOW IZ I runninTimeStepForDimension YR moonParams AN YR dimension
  I IZ applyinGravity YR moonParams AN YR dimension MKAY
  I IZ applyinVelocity YR moonParams AN YR dimension MKAY
 IF U SAY SO

 OBTW
  Update each moon's velocity based on their relative positions, for the given dimension
 TLDR
 HOW IZ I applyinGravity YR moonParams AN YR dimension
  IM IN YR baselineMoonLoop UPPIN YR baselineMoonIdx TIL BOTH SAEM baselineMoonIdx AN moonCount
   I HAS A baselineMoonParams ITZ moonParams'Z SRS baselineMoonIdx
   I HAS A baselineMoonPositions ITZ baselineMoonParams'Z SRS positionKey
   I HAS A baselineMoonVelocities ITZ baselineMoonParams'Z SRS velocityKey

   IM IN YR otherMoonLoop UPPIN YR count TIL BOTH SAEM moonCount AN SUM OF 1 AN SUM OF count AN baselineMoonIdx
    I HAS A otherMoonIdx ITZ SUM OF 1 AN SUM OF count AN baselineMoonIdx
    I HAS A otherMoonParams ITZ moonParams'Z SRS otherMoonIdx
    I HAS A otherMoonPositions ITZ otherMoonParams'Z SRS positionKey
    I HAS A otherMoonVelocities ITZ otherMoonParams'Z SRS velocityKey

    I HAS A baselineVelocityChange
    baselineVelocityChange R I IZ gettinVelocityChange YR baselineMoonPositions'Z SRS dimension AN YR otherMoonPositions'Z SRS dimension MKAY
    baselineMoonVelocities'Z SRS dimension R SUM OF baselineMoonVelocities'Z SRS dimension AN baselineVelocityChange
    otherMoonVelocities'Z SRS dimension R DIFF OF otherMoonVelocities'Z SRS dimension AN baselineVelocityChange
   IM OUTTA YR otherMoonLoop
  IM OUTTA YR baselineMoonLoop
 IF U SAY SO

 OBTW
  Gets velocity change of the baseline moon in the current axis,
  based on its current position and another moon's current position.
 TLDR
 HOW IZ I gettinVelocityChange YR baselinePosition AN YR otherPosition
  I HAS A delta ITZ DIFF OF otherPosition AN baselinePosition
  DIFFRINT delta AN SMALLR OF delta AN 0, O RLY?   BTW delta > 0?
   YA RLY, FOUND YR 1
   MEBBE BOTH SAEM delta AN 0, FOUND YR 0
   NO WAI, FOUND YR -1
  OIC
 IF U SAY SO

 OBTW
  Update each moon's position based on its velocity, for the given dimension
 TLDR
 HOW IZ I applyinVelocity YR moonParams AN YR dimension
  IM IN YR moonLoop UPPIN YR idx TIL BOTH SAEM idx AN moonCount
   I HAS A currentMoonParams ITZ moonParams'Z SRS idx
   I HAS A moonPositions ITZ currentMoonParams'Z SRS positionKey
   I HAS A moonVelocities ITZ currentMoonParams'Z SRS velocityKey

   moonPositions'Z SRS dimension R SUM OF moonPositions'Z SRS dimension AN moonVelocities'Z SRS dimension
  IM OUTTA YR moonLoop
 IF U SAY SO

 HOW IZ I calculatinSystemEnergy YR moonParams
  I HAS A totalEnergy ITZ 0
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN moonCount
   I HAS A currentMoonParams ITZ moonParams'Z SRS idx
   I HAS A moonPositions ITZ currentMoonParams'Z SRS positionKey
   I HAS A moonVelocities ITZ currentMoonParams'Z SRS velocityKey

   I HAS A potentialEnergy ITZ SUM OF I IZ absoluteValuin YR moonPositions'Z SRS xKey MKAY AN SUM OF I IZ absoluteValuin YR moonPositions'Z SRS yKey MKAY AN I IZ absoluteValuin YR moonPositions'Z SRS zKey MKAY
   I HAS A kineticEnergy ITZ SUM OF I IZ absoluteValuin YR moonVelocities'Z SRS xKey MKAY AN SUM OF I IZ absoluteValuin YR moonVelocities'Z SRS yKey MKAY AN I IZ absoluteValuin YR moonVelocities'Z SRS zKey MKAY
   totalEnergy R SUM OF totalEnergy AN PRODUKT OF potentialEnergy AN kineticEnergy
  IM OUTTA YR loop
  FOUND YR totalEnergy
 IF U SAY SO

 HOW IZ I printinCurrentState YR moonParams
  IM IN YR loop UPPIN YR idx TIL BOTH SAEM idx AN moonCount
   I HAS A currentMoonParams ITZ moonParams'Z SRS idx
   I HAS A moonPositions ITZ currentMoonParams'Z SRS positionKey
   I HAS A moonVelocities ITZ currentMoonParams'Z SRS velocityKey

   VISIBLE "pos=<x=" moonPositions'Z SRS xKey ", y=" moonPositions'Z SRS yKey ", z=" moonPositions'Z SRS zKey ">, vel=<x=" moonVelocities'Z SRS xKey ", y=" moonVelocities'Z SRS yKey ", z=" moonVelocities'Z SRS zKey ">"
  IM OUTTA YR loop
 IF U SAY SO

 OBTW
  Checks whether or not moon params are the same for a given dimension.
 TLDR
 HOW IZ I checkinMoonParamsSame YR params1 AN YR params2 AN YR dimension
  IM IN YR moonLoop UPPIN YR moonIdx TIL BOTH SAEM moonIdx AN moonCount
   I HAS A moonParams1 ITZ params1'Z SRS moonIdx
   I HAS A moonParams2 ITZ params2'Z SRS moonIdx

   I HAS A moonPositions1 ITZ moonParams1'Z SRS positionKey
   I HAS A moonPositions2 ITZ moonParams2'Z SRS positionKey
   DIFFRINT moonPositions1'Z SRS dimension AN moonPositions2'Z SRS dimension, O RLY?
    YA RLY, FOUND YR FAIL
   OIC

   I HAS A moonVelocities1 ITZ moonParams1'Z SRS velocityKey
   I HAS A moonVelocities2 ITZ moonParams2'Z SRS velocityKey
   DIFFRINT moonVelocities1'Z SRS dimensionIdx AN moonVelocities2'Z SRS dimensionIdx, O RLY?
     YA RLY, FOUND YR FAIL
   OIC
  IM OUTTA YR moonLoop
  FOUND YR WIN     BTW no checks failed, must be same
 IF U SAY SO

 BTW main program start
 BTW part 1
 I HAS A allMoonParams ITZ I IZ initializinAllMoonParams MKAY
 I IZ runninTimeSteps YR allMoonParams AN YR 1000 MKAY
 I HAS A systemEnergy ITZ I IZ calculatinSystemEnergy YR allMoonParams MKAY
 VISIBLE "System energy at completion: " systemEnergy

 BTW part 2
 allMoonParams R I IZ initializinAllMoonParams MKAY
 I HAS A initialMoonParams ITZ I IZ initializinAllMoonParams MKAY

 BTW run each dimension separately until back to initial state, then calculate least common multiple
 BTW of number of time steps required for each dimension
 I HAS A timeStepCounts ITZ A BUKKIT

 IM IN YR dimensionLoop UPPIN YR dimensionIdx TIL BOTH SAEM dimensionIdx AN dimensionCount
  BTW run 1 step so params aren't the same
  I IZ runninTimeStepForDimension YR allMoonParams AN YR dimensionIdx MKAY
  I HAS A stepCount ITZ 1
  IM IN YR loop UPPIN YR count TIL I IZ checkinMoonParamsSame YR allMoonParams AN YR initialMoonParams AN YR dimensionIdx MKAY
   I IZ runninTimeStepForDimension YR allMoonParams AN YR dimensionIdx MKAY
   stepCount R SUM OF stepCount AN 1
  IM OUTTA YR loop
  BTW loop ended, params are back to same as initial
  VISIBLE "Dimension " dimensionIdx " returned to initial conditions in " stepCount " steps."
  timeStepCounts HAS A SRS dimensionIdx ITZ stepCount
 IM OUTTA YR dimensionLoop

 I HAS A tempLcm ITZ I IZ findinLeastCommonMultiple YR timeStepCounts'Z SRS 0 AN YR timeStepCounts'Z SRS 1 MKAY
 I HAS A overallLcm ITZ I IZ findinLeastCommonMultiple YR tempLcm AN YR timeStepCounts'Z SRS 2 MKAY
 VISIBLE "Total steps required to return to initial conditions: " overallLcm
KTHXBYE
