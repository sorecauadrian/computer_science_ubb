bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a, b, d - byte
    a db 8
    b db 2
    d db 4

; our code starts here
segment code use32 class=code
    start:
        ; (a + b - d) + (a - b - d)
        ; the result is going to be stored in ax
        mov ax, [a]; ax -> a
        add ax, [b]; ax -> a + b
        sub ax, [d]; ax -> a + b - d
        mov dx, [a]; dx -> a
        sub dx, [b]; dx -> a - b
        sub dx, [d]; dx -> a - b - d
        add ax, dx ; ax -> (a + b - d) + (a - b - d)
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
