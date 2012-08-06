mkdir tac
mkdir asm/ned
mkdir mem

./src/sc2tac/sc2tac -o tac/sum1.tac sc/sum1.c
./src/sc2tac/sc2tac -o tac/sum2if.tac sc/sum2if.c
./src/sc2tac/sc2tac -o tac/sum3.tac sc/sum3.c
./src/sc2tac/sc2tac -o tac/sum4.tac sc/sum4.c
./src/sc2tac/sc2tac -o tac/calculadora.tac sc/calculadora.c

./src/tac2asm/tac2asm -o asm/ned/sum1.asm tac/sum1.tac
./src/tac2asm/tac2asm -o asm/ned/sum2if.asm tac/sum2if.tac
./src/tac2asm/tac2asm -o asm/ned/sum3.asm tac/sum3.tac
./src/tac2asm/tac2asm -o asm/ned/sum4.asm tac/sum4.tac
./src/tac2asm/tac2asm -o asm/ned/calculadora.asm tac/calculadora.tac

./src/asm2mem/asm2mem.py asm/ned/sum1.asm mem/sum1.mem
./src/asm2mem/asm2mem.py asm/ned/sum2if.asm mem/sum2if.mem
./src/asm2mem/asm2mem.py asm/ned/sum3.asm mem/sum3.mem
./src/asm2mem/asm2mem.py asm/ned/sum4.asm mem/sum4.mem
./src/asm2mem/asm2mem.py asm/ned/calculadora.asm mem/calculadora.mem
