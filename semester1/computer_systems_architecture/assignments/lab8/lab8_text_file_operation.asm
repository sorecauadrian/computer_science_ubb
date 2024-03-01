bits 32

global start        

extern exit, printf, fopen, fread, fclose, perror
import exit msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import perror msvcrt.dll

segment data use32 class=data
    file_in db "in.txt", 0
    file_descriptor_in dd 0
    s_format db "%s", 0
    read db "r", 0
    buffer resb 127
    maximum_in_file_length equ $ - buffer
    err db "Error", 0
    frequency_vector resb 'Z' - 'A' + 1
    maximum_frequency db 0, 0
    uppercase_letter_with_highest_frequency db 0, 0

segment code use32 class=code
    start:
        ; a text file is given. read the content of the file, determine the uppercase letter with the highest frequency and display the letter along with its frequency on the screen. the name of text file is defined in the data segment.
        
        ; fopen("in.txt", "r")
        ; return value of function is stored in eax
        push dword read
        push dword file_in
        call [fopen]
        add esp, 4*2
        
        ; fopen returns 0 on error
        ; if an error occurred, we will print a message indicating that and stop
        cmp eax, 0
        je opening_error
        
        ; if no error, store the obtained file descriptor
        mov [file_descriptor_in], eax
        
        ; frequency_vector = [0, 0, ..., 0]
        cld                         ; clearing the direction flag
        mov ecx, 'Z' - 'A' + 1      ; ecx <- 'Z' - 'A' + 1
        mov al, 0                   ; al <- 0
        mov edi, frequency_vector   ; edi <- offset(frequency_vector)
        initialization_with_0:      ; while ecx != 0
            stosb                       ; [edi] <- 0, edi++
        loop initialization_with_0  ; ecx--
        
        loop1:
            ; fread(buffer, 1, maximum_in_file_length, file_descriptor_in)
            ; reads elements (1 byte and repeats that 127 times) from the file associated with descriptor 'file_descriptor_in' and stores them in 'buffer'
            push dword [file_descriptor_in]
            push maximum_in_file_length
            push 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            ; in our case, fread returns the number of bytes read and stored in buffer
            ; essentialy, buffer is a string and eax is the length of that string
            ; the only way out of .loop is here!!!
            mov ecx, eax
            jecxz close_file
            
            mov esi, buffer
            
            .parse:
                ; function calls can and will modify registers EAX, ECX, EDX and we are relying on ECX to loop, so we need to save it on the stack
                pushad
                
                cmp byte [esi], 'A'         ; if [esi] < 'A'
                jb .not_an_uppercase_letter     ; continue
                cmp byte [esi], 'Z'         ; if [esi] > 'Z'
                ja .not_an_uppercase_letter     ; continue
                
                ; inc [frequency_vector + [esi] - 'A']
                mov eax, dword frequency_vector
                add al, byte [esi]
                sub al, byte 'A'
                inc byte [eax]
                
                .not_an_uppercase_letter:
                popad
                inc esi
            loop .parse
            
            ; going through the frequency_vector
            mov esi, frequency_vector
            mov ecx, 'Z' - 'A' + 1
            going_through_the_frequency_vector:
                mov dl, [esi]
                cmp dl, byte [maximum_frequency]; if [esi] < [maximum_frequency]
                jb end_of_loop                      ; continue

                mov [maximum_frequency], dl     ; [maximum_frequency] <- [esi]   
                
                mov [uppercase_letter_with_highest_frequency], byte 'Z'                     
                sub [uppercase_letter_with_highest_frequency], cl
                inc byte [uppercase_letter_with_highest_frequency]; [uppercase_letter_with_highest_frequency] <- 'Z' - ecx + 1
                
                end_of_loop:
                inc esi
            loop going_through_the_frequency_vector
                
            add [maximum_frequency], byte '0'; [maximum_frequency] <- str([esi])
            
            
            push dword uppercase_letter_with_highest_frequency
            call [printf]
            add esp, 4*1
            
            push dword maximum_frequency
            call [printf]
            add esp, 4*1
        jmp loop1
        
        ; all the processing is done, cleanup is all that is left
        close_file:
            ; fclose(file_descriptor_in)
            push dword [file_descriptor_in]
            call [fclose]
            add esp, 4*1
            jmp eop
        
        opening_error:
            ; perror(err) -> will print the err string (see data segment) and will concatenate a short error description based on the current value of the internal variable errno
            push err
            call [perror]
            add esp, 4*1
            
        eop:
        push dword 0      ; push the parameter for exit onto the stack
        call [exit]       ; call exit to terminate the program
