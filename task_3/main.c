/********************************************************************************
 *                                                                              *
 * 							Computer Architectures								*
 *                                                                              *
 ********************************************************************************

 Description:	Given a sequence of bits, count the number of transitions 0 -> 1
 				e 1 -> 0.

 ********************************************************************************/

#ifndef ASM_CODE
	#define ASM_CODE ""
#endif

#include <stdio.h>
#include <stdint.h>

int main()
{
    // Input variables
	uint8_t bitSequence[] = {0x00, 0x0a, 0xa9};
	uint32_t bitCount = 24;

	// Output variables
	uint32_t increments;	// transitions 0 -> 1
	uint32_t decrements;	// transitions 1 -> 0

	// Run assembly code
	asm(
		// Assembly code
		ASM_CODE

		// Output variables
		: [increments] "=m"(increments), [decrements] "=m"(decrements)

		// Input data
		: [bitSequence] "m"(bitSequence), [bitCount] "m"(bitCount)

		// Clobbered register 
		: "eax", "ebx", "ecx", "edx"
	);

	printf("The sequence [");
	for (int i = 0; i < bitCount / 8; i++)
		printf("%08b", bitSequence[i]);
	printf(
		"] contains:\n- 0 -> 1 transitions: %d\n- 1 -> 0 transitions: %d\n",
		increments, decrements
	);

	return 0;
}
