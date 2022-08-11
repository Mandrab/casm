    /* INITIALIZATION */
    mov ecx, %[bitCount];                       /* set number of bits to evaluate in the cycle */            
    mov bh, byte ptr %[bitSequence];            /* move the first bits word into bh */
    shr bh, 7;                                  /* keep only the first bit of the sequence (to not have transitions the fist cycle) */

    /* TRANSITION CHECK CYCLE */
l0: mov eax, ecx;                               /* copy ecx to eax to perform a mask */
    and eax, 0x0007;                            /* keep the lowest 3 bits of eax (i.e., remainder of eax / 8) and set ZF flag */
    jnz l1;                                     /* if there is not any reminder, continue to check the bits */
    mov eax, %[bitCount];                       /* calculate the index of the next word to load ... */
    sub eax, ecx;                               /* ... subtracting ecx from bitCount ... */
    shr eax, 3;                                 /* ... and dividing by 8 to obtain the word to load */
    mov bl, byte ptr %[bitSequence][eax];       /* move the new word into bl */

    /* CENTRAL BIT MASKING */
l1: mov eax, ebx;                               /* copy ebx in eax to apply a mask */
    and eax, 0x0180;                            /* mask to keep just the middle bits */

    /* TRANSITION CHECK AND INCREMENTS */
    cmp eax, 0x0080;                            /* check if bits contains a 0 -> 1 transition; set ZF accordingly */
    jne l2;                                     /* if not an increment, check if it is a decrement */
    inc %[increments];                          /* increment the counter */
l2: cmp eax, 0x0100;                            /* check if bits contains a 1 -> 0 transition */
    jne l3;                                     /* if not a decrement, skip */
    inc %[decrements];                          /* increment the counter */

    /* SET NEW CHECK */
l3: shl ebx, 1;                                 /* shift ebx to left; i.e., check next bits */
    loop l0;                                    /* start the next cycle */
