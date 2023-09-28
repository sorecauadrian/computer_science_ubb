bits 32     
extern _format
global _character_array 
segment data public data use32
    character_format db "%c", 0
segment code public code use32 
        _character_array:
            push ebp
            mov ebp, esp   
            
            mov edi, _format
            mov esi, character_format
            mov ecx, 2
            repeat:
                movsb
            loop repeat
            
            mov esp, ebp
            pop ebp 
        ret