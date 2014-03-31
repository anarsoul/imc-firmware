SDAS = sdasz80
SDLD = sdld
MAKEBIN = makebin

all: imc-bios.bin

IMC_BIOS_SRC=imc-bios.asm
IMC_BIOS_OBJ=${IMC_BIOS_SRC:.asm=.rel}


%.rel : %.asm
	${SDAS} -l -o $<

imc-bios.ihx: ${IMC_BIOS_OBJ}
	${SDLD} -muwx -i imc-bios.ihx -M -Y -b HOME=0x0000 imc-bios.rel -e

imc-bios.bin: imc-bios.ihx
	${MAKEBIN} -s 2048 $< $@

clean:
	rm *.ihx *.bin *.lst *.map *.mem *.rel *.rst
