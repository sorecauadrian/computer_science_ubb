bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    a dd 1
    string_a db 1 + '0', 0
    b dw 0
    print_a db "a = %d", 10, 0
    print_b db "b = ", 0
    result db "%d + %d/%d = %d", 0
    d_format db "%d", 0
    s_format db "%s", 0
    
segment code use32 class=code
    start:
        ; a natural number a (a: dword, defined in the data segment) is given. read a natural number b from the keyboard and calculate: a + a/b. display the result of this operation. the values will be displayed in decimal format (base 10) with sign.
        
        ; printf(print_a)
        push dword [a]
        push dword print_a
        call [printf]
        add esp, 4*2
        
        ; printf(print_b)
        push dword print_b
        push dword s_format
        call [printf]
        add esp, 4*2
        
        ; scanf('%d', b)
        push dword b
        push dword d_format
        call [scanf]
        add esp, 4*2
        
        ; eax <- a + a/b
        push dword [a]
        pop ax
        pop dx
        idiv word [b]
        cwde
        add eax, dword [a]
        
        ; printf(result)
        push dword eax
        push dword [b]
        push dword [a]
        push dword [a]
        push dword result
        call [printf]
        add esp, 4*5
        
        push dword 0        ; push the parameter for exit onto the stack
        call [exit]         ; call exit to terminate the program
