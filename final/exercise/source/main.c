#include "gpio.h"
#include "system_timer.h"
#include "uart.h"

void blink_once(uint32_t color, uint32_t my_delay)
{
    // 0 = green
	// 1 = yellow 
	// 2 = red

	if (color == 0) {
		//on
		gpio[GPCLR0] = 0x0010000;
		timer_delay_ms(my_delay);
	}
	else if (color == 1) {
		//on
		gpio[GPCLR0] = 0x1010000;
		timer_delay_ms(my_delay);
	}
	else {
		//on
		gpio[GPCLR0] = 0x1000000;
		timer_delay_ms(my_delay);
	}
	//off
	gpio[GPSET0] = 0x1010000;
	timer_delay_ms(250000);
	

	//// Turn on LED
	////gpio[GPCLR0] |= 1 << 24; //works for blue
	////gpio[GPCLR0] |= 0x10000; //works for green
	//gpio[GPCLR0] |= 0x1010000; //works for both
	////gpio[GPCLR1] |= 1 << 24;
	////1010000 both
	////1000000 red
	////0010000 green

 //   timer_delay_sec(1);

 //   // Turn off LED
	////gpio[GPSET0] |= 1 << 24; //works for blue
	////gpio[GPSET0] |= 0x10000; //works for green
	//gpio[GPSET0] |= 0x1010000;
	////gpio[GPSET1] |= 1 << 24;
	////gpio[GPCLR0] = 0x01000; //GPIO12??
	//timer_delay_ms(500000);

}

void blink_code(uint32_t time)
{
	uint32_t color = 0;
	uint32_t my_delay = 750000;
	for(int i = time; i > 0; --i)
    {
        //set color
		if (i < ((time/4)+1)) {
			color = 2;
		}
		else if (i < (time/2)+1) {
			color = 1;
		}
		//set delay
		if (i < ((time/10)+1)) {
			my_delay = 250000;
			blink_once(color, my_delay);
		}
		// Blink the LED	
		blink_once(color, my_delay);
    }
}

int main()
{
    // Init GPIO select for external LED
    gpio[GPFSEL1] |= 0x40000; //GPIO16
	//gpio[GPFSEL3] = 0x40000;
	gpio[GPFSEL2] |= 0x1000; //GPIO24
	// turn off pins
	gpio[GPSET0] = 0x1010000;
	

    // Init uart for debugging purposes
    init_uart();

    // Provide a buffer size for debug prints
    const int bufferSize = 80;
    char buffer [bufferSize];

    // You might need a count for something
    uint32_t time_sec = 40;

    // Mainline loop
    while (1)
    {
		blink_code(time_sec);
		timer_delay_sec(3);
    }
    
    return 0;
}
