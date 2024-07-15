#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>

#define NUM_THREADS 5

char **words;
int num_words;

typedef struct
{
	int index;
} data;

void *thread_function(void* arg)
{
	data* d = (data*) arg;
	int index = d -> index;
	int new_index = num_words - 1 - index;

	char* temp = words[index];
	words[index] = words[new_index];
	words[new_index] = temp;

	return NULL;
}

int main(int argc, char** argv)
{
	pthread_t threads[NUM_THREADS];
	data d[NUM_THREADS];

	if (argc < 7)
	{
		printf("the sentence must contain at least 6 words.\n");
		return 1;
	}

	num_words = argc - 1;
	words = argv + 1;

	for (int i = 0; i < NUM_THREADS; i++)
	{
		d[i].index = i;
		pthread_create(&threads[i], NULL, thread_function, &d[i]);
	}

	for (int i = 0; i < NUM_THREADS; i++)
		pthread_join(threads[i], NULL);

	for (int i = 0; i < num_words; i++)
		printf("%s ", words[i]);
	printf("\n");
	return 0;
}
