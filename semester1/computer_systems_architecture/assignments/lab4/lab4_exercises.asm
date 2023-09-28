bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A - word, B - word, C - byte, D - double word

    A dw 128
    B dw 255
    C db 0
    D dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; Given the words A and B, compute the byte C as follows:
        mov bx, 0
        
        ; the bits 0-5 are the same as the bits 5-10 of A
        mov ax, [A]
        and ax, 0000011111100000b
        shr ax, 5
        or bx, ax
        
        ; the bits 6-7 are the same as the bits 1-2 of B.
        mov ax, [B]
        and ax, 0000000000000110b
        shl ax, 5
        or bx, ax
        
        mov [C], bl
        
        
        ; Compute the doubleword D as follows:
        mov ebx, 0
        
        ; the bits 8-15 are the same as the bits of C
        mov eax, 0
        mov al, [C]
        shl eax, 8
        or ebx, eax
        
        ; the bits 0-7 are the same as the bits 8-15 of B
        mov eax, 0
        mov ax, [B]
        and ax, 1111111100000000b
        shr ax, 8
        or ebx, eax
        
        ; the bits 24-31 are the same as the bits 0-7 of A
        mov eax, 0
        mov ax, [A]
        and ax, 0000000011111111b
        ror eax, 8
        or ebx, eax
        
        ; the bits 16-23 are the same as the bits 8-15 of A.
        mov eax, 0
        mov ax, [A]
        and ax, 1111111100000000b
        rol eax, 8
        or ebx, eax
        
        mov [D], ebx
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
