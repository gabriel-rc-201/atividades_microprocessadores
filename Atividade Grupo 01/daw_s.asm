#include <p18f4550.inc>

global DAW_S ; exporta para outros arquivos usarem a rotina DAW_S   

    ROTINA CODE
 
; rotina DAW_S: Faz ajuste decimal do registrador W após uma subtração
; Parâmetro de entrada: valor a ser ajustado no registro W
; Parâmetro de saída : valor ajustado no registro W
; Afeta: flags, W e posições de memória 0x00 e 0x01
DAW_S

    movwf 0x00
    andlw 0x0F
    movwf 0x01
    movlw 0x09
    cpfsgt 0x01
    btfss STATUS,DC
    bra l1
    bcf STATUS,DC
l2    
    movlw 0x9F
    cpfsgt 0x00
    btfss STATUS,C
    bra l3
    movf 0x00,W
    bcf STATUS,C
    return
l3    
    movlw 0x60
    subwf 0x00,w
    bsf STATUS,C
    return
l1
    movlw 0x06
    subwf 0x00
    bsf STATUS,DC
    bra l2

END

