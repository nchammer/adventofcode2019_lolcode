HAI 1.3
	CAN HAS STRING?

	OBTW
		Split a string (yarn) into an array with zero-based integer keys.
		Split based on character provided in splitChar.
		This will only work if splitChar is a single character!
	TLDR
	HOW IZ I splitYarn YR yarn AN YR splitChar
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

		BTW need to add last yarn (ie. after last splitter)
		array HAS A SRS arrayLocation ITZ currentYarn
		FOUND YR array
	IF U SAY SO

	OBTW
		Runs a program starting with the first command (location 0).
	TLDR
	HOW IZ I runProgram YR commands
		I HAS A currentPosition ITZ 0
		IM IN YR loop UPPIN YR instructionCount TIL DIFFRINT 0 AN SMALLR OF 0 AN currentPosition	BTW terminate when currentPosition < 0
			currentPosition R I IZ runCommand YR commands AN YR currentPosition MKAY
		IM OUTTA YR loop
	IF U SAY SO

	OBTW
		Runs a single command.
		Returns the position of the next command to run, or a negative number if no next command
	TLDR
	HOW IZ I runCommand YR commands AN YR currentPosition
		I HAS A currentCommand ITZ MAEK commands'Z SRS currentPosition A NUMBR
		currentCommand, WTF?		BTW refactor this to index into bukkit of function pointers if more complex commands introduced later
			OMG 1
			OMG 2
				GTFO	BTW valid, keep going
			OMG 99
				FOUND YR -1
			OMGWTF
				VISIBLE "Invalid command " currentCommand " , stopping"
                                FOUND YR -2
		OIC

		I HAS A input1Location ITZ MAEK commands'Z SRS SUM OF currentPosition AN 1 A NUMBR
		I HAS A input2Location ITZ MAEK commands'Z SRS SUM OF currentPosition AN 2 A NUMBR
		I HAS A outputLocation ITZ MAEK commands'Z SRS SUM OF currentPosition AN 3 A NUMBR

		I HAS A input1 ITZ commands'Z SRS input1Location
		I HAS A input2 ITZ commands'Z SRS input2Location

		I HAS A output
		currentCommand, WTF?
			OMG 1, output R SUM OF input1 AN input2, GTFO
			OMG 2, output R PRODUKT OF input1 AN input2, GTFO
		OIC
		commands'Z SRS outputLocation R output
		FOUND YR SUM OF currentPosition AN 4
	IF U SAY SO
	
	HOW IZ I part1 YR input
		I HAS A commands ITZ I IZ splitYarn YR input AN YR "," MKAY
		commands'Z SRS 1 R 12
		commands'Z SRS 2 R 2
		I IZ runProgram YR commands MKAY
		VISIBLE "Part 1 location 0 after program execution:"
		VISIBLE commands'Z SRS 0
	IF U SAY SO

	HOW IZ I part2 YR input AN YR target
		IM IN YR loop1 UPPIN YR input1 TIL BOTH SAEM input1 AN 100
			IM IN YR loop2 UPPIN YR input2 TIL BOTH SAEM input2 AN 100
				VISIBLE "Part 2: trying " input1  " and " input2
				I HAS A commands ITZ I IZ splitYarn YR input AN YR "," MKAY	BTW don't have a bukkit copy function yet, just do this every iteration for now
				commands'Z SRS 1 R input1
		                commands'Z SRS 2 R input2
                		I IZ runProgram YR commands MKAY
				BOTH SAEM commands'Z SRS 0 AN target, O RLY?
					YA RLY
						VISIBLE "Part 2 solution: " input1 " and " input2
						FOUND YR WIN
                		OIC
			IM OUTTA YR loop2
		IM OUTTA YR loop1
		VISIBLE "Part 2: no solution found!"
        IF U SAY SO


	BTW main program start
	I HAS A input
	VISIBLE "Enter input:"
	GIMMEH input

	I IZ part1 YR input MKAY
	I IZ part2 YR input AN YR 19690720 MKAY
KTHXBYE
