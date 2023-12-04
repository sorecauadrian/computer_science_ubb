#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <unistd.h>


void f(int n)
{
	if (n > 0)
	{
		int k = fork();
		if (k < 0)
		{
			perror("Error on fork.");
			exit(1);
		}
		else if (k == 0)
		{
			printf("PID = %d - PPID = %d\n", getpid(), getppid());
			f(n - 1);
		}
	}
	wait(0);
	exit(0);
}

int main(int argc, char **argv)
{
	f(3);
	return 0;
}
