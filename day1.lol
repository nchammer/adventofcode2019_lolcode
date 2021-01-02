HAI 1.3
	CAN HAS STDIO?
	I HAS A eof, eof R "GOGOGO"

	BTW input functions
	HOW IZ I readLinesUntilGOGOGO
		VISIBLE "Give me the input:"
		I HAS A lines ITZ A BUKKIT
		IM IN YR loop UPPIN YR idx
			I HAS A line ITZ A YARN
			GIMMEH line
			lines HAS A SRS idx ITZ line
			BOTH SAEM line eof, O RLY?
				YA RLY, FOUND YR lines
			OIC
		IM OUTTA YR loop
	IF U SAY SO

	HOW IZ I printLinesUntilGOGOGO YR lines
		IM IN YR loop UPPIN YR idx
			I HAS A line, line R lines'Z SRS idx
			BOTH SAEM line eof, O RLY?
				YA RLY, GTFO
			OIC
			VISIBLE line
		IM OUTTA YR loop
	IF U SAY SO

	
	HOW IZ I part1 YR lines
		I HAS A totalFuel, totalFuel R 0
		IM IN YR loop UPPIN YR idx TIL BOTH SAEM eof lines'Z SRS idx
			I HAS A line, line R lines'Z SRS idx
			line IS NOW A NUMBR
			I HAS A currentFuel ITZ A NUMBR
			currentFuel R QUOSHUNT OF line AN 3
			currentFuel R DIFF OF currentFuel AN 2
			totalFuel R SUM OF totalFuel AN currentFuel
		IM OUTTA YR loop
		VISIBLE "PART 1: TOTAL FUEL:"
		VISIBLE totalFuel
	IF U SAY SO

	HOW IZ I part2 YR lines
                I HAS A totalFuel, totalFuel R 0
                IM IN YR loop UPPIN YR idx TIL BOTH SAEM eof lines'Z SRS idx
                        I HAS A line, line R lines'Z SRS idx
                        line IS NOW A NUMBR
                        I HAS A currentFuel ITZ A NUMBR, currentFuel R line
			IM IN YR componentFuelLoop
                        	currentFuel R QUOSHUNT OF currentFuel AN 3
                        	currentFuel R DIFF OF currentFuel AN 2
				BOTH SAEM 0 AN BIGGR OF 0 AN currentFuel, O RLY?
					YA RLY, GTFO
				OIC
                        	totalFuel R SUM OF totalFuel AN currentFuel
			IM OUTTA YR componentFuelLoop
                IM OUTTA YR loop
                VISIBLE "PART 2: TOTAL FUEL:"
                VISIBLE totalFuel
        IF U SAY SO

	I HAS A lines ITZ A BUKKIT
	lines R I IZ readLinesUntilGOGOGO MKAY
	
	I IZ part1 YR lines MKAY
	I IZ part2 YR lines MKAY
KTHXBYE
