#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
#define NUM_THREADS 5

typedef struct
{
	int index;
	int* i;
	int* cnt;
	pthread_mutex_t* mutex;
	pthread_cond_t* cond;
	char** sentence;
	char** reversed;
} data;

void* f(void* arg)
{
	data d = *((data*) arg);
	pthread_mutex_lock(d.mutex);
	while (*(d.cnt) >= 0)
	{
		strcpy(d.reversed[*(d.i)], d.sentence[*(d.cnt) - 1]);
		*(d.i) += 1;
		*(d.cnt) -= 1;
	}
	pthread_mutex_unlock(d.mutex);
	return NULL;
}

int main(int argc, char** argv)
{
	if (argc <= 6)
	{
		printf("please provide at least 6 arguments.\n");
		exit(1);
	}
	pthread_t* threads = malloc(NUM_THREADS * sizeof(pthread_t));
	char** sentence = argv;
	
	pthread_mutex_t mutex;
	pthread_cond_t cond;
	pthread_mutex_init(&mutex, NULL);
	pthread_cond_init(&cond, NULL);

	data* arguments = malloc(NUM_THREADS * sizeof(data));

	int cnt = argc;
	int i;
	int index = 0;
	char** reversed = malloc(argc * sizeof(char*));
	for (i = 0; i < NUM_THREADS; i++)
	{
		arguments[i].mutex = &mutex;
		arguments[i].cond = &cond;
		arguments[i].index = i;
		arguments[i].sentence = sentence;
		arguments[i].cnt = &cnt;
		arguments[i].reversed = reversed;
		arguments[i].i = &index;
		pthread_create(&threads[i], NULL, f, (void*) &arguments[i]);
	}
	for (i = 0; i < NUM_THREADS; i++)
		pthread_join(threads[i], NULL);
	for (i = 0; i < argc; i++)
		printf("%s ", reversed[i]);
	pthread_mutex_destroy(&mutex);
	pthread_cond_destroy(&cond);
	free(threads);
	free(arguments);
	free(reversed);
	return 0;
}

// not working!!!
