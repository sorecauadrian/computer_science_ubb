#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

int main()
{
	int a_to_b[2], b_to_a[2];
	pipe(a_to_b);
	pipe(b_to_a);
	int f = fork();
	if (f == -1)
	{
		perror("error on first fork.");
		exit(1);
	}
	else if (f == 0)
	{
		int n;
		close(a_to_b[1]);
		close(b_to_a[0]);
		srandom(time(0));
		n = random() % 150 + 50;
		while (n >= 5)
		{
			if (n % 2 == 1)
				n++;
			if (write(b_to_a[1], &n, sizeof(int)) < 0)
			{
				perror("error on sending the number to process B.\n");
				close(a_to_b[0]);
				close(b_to_a[1]);
				exit(1);
			}
			printf("A - wrote %d to pipe.\n", n);
			if (read(a_to_b[0], &n, sizeof(int)) < 0)
			{
				perror("error on reading the number from process B.\n");
				close(a_to_b[0]);
				close(b_to_a[1]);
				exit(1);
			}
			printf("A - read %d from pipe.\n", n);
		}
		printf("the final number is %d.\n", n);
		close(a_to_b[0]);
		close(b_to_a[1]);
		exit(0);
	}

	int g = fork();
	if (g == -1)
	{
		perror("error on second fork.");
		exit(1);
	}
	else if (g == 0)
	{
		int n = 200;
		close(a_to_b[0]);
		close(b_to_a[1]);
		while(n >= 5)
		{
			if (read(b_to_a[0], &n, sizeof(int)) < 0)
			{
				perror("error on reading the number from process A.\n");
				close(a_to_b[1]);
				close(b_to_a[0]);
				exit(1);
			}
			printf("B - read %d from pipe.\n", n);
			n /= 2;
			if (write(a_to_b[1], &n, sizeof(int)) < 0)
			{
				perror("error on writing the number to process A.\n");
				close(a_to_b[1]);
				close(b_to_a[0]);
				exit(1);
			}
			printf("B - wrote %d to pipe.\n", n);
		}
		exit(0);
	}
	wait(0);
	wait(0);
	return 0;
}
