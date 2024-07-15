#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <string.h>

typedef struct 
{
	char* string;
} data;

void* uppercase(void *d)
{
	int i;
	data D = *((data*) d);
	for (i = 0; i < strlen(D.string); i++)
		if (D.string[i] >= 'a' && D.string[i] <= 'z')
			D.string[i] += 'A' - 'a';
	printf("%s\n", D.string);
	return NULL;
}

int main(int argc, char** argv)
{
	int i;
	pthread_t* threads = malloc(argc * sizeof(pthread_t));
	data* d = malloc(argc * sizeof(data));
	for (i = 0; i < argc; i++)
	{
		d[i].string = argv[i];
		printf("%s\n", d[i].string);
		pthread_create(&threads[i], NULL, uppercase, (void*)&d[i]);
	}
	for (i = 0; i < argc; i++)
		pthread_join(threads[i], NULL);
	free(threads);
	free(d);
	return 0;
}
