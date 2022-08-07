    mov ecx, %[pointCount];             /* iterate the sequence backward (i.e., pointCount -> 0)*/
    mov esi, 0xffffffff;                /* set initial distance of nearest point to max */
    xor edi, edi;                       /* set initial distance of farthest point to min */
l1: movd mm0, %[pointSet][ecx * 4 - 4]; /* take the next point from the set and load it */
    psubw mm0, %[point];                /* individually subtract the coordinates of the target and set points */
    pmaddwd mm0, mm0;                   /* perform Euclidean distance without sqrt (i.e., mml^2 + mmh^2) */
    movd eax, mm0;                      /* move distance into 32bit register */
    cmp eax, esi;                       /* check if the point is the new nearest ... */
    ja l2;                              /* ... if it is not, go to check if it is the farthest; otherwise ... */
    mov %[nearIdx], ecx;                /* ... save the point index */
    dec %[nearIdx];                     /* decrease the index (ecx is decreased at the end by the loop) */
    mov esi, eax;                       /* save the new nearest distance */
l2: cmp eax, edi;                       /* check if the point is the new farthest ... */
    jb l3;                              /* if it is not, go to check the next point; otherwise ... */
    mov %[farIdx], ecx;                 /* ... save the point index */
    dec %[farIdx];                      /* decrease the index (ecx is decreased at the end by the loop) */
    mov edi, eax;                       /* save the new farthest distance */
l3: loop l1;                            /* loop to check the next point */
