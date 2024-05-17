// creati doua procese C (le vom numi A si B) care comunica prin pipe. procesul A citeste intregi de la tastatura si le trimite procesului B. procesul B determina lista de divizori (excluzand  pe 1 si numarul in sine) pentru fiecare numar imediat ce este primit prin pipe si trimite lista de divizori procesului A. procesul A afiseaza numarul de divizori si divizorii fiecarui numar dupa ce sunt primiti de la procesul B. ambele procese isi incheie executia dupa ce se citeste un numar prim.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int is_prime(int num) 
{
    if (num <= 1) return 0;
    if (num % 2 == 0 && num > 2) return 0;
    for (int i = 3; i * i <= num; i += 3)
        if (num % i == 0) return 0;
    return 1;
}

int main() 
{
    int pipe_a_to_b[2];
    int pipe_b_to_a[2];

    if (pipe(pipe_a_to_b) == -1 || pipe(pipe_b_to_a) == -1) 
    {
        perror("error creating the pipes");
        exit(1);
    }

    int pid_a, pid_b;
    pid_a = fork();

    if (pid_a == -1) 
    {
        perror("error creating process a");
        exit(1);
    } 
    else if (pid_a == 0) 
    {
        close(pipe_a_to_b[0]);
        close(pipe_b_to_a[1]);

        while (1) 
	{
            int num;
            printf("number: ");
            scanf("%d", &num);

            write(pipe_a_to_b[1], &num, sizeof(num));

            if (is_prime(num)) 
	    {
                printf("process a detected a prime number. closing...\n");
                break;
            }

            int nr_divizori;
            read(pipe_b_to_a[0], &nr_divizori, sizeof(nr_divizori));
            printf("number of divisors: %d\n", nr_divizori);

            int divizor;
            for (int i = 0; i < nr_divizori; i++) 
	    {
                read(pipe_b_to_a[0], &divizor, sizeof(divizor));
                printf("%d ", divizor);
            }
            printf("\n");
        }

        close(pipe_a_to_b[1]);
        close(pipe_b_to_a[0]);
        exit(0);
    } 
    else 
    {
        pid_b = fork();

        if (pid_b == -1) 
	{
            perror("error creating process b");
            exit(1);
        } 
	else if (pid_b == 0) 
	{
            close(pipe_a_to_b[1]);
            close(pipe_b_to_a[0]);

            while (1) 
	    {
                int num;
                read(pipe_a_to_b[0], &num, sizeof(num));

                if (is_prime(num)) 
		{
                    printf("process b detected a prime number. closing...\n");
                    break;
                }

                int nr_divizori = 0;
                for (int i = 2; i <= num / 2; i++) 
                    if (num % i == 0)
                        nr_divizori++;

                write(pipe_b_to_a[1], &nr_divizori, sizeof(nr_divizori));

                for (int i = 2; i <= num / 2; i++)
                    if (num % i == 0)
                        write(pipe_b_to_a[1], &i, sizeof(i));
            }

            close(pipe_a_to_b[0]);
            close(pipe_b_to_a[1]);
            exit(0);
        } 
	else 
	{
            // waiting for both children to finish
            wait(NULL);
            wait(NULL);

            close(pipe_a_to_b[0]);
            close(pipe_a_to_b[1]);
            close(pipe_b_to_a[0]);
            close(pipe_b_to_a[1]);

            exit(0);
        }
    }

    return 0;
}

