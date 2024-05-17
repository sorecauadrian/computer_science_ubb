// Create two C processes (we will refer to them as A and B) that communicate via pipe. Process A keeps reading integers from standard input and sends them to process B. Process B determines the list of powers of 2 that are smaller than the received number, for each number immediately after reading it from the pipe, and sends the list of powers of 2 to process A. Process A prints the number of powers of 2 and the powers of 2 for each number as received from B. Both processes terminate after 0 is provided as input.

// Creati doua procese C (le vom numi A si B) care comunica prin pipe. Procesul A citeste intregi de la tastatura si le trimite procesului B. Procesul B determina lista de puteri ale lui 2 mai mici decat numarul primit, pentru fiecare numar imediat ce este primit prin pipe, si trimite lista de puteri a lui 2 procesului A. Procesul A afieaza numarul de puteri ale lui 2 si puterile lui 2 dupa ce sunt primite de la procesul B. Ambele processe isi incheie executia dupa ce se citeste 0.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

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

            if (num == 0) 
	    {
                printf("a: detected 0. closing...\n");
                break;
            }

            int number_of_powers;
            read(pipe_b_to_a[0], &number_of_powers, sizeof(number_of_powers));
            printf("there are %d powers of 2 less than %d: ", number_of_powers, num);

            int power;
            for (int i = 0; i < number_of_powers; i++) 
	    {
                read(pipe_b_to_a[0], &power, sizeof(power));
                printf("%d ", power);
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

                if (num == 0) 
		{
                    printf("b: detected 0. closing...\n");
                    break;
                }

                int number_of_powers = 0, power = 1;
                while (power < num)
                {
			power *= 2;
			number_of_powers++;
		}

                write(pipe_b_to_a[1], &number_of_powers, sizeof(number_of_powers));

		power = 1;
                for (int i = 0; i < number_of_powers; i++)
		{
			write(pipe_b_to_a[1], &power, sizeof(power));
			power *= 2;
		}
            }

            close(pipe_a_to_b[0]);
            close(pipe_b_to_a[1]);
            exit(0);
        } 
	else 
	{
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

