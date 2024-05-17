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
			perror("error on fork");
		else if (f == 0)
		{
			printf("Child - PID: %d, PPID: %d\n", getpid(), getppid());
			exit(0);
		}
		else
			printf("Parent - Child PID: %d, PID: %d\n", f, getpid());
	}
	for (i = 0; i < n; i++)
		wait(0);
	printf("done!\n");
	return 0;
}
