    /* INITIALIZATION */
    xor ecx, ecx;                               /* set ecx all 0s */
    xor ebx, ebx;
    mov bl, byte ptr %[bitSequence][ecx];       /* move the first bits word into bl */
    shr bl, 7;                                  /* keep only the highest bit of bl (needed for the first check to not have transitions) */
    mov bh, bl;                                 /* move the old word to the left (i.e., ah) */

    /* TRANSITION CHECK CYCLE */
l0: mov eax, ecx;
    shr eax, 3;                                 /* divide by 8 */
    mov bl, byte ptr %[bitSequence][eax];       /* move the new word into bh */

    /* CENTRAL BIT MASKING */
l1: mov eax, ebx;                               /* copy ebx in eax to apply a mask */
    and eax, 0x0180;                            /* mask to keep just the middle bits */

    /* TRANSITION CHECK AND INCREMENTS */
    cmp eax, 0x0080;                            /* check if bits contains a 0 -> 1 transition; set ZF accordingly */
    jne l2;
    inc %[increments];
    /*add %[increments], zf;*/                      /* TODO ZF = 0 if not transition, ZF = 1 otherwise */
l2: cmp eax, 0x0100;                            /* check if bits contains a 1 -> 0 transition */
    jne l3;
    inc %[decrements];

    /* SET NEW CHECK */
l3: shl ebx, 1;                                 /* shift ebx to left; aka check next bits */
    inc ecx;                                    /* increment checked bits count */
    cmp ecx, %[bitCount];                       /* check if all the bits have been checked*/
    je l4;                                      /* ... if not, check next */
    mov eax, ecx;                               /* copy ecx to eax to perform a mask */
    and eax, 0x0007;                            /* keep the lowest 3 bits of eax (i.e., remainder of eax / 8) and set ZF flag */
    je l0;
    jmp l1;
l4:
