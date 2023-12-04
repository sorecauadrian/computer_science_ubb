#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct
{
	pthread_mutex_t* mutex;
	int* array;
	int number;
} data;

void* f(void* arg)
{
	data d = *((data*) arg);
	pthread_mutex_lock(d.mutex);
	while (d.number)
	{
		d.array[d.number % 10] += 1;
		d.number /= 10;
	}
	pthread_mutex_unlock(d.mutex);
	return NULL;
}

int main(int argc, char** argv)
{
	if (argc < 2)
	{
		printf("please provide at least one integer as the parameter.\n");
		exit(1);
	}
	int* freq_array = malloc(10 * sizeof(int));
	int i;
	pthread_t* threads = malloc((argc - 1) * sizeof(pthread_t));
	data* d = malloc((argc - 1) * sizeof(data));
	pthread_mutex_t mutex;
	pthread_mutex_init(&mutex, NULL);
	for (i = 0; i < argc - 1; i++)
	{
		d[i].mutex = &mutex;
		d[i].array = freq_array;
		d[i].number = atoi(argv[i+1]);
		pthread_create(&threads[i], NULL, f, (void*) &d[i]);
	}
	for (i = 0; i < argc - 1; i++)
		pthread_join(threads[i], NULL);
	pthread_mutex_destroy(&mutex);
	for (i = 0; i < 10; i++)
		printf("%d ", freq_array[i]);
	printf("\n");
	free(freq_array);
	free(threads);
	free(d);
	return 0;
}
