#include <p18f4550.inc>



    ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED


  MAIN_PROG CODE                      ; let linker place main program

extern DAW_S  ; importa DAW_S de outro arquivo (daw_s.asm) 
 
START
    movlw 0x99
    movwf 0x03 ;  inicializa a variável 0x03 com 0x99 (99 em BCD)
    
 loop
    decf 0x03,w ; decrementa em hexadecimal a variável em 0x03 e coloca em w
    rcall DAW_S ; Faz ajuste decimal de w após subtração
    movwf 0x03  ; Coloca w após ajuste decimal em 0x03
    bra loop    ; repete o processo
    GOTO $      ; loop forever

    
    END