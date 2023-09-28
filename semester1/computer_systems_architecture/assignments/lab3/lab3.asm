bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; c + (a*a - b + 7)/(2 + a)
    ; a - byte
    ; b - doubleword
    ; c - qword

; our code starts here
segment code use32 class=code
    start:
        ; unsigned
        mov al, [a]; al = a
        mul byte [a]; ax = a*a
        mov cx, ax; cx = ax
        mov eax, 0; eax = 0
        mov ax, cx; ax = cx (eax = ax)
        sub eax, [b]
        add eax, 7
        mov bl, [a]
        mov bh, 0
        add bx, 2
        push eax
        pop ax
        pop dx
        div bx
        mov cx, ax
        mov eax, 0
        mov ax, cx
        mov edx, 0
        add eax, [c]
        adc ebx, [c + 4]
        
        ; signed
        mov al, [a]
        imul byte [a]
        cwd; dx:ax = a * a
        sub ax, [b]
        sbb dx, [b + 2]
        add ax, 7
        adc dx, 0
        mov bx, ax
        mov al, [a]
        cbw
        add ax, 2
        mov cx, ax
        mov ax, bx
        idiv cx
        cwde; eax = ax
        cdq; edx:eax
        add eax, [c]
        adc edx, [c + 4]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
