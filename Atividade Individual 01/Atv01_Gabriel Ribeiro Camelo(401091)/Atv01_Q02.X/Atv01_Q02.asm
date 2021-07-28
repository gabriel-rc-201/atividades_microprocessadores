; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

VARIAVEIS UDATA_ACS 0x20
    NUM RES 1	;variavel em q irei contar os bits
    ;tem 8 bits 
    
    CONT RES 1	;variavel para contar o numero de bits 1
    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START
    NOP		    ;ultilizado como ponto de referencia para iniciar o debuger
    
    MOVLW  0x33
    MOVWF NUM	    ;adiciona um numero arbtrario a NUM
    
    BTFSC NUM, 0    ;se o bit zero de NUM for zero pula a proxima instrução
    INCF CONT	    ;se não for zero acrescenta um em CONT
    
    BTFSC NUM, 1    ;se o bit um de NUM for zero pula a proxima instrução
    INCF CONT	    ;se não for zero acrescenta um em CONT
    
    BTFSC NUM, 2    ;se o bit doi de NUM for zero pula a proxima instrução
    INCF CONT	    ;se não for zero acrescenta um em CONT
    
    BTFSC NUM, 3    ;se o bit três de NUM for zero pula a proxima instrução
    INCF CONT	    ;se não for zero acrescenta um em CONT
    
    BTFSC NUM, 4    ;se o bit quatro de NUM for zero pula a proxima instrução
    INCF CONT	    ;se não for zero acrescenta um em CONT
    
    BTFSC NUM, 5    ;se o bit cinco de NUM for zero pula a proxima instrução
    INCF CONT	    ;se não for zero acrescenta um em CONT
    
    BTFSC NUM, 6    ;se o bit seis de NUM for zero pula a proxima instrução
    INCF CONT	    ;se não for zero acrescenta um em CONT
    
    BTFSC NUM, 7    ;se o bit sete de NUM for zero pula a proxima instrução
    INCF CONT	    ;se não for zero acrescenta um em CONT
    
    
    NOP		    ;ultilizado como ponto de referencia para parar o debuger
    
    END