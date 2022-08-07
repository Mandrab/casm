    mov ebx, -1;                    /* set ebx to point at -1 element of the array; it will become 0 at the first cycle */
l2: xor ax, ax;                     /* set ax to 0 */
l1: inc ebx;                        /* set ebx to point at the next element of the array */
    sub byte ptr %[date][ebx], 48;  /* subtract 48 (code of 0 in ascii) from the character to obtain the (possibly) numeric value */
    cmp byte ptr %[date][ebx], 10;  /* if the result of the subtraction is higher than 10, the value is a symbol ... */
    jae l3;                         /* ... and thus a numeric value terminated; we jump to save it in the stack; otherwise ... */
    imul ax, 10;                    /* ... the previous known value is multiplied by 10 and the new value is added (e.g., 15 = 1 * 10 + 5) */
    mov cl, byte ptr %[date][ebx];  /* move the next number in the lowest 8 bits of ecx */
    add al, cl;                     /* sum the lowest bits of eax with the lowest of ecx */
    jmp l1;                         /* jump back to check next character */
l3: push ax;                        /* save the obtained data in the stack */
    cmp ebx, 18;                    /* date is composed by 18 characters; if we counted less... */
    jl l2;                          /* ... jump back to check next character */
    pop %[s];                       /* pop seconds value to variable */
    pop %[m];                       /* pop minutes value to variable */
    pop %[h];                       /* pop hours value to variable */
    pop %[Y];                       /* pop years value to variable */
    pop %[M];                       /* pop months value to variable */
    pop %[D];                       /* pop days value to variable */
