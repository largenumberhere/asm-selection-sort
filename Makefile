.PHONY: _default debug clean

_default:
	nasm -felf64 solution.asm -o solution
	gcc main.c -g solution -o main -fno-pie -no-pie -lcriterion
	./main

debug:	
	nasm -felf64 -g -F dwarf solution.asm -o solution
	gcc debug.c -g solution -o debug -fno-pie -no-pie
	gdb ./debug


clean:
	rm -f ./debug
	rm -f ./main
	rm -f ./solution