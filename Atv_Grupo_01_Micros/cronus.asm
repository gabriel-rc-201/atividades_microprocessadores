
; PIC18F4550 Configuration Bit Settings

; Assembly source line config statements

#include "p18f4550.inc"

; CONFIG1L
  CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
  CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
  CONFIG  USBDIV = 1            ; USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

; CONFIG1H
  CONFIG  FOSC = XT_XT          ; Oscillator Selection bits (XT oscillator (XT))
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOR = ON              ; Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
  CONFIG  BORV = 3              ; Brown-out Reset Voltage bits (Minimum setting 2.05V)
  CONFIG  VREGEN = OFF          ; USB Voltage Regulator Enable bit (USB voltage regulator disabled)

; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = ON          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)
TEMP1 equ 0x02    ; Variável TEMP1 (Atraso)
TEMP2 equ 0x03
var UDATA_ACS 0X20
minutos res 1 
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program

START 
CLRF TRISD;setando como saida todos os D
BSF TRISC, RC0; setando como entrada
BSF TRISC, RC1;	setando como entrada
MOVLW 0x3c ;move o valor pra w 3c = 60
;DAW 
MOVWF minutos;
MOVWF PORTD; imprime nos displays
loop
BTFSC PORTC,RC0; testa se o botao ta mandando 1 se tiver chama soma
CALL soma; linha 102 
BTFSS PORTC,RC1; testa se o botao ta mandando 1 se tiver pula pra contagem
BRA loop 
contagem
DCFSNZ minutos,0; decrementa minutos e manda pro w se for 0 ele vai pro ending
BRA BUZZER;linha 110
;DAW 
MOVWF minutos;
MOVWF PORTD; imprime nos displays
CALL ATRASO_1m 
BRA contagem
;******************************************************************* 
soma
MOVLW 0x0a ;move o valor pra w
ADDWF minutos,0
;DAW 
MOVWF minutos;
MOVWF PORTD; imprime nos displays
RETURN 
;******************************************************************* 
BUZZER
    MOVLW .200 
        MOVWF TEMP2
	    
	L1
	    RCALL ATRASO_1ms
	    RCALL ATRASO_1ms
	    RCALL ATRASO_1ms
	    RCALL ATRASO_1ms
	    RCALL ATRASO_1ms
	    DECFSZ TEMP2
	    BRA L1
	    
	BSF PORTC, 2	;liga o buzzer dps de 1sec, buzzer conectado em RC2
	    MOVLW .250
	    MOVWF TEMP2
	    L2
		RCALL ATRASO_1ms
		DECFSZ TEMP2
		BRA L2
            
	    BCF PORTC, 2
	    
	    BTFSC PORTC, 0
	    GOTO START
	    
	    BTFSC PORTC, 1
	    GOTO START
	    
	    
    BRA BUZZER
;******************************************************************* 
ATRASO_1m    
    CALL ATRASO_1s ;1
    CALL ATRASO_1s ;2
    CALL ATRASO_1s ;3
    CALL ATRASO_1s ;4
    CALL ATRASO_1s ;5
    CALL ATRASO_1s ;6
    CALL ATRASO_1s ;7
    CALL ATRASO_1s ;8
    CALL ATRASO_1s ;9
    CALL ATRASO_1s ;10
    CALL ATRASO_1s ;11
    CALL ATRASO_1s ;12
    CALL ATRASO_1s ;13
    CALL ATRASO_1s ;14
    CALL ATRASO_1s ;15
    CALL ATRASO_1s ;16
    CALL ATRASO_1s ;17
    CALL ATRASO_1s ;18
    CALL ATRASO_1s ;19
    CALL ATRASO_1s ;20
    CALL ATRASO_1s ;21
    CALL ATRASO_1s ;22
    CALL ATRASO_1s ;23
    CALL ATRASO_1s ;24
    CALL ATRASO_1s ;25
    CALL ATRASO_1s ;26
    CALL ATRASO_1s ;27
    CALL ATRASO_1s ;28
    CALL ATRASO_1s ;29
    CALL ATRASO_1s ;30
    CALL ATRASO_1s ;31
    CALL ATRASO_1s ;32
    CALL ATRASO_1s ;33
    CALL ATRASO_1s ;34
    CALL ATRASO_1s ;35
    CALL ATRASO_1s ;36
    CALL ATRASO_1s ;37
    CALL ATRASO_1s ;38
    CALL ATRASO_1s ;39
    CALL ATRASO_1s ;40
    CALL ATRASO_1s ;41
    CALL ATRASO_1s ;42
    CALL ATRASO_1s ;43
    CALL ATRASO_1s ;44
    CALL ATRASO_1s ;45
    CALL ATRASO_1s ;46
    CALL ATRASO_1s ;47
    CALL ATRASO_1s ;48
    CALL ATRASO_1s ;49
    CALL ATRASO_1s ;50
    CALL ATRASO_1s ;51
    CALL ATRASO_1s ;52
    CALL ATRASO_1s ;53
    CALL ATRASO_1s ;54
    CALL ATRASO_1s ;55
    CALL ATRASO_1s ;56
    CALL ATRASO_1s ;57
    CALL ATRASO_1s ;58
    CALL ATRASO_1s ;59
    CALL ATRASO_1s ;60
    RETURN     ; loop forever
    
 ;*******************************************************************************
; Rotina ATRASO_1s
; Gera um atraso correspondente a 1 segundo
; para o microcontrolador operando a um clock
; de 4MHz    
;*******************************************************************************
 
ATRASO_1s
    MOVLW .200 
    MOVWF TEMP2
L1
    RCALL ATRASO_1ms
    RCALL ATRASO_1ms
    RCALL ATRASO_1ms
    RCALL ATRASO_1ms
    RCALL ATRASO_1ms
    DECFSZ TEMP2
    BRA L1
    RETURN
    
;*******************************************************************************
; Rotina ATRASO
; Gera um atraso correspondente a 1 ms
; para o microcontrolador operando a um clock
; de 4MHz    
;*******************************************************************************   

ATRASO_1ms
    MOVLW .100  ; Executa 
    MOVWF TEMP1
LOOP2
    NOP               
    NOP
    NOP
    NOP
    NOP
    DECFSZ TEMP1
    BRA LOOP2
    RETURN
ending
    nop
    nop
BRA START    
    END