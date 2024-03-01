; printf("%s", "hello world");

; format db "%s", 0
; strh db "hello world", 0
; push strh
; push format
; call [printf]

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf       ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dd 12345678h, 1A2C3C4Dh, 98FCDC76h
    lens equ ($ - s) / 4
    ten db 10
    possible_palindrome db 0
    
    d resb lens
    ; d db 2Ch, FCh
    digitsOfBase10Number resb 4     ; the number can only have maximum 3 digits if it's stored on 8 bits, so we're reserving 4 bytes

; our code starts here
segment code use32 class=code
    start:
        ; A list of doublewords is given. Obtain the list made out of the low bytes of the high words of each doubleword from the given list with the property that these bytes are palindromes in base 10.
        mov esi, s                      ; esi <- offset(s)
        mov edi, d                      ; edi <- offset(d) 
        mov ecx, lens                   ; ecx <- len(s)
        cld                             ; df  <- 0
        jecxz empty_list                ; if ecx == 0
                                            ; that's it                                
        repeat:                         ; while ecx != 0 
            push ecx                        
            lodsd                           ; eax <- [esi], esi += 4 (pointing the next dword)
            shr eax, 16                     ; bringing the 16-23 bits to the 0-7 position,so the value needed will be stored in al                      
            xor ah, ah                      ; ah <- 0 (ax <- al)
            
            ; we're verifying if the value in al is a palindrome
            mov ebx, digitsOfBase10Number   ; ebx <- offset(digitsOfBase10Number) 
            mov [possible_palindrome], al   ; [possible_palindrome] <- al
            
            ; we're storing the digits in base 10 of ax in an auxiliar variable
            dividing:                       ; while true
                div byte [ten]                  ; ah <- ax % 10, 
                                                ; al <- ax / 10
                mov [ebx], ah                   ; [ebx] <- ah
                inc ebx                         ; ebx++
                cmp al, 0                       ; if al == 0
                je done_storing                     ; break
                xor ah, ah                      ; ah <- 0 (ax <- al)
            jmp dividing                    ;
            
            done_storing:                       
            ; we got the digits stored in digitsOfBase10Number
            
            
            ; we're going to check if the digits stored in digitsOfBase10Number form a palindrome
            dec ebx                         ; ebx <- offset(last element from digitsOfBase10Number)
            mov ecx, digitsOfBase10Number   ; ecx <- offset(first element from digitsOfBase10Number)
            mov edx, ebx                    ; edx <- offset(last element from digitsOfBase10Number) (so that we're not exceeding this limit)
            
            ; we're going through the variable from the beggining and from the end and we're checking if the pairs are equal
            comparing_digits:               ; while true
                mov al, [ebx]                   ; al <- [ebx] 
                mov ah, [ecx]                   ; ah <- [ecx]
                cmp al, ah                      ; if al != ah
                jne end_of_repeat                   ; we don't have a palindrome, so we're going to check the next number
                dec ebx                         ; ebx--
                inc ecx                         ; ecx++
                cmp ecx, edx                    ; if ecx > edx
                ja found_palindrome                 ; break
            jmp comparing_digits            ;
            
            ; we found that the digits from digitsOfBase10Number form a palindrome
            found_palindrome:
            
            ; storing the palindrome in 'd'
            mov al, [possible_palindrome]   ; al <- value(possible_palindrome)
            stosb                           ; [edi] <- al, edi++
            
            end_of_repeat:
            pop ecx
        loop repeat                     ; ecx--
        empty_list:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
