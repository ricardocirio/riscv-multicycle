/*
 * firmware.c
 *
 *  Created on: Jan 20, 2019
 *      Author: Cleisson Fernandes Da Silva
 *      Instituto Federal de Santa Catarina
 * 
 * 
 * Simple SDRAM example.
 * -----------------------------------------
 */


#include "utils.h"
#include "hardware.h"


int main(){
	int x = 0;
	int i = 0;
	volatile uint32_t *sdram = &SDRAM;
   
	while (1){

		for(x=0; x<16; x++){
				 sdram[x] = 9;
		}

		for(x=0; x<16; x++){
			OUTBUS =  sdram[x];
			//delay_(5000); //ToDo: SDRAM refresh and init are not working.
		}
		
		/* To test Data Bus 
		x = INBUS;        
		OUTBUS = x; */
	}

	return 0;
}
