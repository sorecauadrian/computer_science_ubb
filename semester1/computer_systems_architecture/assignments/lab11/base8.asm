bits 32

global base8

extern exit
import exit msvcrt.dll

segment data use32 class=data
    eight db 8
    ten db 10
    powerOfTen db 0

segment code use32 class=code
    base8:
        mov [powerOfTen], byte 1 
        loop2:                  ; while True
            div byte [eight]        ; ah <- ax % 10
                                    ; al <- ax / 10
            push ax
            mov al, ah              ; al <- ah
            mul byte [powerOfTen]   ; ax <- al * [powerOfTen]
            add dx, ax              ; dx += ax
                                    ; dx gets the digits of ax in base 8
                                    
            mov al, [powerOfTen]    ; al <- [powerOfTen]
            mul byte [ten]          ; ax <- [powerOfTen] * 10
            mov [powerOfTen], al    ; [powerOfTen] <- al (ax)
                                    ; [powerOfTen] is multiplied by 10
            pop ax
            
            cmp al, 0               ; if al == 0
            je done                     ; continue
            mov ah, 0               ; ah <- 0
        jmp loop2
        done:
        ret
        push dword 0
        call [exit]