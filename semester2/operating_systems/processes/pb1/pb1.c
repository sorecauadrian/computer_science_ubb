#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <unistd.h>

int main (int argc, char **argv)
{
	int i, n = 3;
	for (i = 0; i < n; i++)
	{
		int f = fork();
		if (f == -1)
			perror("Error on fork");
		else if (f == 0)
		{
			printf("C - Child PID: %d Parent PID: %d\n", getpid(), getppid());
			exit(0);
		}
		else
			printf("P - Child PID: %d Parent PID: %d\n", f, getpid());
	}
	for (i = 0; i < n; i++)
		wait(0);
	printf("Done!\n");
	return 0;
}
