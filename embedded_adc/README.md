# LED Brightness Control Using ADC and Timers

This project demonstrates the use of a microcontroller’s **analog-to-digital converter (ADC)** and **hardware timers** to control LED brightness based on an analog input.

A **potentiometer** generates an analog voltage between 0 V and the supply voltage, which is periodically sampled by the ADC using a timer interrupt occurring every **(X+1) ms**, where **X, Y, and Z** are derived from the last three digits of the student ID. The ADC **interrupt service routine (ISR)** reads and scales the two-byte conversion result.

A second timer generates a **PWM signal** with a frequency of **(Z+1) × 100 Hz** to drive the LED. The PWM **duty cycle** is proportional to the potentiometer’s wiper position. The potentiometer is connected to **ADC channel Y % 6**, producing smooth and continuous dimming and brightening of the LED as the potentiometer is adjusted.
