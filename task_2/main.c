/********************************************************************************
 *                                                                              *
 * 							Computer Architectures								*
 *                                                                              *
 ********************************************************************************

 Description:	Provided a set of two-dimensional points in the Cartesian plane,
				find the closest and the farthest point from a given point (x,y).
                Each point is represented by a DWORD: where the least significant
                WORD is the x coordinate, and the most significant one is the y.

 ********************************************************************************/

#ifndef _GNU_SOURCE
    #define _GNU_SOURCE // for asprintf usage
#endif
#ifndef ASM_CODE
	#define ASM_CODE ""
#endif

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

char* stringifyPoint(uint32_t);

int main()
{
    // Input variables
	uint64_t point = 0xFC1803E8;                        // -1000,  1000
	uint32_t pointSet[] = {
		0x00000000,                                     //     0,     0
		0x03E803E8,                                     //  1000,  1000 FARTHEST
		0xFC18FC18,                                     // -1000, -1000
		0xFC1903E7,                                     //  -999,   999 NEAREST
		0xFC1800C8                                      // -1000,   200
	};
	uint32_t pointCount = sizeof(pointSet) / sizeof(pointSet[0]); // number of points in the set

	// Output variables
	uint32_t nearIdx;		                            // index of nearest point
	uint32_t farIdx;	                                // index of farthest point

	// Run assembly code
	asm(
		// Assembly code
		ASM_CODE

		// Output variables
		: [nearIdx] "=m"(nearIdx), [farIdx] "=m"(farIdx)

		// Input data
		: [point] "m"(point), [pointSet] "m"(pointSet), [pointCount] "m"(pointCount)

		// Clobbered register 
		: "eax", "ebx", "ecx", "edi", "esi", "mm0", "mm1"
	);

    char* pointStr = stringifyPoint(point);
    char* nearStr = stringifyPoint(pointSet[nearIdx]);
    char* farStr = stringifyPoint(pointSet[farIdx]);

	printf(
        "The nearest point to %s is %s [index=%d]\n"
        "The farthest point to %s is %s [index=%d]",
		pointStr, nearStr, nearIdx,
        pointStr, farStr, farIdx
    );

    free(pointStr);
    free(nearStr);
    free(farStr);

	return 0;
}

char* stringifyPoint(uint32_t point)
{
    char* result;
    asprintf(&result, "(%d, %d)", (int16_t)(point), (int16_t)(point >> 16));
    return result;
}
