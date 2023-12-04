#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main(int argc, char** argv)
{
	int a_to_b[2];
	int b_to_a[2];
	if (pipe(a_to_b) < 0)
	{
		perror("error on creating first pipe!\n");
		exit(1);
	}
	if (pipe(b_to_a) < 0)
	{
		perror("error on creating second pipe!\n");
		exit(1);
	}
	int f = fork();
	if (f == -1)
	{
		perror("error on forking!\n");
		exit(1);
	}
	else if (f == 0)
	{
		close(a_to_b[1]);
		close(b_to_a[0]);
		srandom(time(0));
		int n = random() % 901 + 100;
		printf("B has generated %d.\n", n);
		int m, found = 0;
		while (!found)
		{
			if (read(a_to_b[0], &m, sizeof(int)) < 0)
			{
				perror("error on reading from pipe.\n");
				close(a_to_b[0]);
				close(b_to_a[1]);
				exit(1);
			}
			printf("B has received %d, difference: %d.\n", m, abs(m - n));
			if (abs(m - n) < 50)
				found = 1;
			if (write(b_to_a[1], &found, sizeof(int)) < 0)
			{
				perror("error on writing to pipe.\n");
				close(a_to_b[0]);
				close(b_to_a[1]);
				exit(1);
			}
		}

		close(a_to_b[0]);
		close(b_to_a[1]);
		exit(0);
	}
	else
	{
		close(a_to_b[0]);
		close(b_to_a[1]);
		srandom(time(0));
		int m = random() % 1001 + 50;
		int cnt = 0, found = 0;
		while(!found)
		{
			if (write(a_to_b[1], &m, sizeof(int)) < 0)
			{
				perror("error on writing to pipe.\n");
				close(a_to_b[1]);
				close(b_to_a[0]);
				exit(1);
			}
			cnt++;
			m = random() % 1001 + 50;
			if (read(b_to_a[0], &found, sizeof(int)) < 0)
			{
				perror("error on reading from pipe.\n");
				close(a_to_b[1]);
				close(b_to_a[0]);
				exit(1);
			}
		}
		close(a_to_b[1]);
		close(b_to_a[0]);
		printf("A has generated %d numbers.\n", cnt);
	}
	wait(0);
	return 0;
}
