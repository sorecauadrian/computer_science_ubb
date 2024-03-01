bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a, b, c, d - word
    a dw 1
    b dw 2
    c dw 2
    d dw 2

; our code starts here
segment code use32 class=code
    start:
        ; (b + c + d) - (a + a)
        ; word + word might occupy 17 bits, so we are using eax and edx
        mov eax, [b]; eax -> b
        add eax, [c]; eax -> b + c
        add eax, [d]; eax -> b + c + d
        mov edx, [a]; edx -> a
        add edx, [a]; edx -> a + a
        sub eax, edx; eax -> (b + c + d) - (a + a)
    
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
