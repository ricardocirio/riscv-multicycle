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
   
//	for(x=0; x<16; x++){
//		sdram[x] = 4;
//	}

	while (1){

		for(x=0; x<16; x++){
			sdram[x] = 4;

		}

		for(x=0; x<16; x++){
			OUTBUS =  sdram[x];
			delay_(50); //ToDo: SDRAM refresh and init are not working.
		}


		
		/* To test Data Bus 
		x = INBUS;        
		OUTBUS = x; */
	}

	return 0;
}
