#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

int main()
{
	if (fork() != fork())
	{
		printf("B\n");
		fork();
	}
	printf("A\n");
	return 0;
}
