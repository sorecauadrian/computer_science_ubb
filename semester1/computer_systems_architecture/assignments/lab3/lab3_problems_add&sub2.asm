bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (b + c + d) - (a + a)
    ; a - byte
    a db 1
    
    ; b - word
    b dw 2
    
    ; c - double word
    c dd 4
    
    ; d - quad word
    d dq 8
    
; our code starts here
segment code use32 class=code
    start:
        mov al, [a]     ; al <- a
        add al, [a]     ; al <- a + a
        cbw             ; ax <- a + a
        cwde            ; eax <- a + a
        cdq             ; edx:eax <- a + a
        mov ecx, eax    
        mov ebx, edx    ; ebx:ecx <- a + a
        
        mov ax, [b]     ; ax <- b
        cwde            ; eax <- b
        add eax, [c]    ; eax <- b + c
        cdq             ; edx:eax <- b + c
        add eax, [d]
        adc edx, [d + 4]; edx:eax <- b + c + d
        
        sub eax, ecx
        sbb edx, ebx    ; edx:eax <- (b + c + d) - (a + a)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
