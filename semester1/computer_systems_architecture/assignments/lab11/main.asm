bits 32

global start

extern exit, printf, base8
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    base10_format db "base 10: %d", 10, 13, 0
    base8_format db "base 8: %d", 10, 13, 0
    ascii_format db "character: %c", 10, 13, 10, 13, 0
    number dw 32
    
; show for each number from 32 to 126 the value of the number (in base 8) and the character with that ASCII code.
segment code use32 class=code
    start:
        mov ecx, 126 - 32 + 1
        repeat:
            push ecx
            mov edx, 0
            mov eax, 0
            mov ax, [number]
            
            push eax
            push eax
            push base10_format
            call [printf]
            add esp, 4*2
            pop eax
            
            push eax
            call base8          ; the result is going to be stored in dx
            pop eax
            
            push eax
            push edx
            push base8_format
            call [printf]
            add esp, 4*2
            pop eax
            
            push eax
            push eax
            push ascii_format
            call [printf]
            add esp, 4*2
            pop eax
            
            inc word [number]
            pop ecx
        loop repeat
    
        push dword 0
        call [exit]
    
