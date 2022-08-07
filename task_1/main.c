/********************************************************************************
 *                                                                              *
 * 							Computer Architectures								*
 *                                                                              *
 ********************************************************************************

 Description: 	Given a string containing current date and time in the format
 				dd/mm/yyyy hh:mm:ss, break it down into day, month, year, hour,
				minute and second.

 ********************************************************************************/

#ifndef ASM_CODE
	#define ASM_CODE ""
#endif

#include <stdio.h>
#include <stdint.h>

int main()
{
	// Input variables
	uint8_t date[] = "31/12/9999 23:59:59";

	// Output variables
	uint16_t day, month, year, hour, minute, second;

	// Run assembly code
	asm(
		// Assembly code
		ASM_CODE

		// Output variables
		: [s] "=m"(second), [m] "=m"(minute), [h] "=m"(hour),
		  [D] "=m"(day), [M] "=m"(month), [Y] "=m"(year)

		// Input data
		: [date] "m"(date)

		// Clobbered register 
		: "eax", "ebx", "ecx"
	);

	printf(
		"The date is composed by:\n"
		"- day:\t\t %i \n"
		"- month:\t %i \n"
		"- year:\t\t %i \n"
		"- hour:\t\t %i \n"
		"- minute:\t %i \n"
		"- second:\t %i \n",
		day, month, year, hour, minute, second
	);

	return 0;
}
