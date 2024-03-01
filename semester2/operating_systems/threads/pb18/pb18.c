#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <string.h>

void* upcase(void* argument)
{
	int i;
	char* a = *((char**)argument);
	for (i = 0; i < strlen(a); i++)
		if (a[i] >= 'a' && a[i] <= 'z')
			a[i] += 'A' - 'a';
	printf("thread finished: %s\n", a);
	return NULL;
}

int main(int argc, char** argv)
{
	int i;
	pthread_t *threads = malloc(argc * sizeof(pthread_t));
	char **arguments = malloc(argc * sizeof(char*));
	for(i = 0; i < argc; i++)
	{
		// argument[i] is a pointer to a string, as well as argv[i]
		arguments[i] = argv[i];
		// calling upcase with the argument the address of argument[i], casted as void*
		if (pthread_create(&threads[i], NULL, upcase, (void*)&arguments[i]) < 0)
			perror("error on creating threads");
	}
	// destroying the threads
	for (i = 0; i < argc; i++)
		pthread_join(threads[i], NULL);
	free(threads);
	free(arguments);
	return 0;
}
