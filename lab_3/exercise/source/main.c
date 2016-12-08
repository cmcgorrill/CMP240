#include "gpio.h"
#include "system_timer.h"
#include "uart.h"

void blink_once()
{
    // Turn on LED
    gpio[GPSET0] = 0x10000;
    timer_delay_sec(1);

    // Turn off LED
    gpio[GPCLR0] = 0x10000;
	timer_delay_ms(500000);

}

void blink_code(uint32_t err)
{
    for(int i = 0; i < err; ++i)
    {
        // Blink the LED
        blink_once();
    }
    // Delay for desired time
    timer_delay_sec(5);
}

int main()
{
    // Init GPIO select for external LED
    gpio[GPFSEL1] = 0x40000;
	gpio[GPFSEL3] = 0x40000;

    // Init uart for debugging purposes
    init_uart();

    // Provide a buffer size for debug prints
    const int bufferSize = 80;
    char buffer [bufferSize];

    // You might need a count for something
    uint32_t count = 1;

    // Mainline loop
    while (1)
    {
		count %= 10;
		// implement error code described in lab
        if(count > 0){
            blink_code(count);
        }
        count++;
    }
    
    return 0;
}
