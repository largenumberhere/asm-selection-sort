# Asm Selection Sort

It doees what it says on the tin. This was a learning exercise, and as such it prioritizes being easier to debug readable by a human - you won't find cutting-edge performance here. It was written with inspiration and tests taken from of the [Sort Numbers problem on Codewars](https://www.codewars.com/kata/5174a4c0f2769dd8b1000003).

The actual code is in [./soltution.asm](solution.asm), the rest is tests and debugging tooling.  

## Run it
You will need to run this on an x86_64 linux computer, this is the exact flavor of assembly used here. Porting to other platforms is left as an exercise to the reader.
- Install libcriterion
- Install nasm
- Install make
- Ensure gcc is installed
- Run the command `make run` inside the project folder to run the criterion tests 
