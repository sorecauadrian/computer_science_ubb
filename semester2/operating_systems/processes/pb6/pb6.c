#include <stdlib.h>
#include <sys/types.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <time.h>

int main(int argc, char** argv)
{
	if (argc != 2)
	{
		printf("you have to provide the number of random numbers generated.\n");
		exit(1);
	}
	int p_to_c[2], c_to_p[2];
	pipe(p_to_c);
	pipe(c_to_p);
	int f = fork();
	if (f < 0)
	{
		perror("error on creating the child process.\n");
		exit(1);
	}
	else if (f == 0)
	{
		int n, nr, i;
		float rez = 0;
		close(p_to_c[0]);
		close(c_to_p[1]);
		if (read(c_to_p[0], &n, sizeof(int)) < 0)
		{
			perror("error on reading n.\n");
			close(p_to_c[1]);
			close(c_to_p[0]);
			exit(1);
		}
		for (i = 0; i < n; i++)
		{
			if (read(c_to_p[0], &nr, sizeof(int)) < 0)
			{
				perror("error on reading nr.\n");
				close(p_to_c[1]);
				close(c_to_p[0]);
				exit(1);
			}
			rez += nr;
		}
		rez /= n;
		if (write(p_to_c[1], &rez, sizeof(float)) < 0)
		{
			perror("error on writing the result.\n");
			close(p_to_c[1]);
			close(c_to_p[0]);
			exit(1);
		}
		close(p_to_c[1]);
		close(c_to_p[0]);
		exit(0);
	}
	else
	{
		// converting from string to int
		int n = atoi(argv[1]), i, nr;
		float rez = 0;
		close(p_to_c[1]);
		close(c_to_p[0]);
		// initialization of the seed
		srandom(time(0));
		if (write(c_to_p[1], &n, sizeof(int)) < 0)
		{
			perror("error on writing n to child.\n");
			close(p_to_c[0]);
			close(c_to_p[1]);
			exit(1);
		}
		for (i = 0; i < n; i++)
		{
			nr = random() % 100;
			printf("parent generated %d.\n", nr);
			if (write(c_to_p[1], &nr, sizeof(int)) < 0)
			{
				perror("error on writing number to child.\n");
				close(p_to_c[0]);
				close(c_to_p[1]);
				exit(1);
			}
		}
		wait(0);
		if (read(p_to_c[0], &rez, sizeof(float)) < 0)
		{
			perror("error on read result from child.\n");
			close(p_to_c[0]);
			close(c_to_p[1]);
			exit(1);
		}
		printf("average is %f.\n", rez);
		close(p_to_c[0]);
		close(c_to_p[1]);
	}
	return 0;
}
