#include <stdio.h>

// the function declared in the "character_format.asm" file

char format[10];

int main()
{
    int number;
    character_array(format);
    for(number = 32; number <= 126; number++)
    {
        printf("%d ", number);
        printf(format, number);
        printf("%c", ' ');
        printf("%o(8)", number);
        printf("%s","\n");
        
    }
    
 
}