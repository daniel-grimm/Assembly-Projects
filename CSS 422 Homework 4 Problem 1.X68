*-----------------------------------------------------------
* Title      : Homework 4 Problem 1
* Written by : Daniel Grimm
* Date       : 11/8/2016
* Description: Fills a block of code with a specific Hex value.
*-----------------------------------------------------------
***************************************************************
*Data values
***************************************************************
dataVal     EQU         $5555AAAA   *data to fill memory

startVal    EQU         $0000A000   *starting memory address
endVal      EQU         $0000A2FF   *ending memory address

stack       EQU         $1000       *stack starts here
*-------------------------------------------------------------
*Program Starts
*------------------------------------------------------------
            ORG         $400        *Program starts here

            LEA         stack,SP    *create stack pointer
            LEA         startVal,A0 *A0 tracks current memory
            LEA         endVal,A1   *A1 represents the end address
            
            MOVE.L      #dataVal,D0 *loads the data value into a data register
jump        MOVE.L      D0,(A0)+    *place the data in the memory and increment the counter
            CMPA.L      A1,A0       *checks termination conditions
            BLE         jump        *continues to loop
            
            STOP        #$2700      *simulator return

            END         $400        *End of code
*PROGRAM TERMINATED - END OF FILE

