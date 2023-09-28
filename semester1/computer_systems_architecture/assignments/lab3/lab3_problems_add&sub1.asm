bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a + b - d) + (a - b - d)
    ; a - byte
    a db 8
    
    ; b - word
    b dw 4
    
    ; d - qword
    d dq 2
    
; our code starts here
segment code use32 class=code
    start:
        ; unsigned
        mov al, [a] ; al <- a
        mov ah, 0   ; ax <- a
        add ax, [b] ; ax <- a + b
        mov dx, ax  ; dx <- a + b 
        mov eax, 0  ; eax <- 0
        mov ax, dx  ; eax <- a + b
        mov edx, 0  ; edx:eax <- a + b
        sub eax, [d]
        sbb edx, [d + 4]; edx:eax <- a + b - d
        
        mov cl, [a] ; cl <- a
        mov ch, 0   ; cx <- a
        sub cx, [b] ; cx <- a - b
        mov bx, cx  ; bx <- a - b
        mov ecx, 0  ; ecx <- 0
        mov cx, bx  ; ecx <- a - b
        mov ebx, 0  ; ebx:ecx <- a - b
        sub ecx, [d]
        sub ebx, [d + 4]; ebx:ecx <- a - b - d
        
        add eax, ecx
        adc edx, ebx; edx:eax <- (a + b - d) + (a - b - d)
        
        ; the result is going to be stored in edx:eax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

