#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <string.h>

typedef struct 
{
	int *digits, *letters, *specials;
	pthread_mutex_t *mutexes;
	char* string;
} data;

void *f(void *arg)
{
	data d = *((data *) arg);
	int i;
	for (i = 0; i < strlen(d.string); i++)
	{
		if ((d.string[i] >= 'a' && d.string[i] <= 'z') || (d.string[i] >= 'A' && d.string[i] <= 'Z'))
		{
			pthread_mutex_lock(&d.mutexes[0]);
			(*d.letters)++;
			pthread_mutex_unlock(&d.mutexes[0]);
		}
		else if (d.string[i] >= '0' && d.string[i] <= '9')
		{
			pthread_mutex_lock(&d.mutexes[1]);
			(*d.digits)++;
			pthread_mutex_unlock(&d.mutexes[1]);
		}
		else
		{
			pthread_mutex_lock(&d.mutexes[2]);
			(*d.specials)++;
			pthread_mutex_unlock(&d.mutexes[2]);
		}
	}
	return NULL;
}

int main(int argc, char** argv)
{
	if (argc < 2)
	{
		printf("please provide at least one string as the parameter.\n");
		exit(1);
	}
	int* digits = malloc(sizeof(int));
	int* letters = malloc(sizeof(int));
	int* specials = malloc(sizeof(int));

	*digits = 0;
	*letters = 0;
	*specials = 0;

	int i;
	pthread_t* threads = malloc((argc - 1) * sizeof(pthread_t));
	data* d = malloc((argc - 1) * sizeof(data));
	pthread_mutex_t* mutexes = malloc(3 * sizeof(pthread_mutex_t));
	for (i = 0; i < 3; i++)
		if (pthread_mutex_init(&mutexes[i], NULL) < 0)
			printf("error on creating the mutexes");
	
	for (i = 0; i < argc - 1; i++)
	{
		d[i].mutexes = mutexes;
		d[i].string = argv[i + 1];
		d[i].digits = digits;
		d[i].letters = letters;
		d[i].specials = specials;
		if (pthread_create(&threads[i], NULL, f, (void *) &d[i]) < 0)
			printf("error on creating thread %d", i);
	}
	for (i = 0; i < argc - 1; i++)
		if (pthread_join(threads[i], NULL) < 0)
			printf("error waiting for thread %d", i);
	printf("total digits: %d\n total letters: %d\n total special characters: %d\n", *digits, *letters, *specials);

	for (i = 0; i < 3; i++)
		pthread_mutex_destroy(&mutexes[i]);
	free(d);
	free(threads);
	free(mutexes);
	free(digits);
	free(letters);
	free(specials);
	return 0;
}
