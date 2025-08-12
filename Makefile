.PHONY: _default debug clean

CFLAGS:= -fno-pie -no-pie -z noexecstack -O0

_default:
	nasm -felf64 solution.asm -o solution
	gcc main.c -g solution -o main -lcriterion $(CFLAGS)
	./main 

debug:	
	nasm -felf64 -g -F dwarf solution.asm -o solution
	gcc debug.c -g solution -o debug $(CFLAGS)
# 	gdb ./debug
# 	cp ./debug a.out

clean:
	rm -f ./debug
	rm -f ./main
	rm -f ./solution