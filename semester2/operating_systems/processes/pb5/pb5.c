#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int contains_7_or_is_multiple_of_7(int n)
{
	if (n % 7 == 0)
		return 1;
	while (n)
	{
		if (n % 10 == 7)
			return 1;
		n /= 10;
	}
	return 0;
}

int main(int argc, char** argv)
{
	int a_to_b[2], b_to_a[2], done_pipe_a_to_b[2], done_pipe_b_to_a[2];
	if (pipe(a_to_b) < 0)
		perror("error on creating the first pipe!\n");
	if (pipe(b_to_a) < 0)
		perror("error on creating the second pipe.\n");
	if (pipe(done_pipe_a_to_b) < 0)
		perror("error on creating the done pipe.\n");
	if (pipe(done_pipe_b_to_a) < 0)
		perror("error on creating the done pipe.\n");
	int f = fork();
	if (f == -1)
	{
		perror("error on forking.\n");
		close(a_to_b[0]);
		close(a_to_b[1]);
		close(b_to_a[0]);
		close(b_to_a[1]);
		close(done_pipe_a_to_b[0]);
		close(done_pipe_a_to_b[1]);
		close(done_pipe_b_to_a[0]);
                close(done_pipe_b_to_a[1]);
		exit(1);
	}
	else if (f == 0)
	{
		// B process
		close(a_to_b[0]);
		close(b_to_a[1]);
		close(done_pipe_a_to_b[0]);
		close(done_pipe_b_to_a[1]);
		srandom(time(0));
		int n;
		int done = 0;
		while(!done)
		{
			if (read(b_to_a[0], &n, sizeof(int)) < 0)
			{
				perror("error on reading from pipe.\n");
				close(a_to_b[1]);
				close(b_to_a[0]);
				close(done_pipe_a_to_b[1]);
				close(done_pipe_b_to_a[0]);
				exit(1);
			}
			if (read(done_pipe_b_to_a[0], &done, sizeof(int)) < 0)
			{
				perror("error on reading from pipe.\n");
                                close(a_to_b[1]);
                                close(b_to_a[0]);
                                close(done_pipe_a_to_b[1]);
                                close(done_pipe_b_to_a[0]);
                                exit(1);
			}
			if (done)
				break;
			if (contains_7_or_is_multiple_of_7(n))
			{
				if (random() % 3 == 0)
				{
					done = 1;
					printf("B - %d\n", n);
				}
				else
					printf("B - boltz\n");
			}
			else
				printf("B - %d\n", n);
			
			n++;
			if (write(a_to_b[1], &n, sizeof(int)) < 0)
			{
				perror("error on writing to pipe.\n");
				close(a_to_b[1]);
				close(b_to_a[0]);
				close(done_pipe_a_to_b[1]);
				close(done_pipe_b_to_a[0]);
				exit(1);
			}
			if (write(done_pipe_a_to_b[1], &done, sizeof(int)) < 0)
			{
				perror("error on writing to pipe.\n");
                                close(a_to_b[1]);
                                close(b_to_a[0]);
                                close(done_pipe_a_to_b[1]);
                                close(done_pipe_b_to_a[0]);
                                exit(1);
			}
		}
		close(a_to_b[1]);
		close(b_to_a[0]);
		close(done_pipe_a_to_b[1]);
		close(done_pipe_b_to_a[0]);
		exit(0);
	}
	else
	{
		// A process
		close(a_to_b[1]);
		close(b_to_a[0]);
		close(done_pipe_a_to_b[1]);
		close(done_pipe_b_to_a[0]);
		srandom(time(0));
		int n = 1;
		int done = 0;
		if (contains_7_or_is_multiple_of_7(n))
                {
                	if (random() % 3 == 0)
                        {
                        	done = 1;
                                printf("A - %d\n", n);
                        }
                        else
                                printf("A - boltz\n");
                }
                else
                        printf("A - %d\n", n);
		while (!done)
		{
			n++;
			if (write(b_to_a[1], &n, sizeof(int)) < 0)
                        {
                                perror("error on writing to pipe.\n");
                                close(b_to_a[1]);
                                close(a_to_b[0]);
                                close(done_pipe_b_to_a[1]);
                                close(done_pipe_a_to_b[0]);
                                exit(1);
                        }
                        if (write(done_pipe_b_to_a[1], &done, sizeof(int)) < 0)
                        {
                                perror("error on writing to pipe.\n");
                                close(b_to_a[1]);
                                close(a_to_b[0]);
                                close(done_pipe_b_to_a[1]);
                                close(done_pipe_a_to_b[0]);
                                exit(1);
                        }
                        
			if (read(a_to_b[0], &n, sizeof(int)) < 0)
                        {
                                perror("error on reading from pipe.\n");
                                close(b_to_a[1]);
                                close(a_to_b[0]);
                                close(done_pipe_b_to_a[1]);
                                close(done_pipe_a_to_b[0]);
                                exit(1);
                        }
                        if (read(done_pipe_a_to_b[0], &done, sizeof(int)) < 0)
                        {
                                perror("error on reading from pipe.\n");
                                close(b_to_a[1]);
                                close(a_to_b[0]);
                                close(done_pipe_b_to_a[1]);
                                close(done_pipe_a_to_b[0]);
                                exit(1);
                        }
			if (contains_7_or_is_multiple_of_7(n))
                        {
                                if (random() % 3 == 0)
                                {
                                        done = 1;
					if (write(done_pipe_b_to_a[1], &done, sizeof(int)) < 0)
                        		{
                                		perror("error on writing to pipe.\n");
                                		close(b_to_a[1]);
                		                close(a_to_b[0]);
		                                close(done_pipe_b_to_a[1]);
                                		close(done_pipe_a_to_b[0]);
                		                exit(1);
		                        }

                                        printf("A - %d\n", n);
                                }
                                else
                                        printf("A - boltz\n");
                        }
                        else
                                printf("A - %d\n", n);
		}
		close(a_to_b[0]);
		close(b_to_a[1]);
		close(done_pipe_a_to_b[1]);
		close(done_pipe_b_to_a[0]);
	}
	wait(0);
	printf("game over!\n");
	return 0;
}
