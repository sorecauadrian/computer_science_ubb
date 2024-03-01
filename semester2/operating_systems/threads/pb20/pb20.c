#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>


typedef struct
{
	pthread_mutex_t *mutexes;
	int id;
} data;

pthread_barrier_t barrier;
int m, n;

void* f(void* argument)
{
	data d = *((data*)argument);
	int i;
	printf("thread %d is waiting...\n", d.id);
	pthread_barrier_wait(&barrier);
	for (i = 0; i < m; i++)
	{
		pthread_mutex_lock(&d.mutexes[i]);
		printf("thread %d has entered checkpoint %d\n", d.id, i);
		usleep((random() % 101 + 100) * 1000);
		pthread_mutex_unlock(&d.mutexes[i]);
	}
	printf("thread %d finished\n", d.id);
	return NULL;
}

void cleanup(pthread_t* threads, data* arguments)
{
	free(threads);
	free(arguments);
}

int main(int argc, char** argv)
{
	if (argc != 3)
	{
		printf("please provide 2 arguments!\n");
		exit(1);
	}
	n = atoi(argv[1]);
	m = atoi(argv[2]);
	pthread_t* threads = malloc(n * sizeof(pthread_t));
	data* arguments = malloc(n * sizeof(data));
	if (pthread_barrier_init(&barrier, NULL, n))
	{
		cleanup(threads, arguments);
		exit(1);
	}
	int i;
	for (i = 0; i < n; i++)
		pthread_mutex_init(arguments[i].mutexes, NULL);
	srandom(time(0));
	for (i = 0; i < n; i++)
	{
		arguments[i].id = i;
		pthread_create(&threads[i], NULL, f, (void*) &arguments[i]);
	}
	for (i = 0; i < n; i++)
		pthread_join(threads[i], NULL);
	pthread_barrier_destroy(&barrier);
	for (i = 0; i < n; i++)
		pthread_mutex_destroy(arguments[i].mutexes);
	cleanup(threads, arguments);
	return 0;
}
