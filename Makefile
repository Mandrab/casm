CFLAGS = -m32 -masm=intel

%.bin:	%/main.c %/assembly.asm
		gcc $(CFLAGS) -DASM_CODE="\"$$(cat $(<D)/assembly.asm | tr '\n' ' ')\"" $< -o $@

.PHONY: clean

clean:
		rm -f *.bin
