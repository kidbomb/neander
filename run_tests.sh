mkdir tac
mkdir asm/ned

./src/sc2tac/sc2tac -o tac/sum1.tac sc/sum1.c
./src/sc2tac/sc2tac -o tac/sum2if.tac sc/sum2if.c
./src/sc2tac/sc2tac -o tac/sum3.tac sc/sum3.c



./src/tac2asm/tac2asm -o asm/ned/sum1.asm tac/sum1.tac
./src/tac2asm/tac2asm -o asm/ned/sum2if.asm tac/sum2if.tac
./src/tac2asm/tac2asm -o asm/ned/sum3.asm tac/sum3.tac
