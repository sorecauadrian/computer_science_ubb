#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>

int main(int argc, char** argv)
{
	int c1_to_c2[2], c2_to_c1[2];
       	if (pipe(c1_to_c2) == -1)
	{
		perror("error on first pipe");
		exit(1);
	}
	if (pipe(c2_to_c1) == -1)
	{
		perror("error on second pipe");
		exit(1);
	}

	// first child (c1)
	int f = fork();
	if (f == -1)
		perror("error on fork");
	else if (f == 0)
	{
		close(c1_to_c2[0]);
		close(c2_to_c1[1]);
		int n;
		srandom(getpid());
		if (0 > read(c2_to_c1[0], &n, sizeof(int)))
			perror("child 1: error on reading number from pipe");
		printf("child 1 read %d\n", n);
		while (n != 10)
		{
			n = random() % 10 + 1;
			if (0 > write(c1_to_c2[1], &n, sizeof(int)))
				perror("child 1: error on writing number in pipe");
			if (n == 10)
				break;
			if (0 > read(c2_to_c1[0], &n, sizeof(int)))
				perror("child 2: error on writing number in pipe");
			printf("child 1 read %d\n", n);

		}
		close(c2_to_c1[0]);
		close(c1_to_c2[1]);
		exit(0);
	}
	// second child (c2)
        f = fork();
        if (f == -1)
                perror("error on fork");
        else if (f == 0)
        {
                close(c2_to_c1[0]);
                close(c1_to_c2[1]);
                int n = 0;
                srandom(getpid());
                if (0 > read(c1_to_c2[0], &n, sizeof(int)))
                        perror("child 2: error on reading number from pipe");
                printf("child 2 read %d\n", n);
                while (n != 10)
                {
                        n = random() % 10 + 1;
                        if (0 > write(c2_to_c1[1], &n, sizeof(int)))
                                perror("child 2: error on writing number in pipe");
                        if (n == 10)
                                break;
                        if (0 > read(c1_to_c2[0], &n, sizeof(int)))
                                perror("child 1: error on writing number in pipe");
                        printf("child 2 read %d\n", n);

                }
                close(c2_to_c1[1]);
                close(c1_to_c2[0]);
                exit(0);
        }

	wait(0);	wait(0);
	return 0;
}
