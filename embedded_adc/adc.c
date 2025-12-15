#define F_CPU 16000000
#include <avr/interrupt.h>
#include <avr/io.h>
#include <util/delay.h>

volatile int duty;

void timer1_init(){ //duty cycle
    TCCR1B |= (1 << WGM12);
    OCR1A = 0X45; // 900 Hz PWM
    TCCR1B |= (1 << CS12); //start timer, prescale to 256;
}
void timer0_init(){
    TCCR0A |= (1 << WGM01);
    OCR0A = 0X6D; // 7 ms timer
    TCCR0B |= (1 << CS00) | (1 << CS02); //start timer, prescale to 1024
}

ISR (TIMER1_COMPA_vect) // timer1 Compare register A interrupt
{
    PORTB |= (1<<PORTB5); //Set port bit B5 to 1 to turn on the LED
}

ISR (TIMER1_COMPB_vect) // timer1 Compare register B interrupt
{
    PORTB &= ~(1<<PORTB5); //Set port bit B5 to 1 to turn off the LED
}

ISR (ADC_vect)
{
    duty = ADC;
    OCR1B = (duty*OCR1A)/1023; // ADC generates a 10 bit result in ADCH and ADCL
}

int main()
{
    // LED
    DDRB |= (1<<DDB5); // Set port bit B5 in data direction register to 1: an OUTput
    DDRC &= ~(1<<DDC3); //potentiometer

    TIMSK1 |= (1 << OCIE1A) | (1 << OCIE1B); //Set the ISR COMPA vect and COMPB vec
    TIMSK0 |= (1 << OCIE0A);
    sei(); //enable interrupts
    ADMUX |= (1 << REFS0) | (1 << MUX1) | (1 << MUX0); // channel select and Vref
    ADCSRA |= (1 << ADEN) | (1 << ADATE) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0) |
    (1 << ADIE);
    ADCSRB |= (1 << ADTS1) | (1 << ADTS0);
    timer0_init();
    timer1_init();
    
    while(1){}
}