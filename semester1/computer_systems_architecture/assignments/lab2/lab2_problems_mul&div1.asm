bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a,b,c - byte
    a db 255
    b db 255
    c db 255
    
    ; d - word
    d dw 1024
    
    ; x, y, z - constant values
    x db 100
    y db 75
    z db 5
    
; our code starts here
segment code use32 class=code
    start:
        ; (100*a + d + 5 - 75*b)/(c - 5)
        ; the result is going to be stored in al
        mov al, [y] ; al -> 75
        mul byte [b]; ax -> 75*b
        mov dx, ax  ; dx -> 75*b
        mov al, [x] ; al -> 100
        mul byte [a]; ax -> 100*a
        add ax, [d] ; ax -> 100*a + d
        add ax, [z] ; ax -> 100*a + d + 5
        sub ax, dx  ; ax -> 100*a + d + 5 - 75*b
        mov dl, [c] ; dl -> c
        sub dl, 5   ; dl -> c - 5
        div dl      ; al -> ax / dl, ah -> ax % dl
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
