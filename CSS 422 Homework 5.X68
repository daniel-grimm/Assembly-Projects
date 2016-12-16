*-----------------------------------------------------------
* Title      : Homework 5 Part A
* Written by : Daniel Grimm
* Date       : November 22nd, 2016
* Description: Homework 5 CSS 422
*-----------------------------------------------------------
*This program fills a block of memory then tests it using
*various values
*----------------------------------------------------------
*Data initializations
*----------------------------------------------------------
pattern1    EQU     $FFFF       *first test pattern
pattern2    EQU     $AAAA       *second test pattern
pattern3    EQU     $0001       *third test pattern
testVal     EQU     $AFAF       *test value
loopVal     EQU     4           *loop counter

memStart    EQU     $00002000   *Starting memory address
memStop     EQU     $0003FFFF   *Ending memory address

max         EQU     65535       *Maximum number of bad datas

stack       EQU     $000A0000   *stack pointer

pgm         EQU     $00001000   *program starts and ends here

*----------------------------------------------------------
            ORG     pgm         *Program starts
            
            LEA     memStart,A0 *A0 points to starting memory address
            LEA     memStop,A1  *A1 points to last memory address
            LEA     stack,SP    *initialize the stack
            MOVE.W  #testVal,D0 *loads the testVal to a register
            MOVE.W  #loopVal-1,D3 *loop counter
            MOVE.W  #max-1,D4   *max number of bad datas
            
loop        MOVE.W  D0,(A0)+    *loads the value and increments the register
            CMPA.W  A1,A0       *is the loop done?
            BLE     loop        *branch to loop if not done
            
            LEA     memStart,A0 *reset the starting memory address
            
jump        CMP.W   A0,D0       *compares the memory to $AFAF
            BNE     badData     *branch to found memory
            CMPA.L  (A0)+,A1    *compares two addresses
            BRA     jump        *loop back to jump if not too large
            
firstTest   LEA     memStart,A0 *reset the starting memory address
            MOVE.W  pattern1,D0 *first test pattern
            MOVE.W  pattern2,D1 *second test pattern
            MOVE.W  pattern3,D2 *third test pattern
test        CMP.W   A0,D0       *compare to $FFFF
            BNE     badData     *branch if not equal to record data
            CMP.W   A0,D1       *compare to $AAAA
            BNE     badData     *branch if not equal to record data
            CMP.W   A0,D2       *compare to a variation of $0001
            BNE     badData     *branch if not equal to record data
            CMPA.L  (A0)+,A1    *too big?
            BRA     test        *not done
            
            ROL.W   #1,D2        *shift the bits in the data register
            DBF     D3,firstTest *branch when done looping
            
badData     ADD.W   A0,SP       *put value in the stack
            RTS                 *increase counter

TERMINATE  STOP    #$2700       *goes back to the simulator
            
            END     $400        *Stop assembling
*----------------------------------------------------------
*END OF PROGRAM - FILE TERMINATED







