mkdir tac
mkdir asm/ned
mkdir mem

./src/sc2tac/sc2tac -o tac/sum1.tac sc/sum1.c
./src/sc2tac/sc2tac -o tac/sum2if.tac sc/sum2if.c
./src/sc2tac/sc2tac -o tac/sum3.tac sc/sum3.c

./src/tac2asm/tac2asm -o asm/ned/sum1.asm tac/sum1.tac
./src/tac2asm/tac2asm -o asm/ned/sum2if.asm tac/sum2if.tac
./src/tac2asm/tac2asm -o asm/ned/sum3.asm tac/sum3.tac

./src/asm2mem/asm2mem.py asm/ned/sum1.asm mem/sum1.mem
./src/asm2mem/asm2mem.py asm/ned/sum2if.asm mem/sum2if.mem
./src/asm2mem/asm2mem.py asm/ned/sum3.asm mem/sum3.mem
