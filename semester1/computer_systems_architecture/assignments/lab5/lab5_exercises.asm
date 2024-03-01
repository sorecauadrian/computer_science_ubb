bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A character string S is given. Obtain the string D that contains all capital letters of the string S.
    S db 'a', 'A', 'b', 'B', '2', '%', 'x', 'M'
    lenS equ $ - S 
    
    ; D: 'A', 'B', 'M'
    D resb lenS
; our code starts here
segment code use32 class=code
    start:
        mov ecx, lenS           ; ecx <- length of S
        mov esi, S              ; esi <- address of S
        mov edi, D              ; edi <- address of D
        jecxz finish            ; if ecx == 0 -> go to the end of the program
        while_ecx_not_zero:     ; while (ecx != 0)
            mov al, [esi]           ; al <- value at the address esi
            inc esi                 ; esi++ (index of S is increasing)
            cmp al, 'A'             ; if (al < 'A')
            jb end_of_while         ;   continue
            cmp al, 'Z'             ; if (al > 'Z')
            ja end_of_while         ;   continue
            mov [edi], al           ; value at the address edi <- al
            inc edi                 ; edi++ (index of D is increasing)
            end_of_while:           ; the continue function (somehow)
        loop while_ecx_not_zero     ; ecx--
        finish:                 ; the end of the program
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
