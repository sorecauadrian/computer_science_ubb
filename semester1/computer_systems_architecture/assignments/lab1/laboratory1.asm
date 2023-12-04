bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    d db 6
    e dw 3
    f dw 9

; our code starts here
segment code use32 class=code
    start:
        mov ax, [e]; ax = e
        sub ax, 2; ax = e - 2
        mul word [f]; dx:ax = f * (e - 2)
        mov bx, ax; dx:bx = f * (e - 2)
        mov al, [d]
        sub al, 5; al = d - 5
        mov cl, 3
        mul cl; ax = 3 * (d - 5)
        mov cx, ax; cx = 3 *(d - 5)
        mov ax, bx; dx:ax = f * (e - 2)
        div cx; ax = result (3), dx = remainder (0)
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
