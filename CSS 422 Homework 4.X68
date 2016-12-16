*-----------------------------------------------------------
* Title      : CSS 422 Homework 4 Problem #2
* Written by : Daniel Grimm
* Date       : 11/8/2016
* Description: Finds a data value in memory and saves it.
*-----------------------------------------------------------

*----------------------------------------------------------
*Data initializations
*----------------------------------------------------------
dataVal     EQU     $ABC5       *Value to be compared
nullVal     EQU     $FFFF       *value not found

memStart    EQU     $000A0000   *Starting memory address
memStop     EQU     $000C0000   *Ending memory address

memLoc      EQU     $4A0        *memory location of result

pgm         EQU     $400

*----------------------------------------------------------
            ORG     pgm        *Program starts
            
            LEA     memStart,A0 *A0 points to current memory address
            LEA     memStop,A1  *A1 points to last memory address
            LEA     memLoc,A2   *A2 points to the memory result
            MOVE.W  #dataVal,D0 *loads the comparable string to a register
            
jump        CMP.W   A0,D0       *compares the memory to $ABC5
            BEQ     found       *branch to found memory
            CMPA.L  (A0)+,A1    *compares two addresses
            BEQ     notFound    *branch to terminate if too large
            BRA     jump        *loop back to jump if not too large

found       MOVEA.L A0,A2       *insert value of memory at $430
            BRA     TERMINATE   *stop running

notFound   MOVE.W  #$FFFF,A2 *places $FFFF into memory if $ABC5 not found
TERMINATE  STOP    #$2700       *goes back to the simulator
            
            END     pgm         *Stop assembling
*----------------------------------------------------------
*END OF PROGRAM - FILE TERMINATED


