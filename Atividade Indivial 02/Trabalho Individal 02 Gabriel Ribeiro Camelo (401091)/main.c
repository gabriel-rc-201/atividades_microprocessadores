/*
 * File:   main.c
 * Author: gabriel
 *
 * Created on 11 de Junho de 2019, 10:19
 */

// PIC18F4550 Configuration Bit Settings

// 'C' source line config statements

// CONFIG1L
#pragma config PLLDIV = 1       // PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
#pragma config CPUDIV = OSC1_PLL2// System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
#pragma config USBDIV = 1       // USB Clock Selection bit (used in Full-Speed USB mode only; UCFG:FSEN = 1) (USB clock source comes directly from the primary oscillator block with no postscale)

// CONFIG1H
#pragma config FOSC = XT_XT     // Oscillator Selection bits (XT oscillator (XT))
#pragma config FCMEN = OFF      // Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
#pragma config IESO = OFF       // Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

// CONFIG2L
#pragma config PWRT = OFF       // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOR = ON         // Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
#pragma config BORV = 3         // Brown-out Reset Voltage bits (Minimum setting 2.05V)
#pragma config VREGEN = OFF     // USB Voltage Regulator Enable bit (USB voltage regulator disabled)

// CONFIG2H
#pragma config WDT = OFF        // Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
#pragma config WDTPS = 32768    // Watchdog Timer Postscale Select bits (1:32768)

// CONFIG3H
#pragma config CCP2MX = ON      // CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
#pragma config PBADEN = OFF     // PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
#pragma config LPT1OSC = OFF    // Low-Power Timer 1 Oscillator Enable bit (Timer1 configured for higher power operation)
#pragma config MCLRE = ON       // MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

// CONFIG4L
#pragma config STVREN = ON      // Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
#pragma config LVP = OFF        // Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
#pragma config ICPRT = OFF      // Dedicated In-Circuit Debug/Programming Port (ICPORT) Enable bit (ICPORT disabled)
#pragma config XINST = OFF      // Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

// CONFIG5L
#pragma config CP0 = OFF        // Code Protection bit (Block 0 (000800-001FFFh) is not code-protected)
#pragma config CP1 = OFF        // Code Protection bit (Block 1 (002000-003FFFh) is not code-protected)
#pragma config CP2 = OFF        // Code Protection bit (Block 2 (004000-005FFFh) is not code-protected)
#pragma config CP3 = OFF        // Code Protection bit (Block 3 (006000-007FFFh) is not code-protected)

// CONFIG5H
#pragma config CPB = OFF        // Boot Block Code Protection bit (Boot block (000000-0007FFh) is not code-protected)
#pragma config CPD = OFF        // Data EEPROM Code Protection bit (Data EEPROM is not code-protected)

// CONFIG6L
#pragma config WRT0 = OFF       // Write Protection bit (Block 0 (000800-001FFFh) is not write-protected)
#pragma config WRT1 = OFF       // Write Protection bit (Block 1 (002000-003FFFh) is not write-protected)
#pragma config WRT2 = OFF       // Write Protection bit (Block 2 (004000-005FFFh) is not write-protected)
#pragma config WRT3 = OFF       // Write Protection bit (Block 3 (006000-007FFFh) is not write-protected)

// CONFIG6H
#pragma config WRTC = OFF       // Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) are not write-protected)
#pragma config WRTB = OFF       // Boot Block Write Protection bit (Boot block (000000-0007FFh) is not write-protected)
#pragma config WRTD = OFF       // Data EEPROM Write Protection bit (Data EEPROM is not write-protected)

// CONFIG7L
#pragma config EBTR0 = OFF      // Table Read Protection bit (Block 0 (000800-001FFFh) is not protected from table reads executed in other blocks)
#pragma config EBTR1 = OFF      // Table Read Protection bit (Block 1 (002000-003FFFh) is not protected from table reads executed in other blocks)
#pragma config EBTR2 = OFF      // Table Read Protection bit (Block 2 (004000-005FFFh) is not protected from table reads executed in other blocks)
#pragma config EBTR3 = OFF      // Table Read Protection bit (Block 3 (006000-007FFFh) is not protected from table reads executed in other blocks)

// CONFIG7H
#pragma config EBTRB = OFF      // Boot Block Table Read Protection bit (Boot block (000000-0007FFh) is not protected from table reads executed in other blocks)

#include <xc.h>
#define _XTAL_FREQ 4000000

unsigned char unidade,dezena;
bit count = 0;
bit buzz = 0;

void Apito(){
  INTCONbits.GIE = 1; //Habilita interrupcoes globalmente
  INTCONbits.PEIE = 1; //Habilita interrupcoes dos perifericos
  INTCONbits.INT0IE = 1; //Habilita interrupcao no INT0
  INTCON3bits.INT1IE = 1; //Habilita interrupcao no INT1
  
  buzz = 1;
    
  while(1){
    if(!buzz) break;
    PORTCbits.RC0 = 1;
      
    if(!buzz) break;
    __delay_ms(250);
        
    if(!buzz) break;
    PORTCbits.RC0 = 0;
        
    if(!buzz) break;
    __delay_ms(500);
       
    if(!buzz) break;
  }
}

void Contar(){
  if(dezena != 0 || unidade != 0 ){
    unidade--;
    
    if (unidade == 0xff){
        unidade = 9;
        dezena--;
       
        if (dezena == 0xff){
          dezena = 0;   
        }   
    }
  }else{
    Apito();
  }  
}

void atualiza_PORTD() {
  PORTD = (dezena << 4) | unidade;
}


void main() {
    //Inicialização
    TRISBbits.RB0 = 1; //RB0 e RB1 seta como entrada
    TRISBbits.RB1 = 1;
    TRISCbits.RC0 = 0;//RC0 seta como saida
    TRISD = 0;  //PORTD como saida
    
    INTCONbits.INT0IE = 1; //Habilita interrupcao no INT0
    INTCON3bits.INT1IE = 1; //Habilita interrupcao no INT1
    INTCONbits.GIE = 1; //Habilita interrupcoes globalmente
    INTCONbits.PEIE = 1; //Habilita interrupca dos periféricos    
    
    unidade = 5;
    dezena = 0;
    
    PORTD = 0;
    count = 0; 
    
    while(1) {   
     if (count){
        Contar();
     }
     atualiza_PORTD();
    __delay_ms(500);
    }
}

void interrupt isr() {
  if (INT0IF && buzz == 1){
    INT0IF = 0;  
    buzz = 0;
    PORTCbits.RC0 = 0;
    
    count = 0;
    unidade = 5;
    dezena = 0; 
  }
  
  else if (INT1IF && buzz == 1){
    INT1IF = 0;
    buzz = 0;  
    PORTCbits.RC0 = 0;
    
    count = 0;
    unidade = 5;
    dezena = 0; 
  }

  else if (INT0IF && buzz == 0){//Botao do INT0
    INT0IF = 0;
    dezena++;//incremento mais 10min  
    
    if(dezena > 9){
      dezena = 0;
    }    
  }
  
  else if (INT1IF && buzz == 0){//Botao do INT1  
    INT1IF = 0;
    count ^= 1;

    INTCONbits.INT0IE = 0; // Habilita interrupcao INT0
    INTCON3bits.INT1IE = 0; // Habilita interrupcao INT1
    INTCONbits.GIE = 0; // Desabilita interrupcoes globalmente
    INTCONbits.PEIE = 0;// Desabilita interrupcao dos perifericos
  }
}
