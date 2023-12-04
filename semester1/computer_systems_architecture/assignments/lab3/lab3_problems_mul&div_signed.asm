bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 1/a + 200*b - c/(d + 1) + x/a - e
    
    ; a, b - word
    a dw 1
    b dw 1
    
    ; c, d - byte
    c db 2
    d db 1
    
    ; e - doubleword
    e dd 1
    
    ; x - qword
    x dq 1

    ;result - auxiliar variable (double word)
    result dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; signed
        mov ax, word 1  ; ax <- 1
        cwd             ; dx:ax <- 1
        idiv word [a]   ; ax <- 1/a
        mov bx, ax      ; bx <- 1/a
        mov ax, word 200; ax <- 200
        imul word [b]   ; dx:ax <- 200*b
        mov cx, word 0  ; cx <- 0
        add bx, ax      
        adc cx, dx      ; cx:bx <- 1/a + 200*b
        mov al, byte [c]; al <- c
        cbw             ; ax <- c
        mov dl, byte [d]; dl <- d
        inc dl          ; dl <- d + 1
        idiv byte dl    ; al <- c/(d + 1)
        cbw             ; ax <- c/(d + 1)
        sub bx, ax
        sbb cx, 0       ; cx:bx <- 1/a + 200*b - c/(d + 1)
        mov [result], bx
        mov [result + 2], cx; result <- 1/a + 200*b - c/(d + 1)
        
        mov ax, word [a]; ax <- a
        cwde            ; eax <- a
        mov ebx, eax    ; ebx <- a
        mov eax, [x] 
        mov edx, [x + 4]; edx:eax <- x
        idiv ebx        ; eax <- x/a
        sub eax, [e]    ; eax <- x/a - e
        add eax, [result]; eax <- 1/a + 200*b - c/(d + 1) + x/a - e
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
