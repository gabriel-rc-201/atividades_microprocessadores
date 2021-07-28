; PIC18F4550 Configuration Bit Settings

; Assembly source line config statements

    
; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

VARIAVEIS UDATA_ACS 0x20
    NUM RES 1	    ;variavel que eu vou somar os 4 primeros bits com os 4 segundos bits
    LNUM RES 1	    ;armazenar os bits menos significativos de de NUM
    MNUM RES 1	    ;armazenar os bits mais significativos de de NUM
    RESULT RES 1    ;armazena o resultado da soma dos 
    ;4 bits mais significativos com os 4 bits menos significativos
 
; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START
    
    NOP			;ultilizado como ponto de referencia para iniciar o debuger
 
    MOVLW 0xFF		;move 33 em hexadecimal para W
    MOVWF NUM		;salva o valor em NUM
 
    MOVF NUM, 0		;move NUM para o W
    ANDLW 0x0F		;seleciona os bits menos significativos de NUM armazenados em W
    ;zera os bits mais significativos
    MOVWF LNUM		;salva os bits menos significativos de NUM em LNUM
    
    MOVF NUM, 0		;move NUM para o W
    ANDLW 0xF0		;seleciona os bits mais significativos de NUM armazenados em W
    ;zera os bits menos significativos
    MOVWF MNUM		;salva os bits mais significativos de NUM em MNUM
    
    SWAPF MNUM, 1 	;troca as posições dos 4 primeiros bits com os 4 ultimos bits
    ;faz-se isso para realizar a soma com LNUM
    MOVF MNUM, 0	;move MNUM, depois da troca, para W
    
    ADDWF LNUM, 0	;soma W com LNUM e armazena em W
    MOVWF RESULT	;salva os valores de W em RESULT
    
    NOP			;ultilizado como ponto de referencia para parar o debuger
    
    END