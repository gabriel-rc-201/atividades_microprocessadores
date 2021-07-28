; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

variaveis udata_acs 0x20  ;reservando espaço de memória para as variaveis
    N1 RES 2    ;variavel 1 16bits
    N2 RES 2    ;variavel 2 16bits
    RESULTADO RES 2	    ;resultado 16bits

    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START
 
    ;setando os valores nas variaveis
    MOVLW 0xFF	;numero arbtrario da parte menos significativa
    MOVWF N1	;menos significativo da variavel 1
    
    MOVLW 0xFF	;numero arbtrario da parte mais significativa
    MOVWF N1+1	;mais significativo da variavel 1
    
    MOVLW 0xFF	;numero arbtrario da parte menos significativa
    MOVWF N2	;menos significativo da variavel 2
    
    MOVLW 0xFF	;numero arbtrario da parte mais significativa
    MOVWF N2+1	;mais significativo da variavel 2
 
    MOVLW 0x00
    
    NOP			;ultilizado para parar utilizando o debuger
    
    MOVF N1, 0		;move o valor armazenado em N1 para W
    ADDWF N2		;soma N2 e W e armazena em N2
    MOVF N2, 0	    	;move o valor armazenado em N2 para W
    MOVWF RESULTADO	;move o valor armazenado em W para RESULTADO
    
    MOVF N1+1, 0	;move o valor armazenado em N1+1 para W
    ADDWFC N2+1		;soma N2+1 e W e armazena em N2+1
    MOVF N2+1, 0	;move o valor armazenado em N2+1 para W
    MOVWF RESULTADO+1	;move o valor armazenado em W para RESULTADO+1

    NOP
    END