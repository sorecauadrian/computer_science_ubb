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
        ; unsigned
        mov al, byte [c]; al <- c
        mov ah, byte 0  ; ax <- c 
        mov dl, byte [d]; dl <- d
        inc dl          ; dl <- d + 1
        div dl          ; al <- c/(d + 1)
        mov cl, al      ; cl <- c/(d + 1)
        mov ch, byte 0
        mov ax, word 1
        mov dx, word 0  ; dx:ax <- 1
        div word [a]    ; ax <- 1/a
        mov bx, ax      ; bx <- 1/a
        mov ax, word 200; ax <- 200
        mul word [b]    ; dx:ax <- 200*b
        add ax, bx
        adc dx, 0       ; dx:ax <- 1/a + 200*b
        sub ax, cx
        sbb dx, 0       ; dx:ax <- 1/a + 200*b - c/(d + 1)
        mov [result], ax
        mov [result + 2], dx; result <- 1/a + 200*b - c/(d + 1)
        
        mov eax, [x]
        mov edx, [x + 4]; edx:eax <- x
        mov ebx, dword 0
        mov bx, word [a]; ebx <- a
        div ebx         ; eax <- x/a
        sub eax, [e]    ; eax <- x/a - e
        add eax, [result]; eax <- 1/a + 200*b - c/(d + 1) + x/a - e
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
