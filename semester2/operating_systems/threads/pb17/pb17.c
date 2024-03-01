#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

typedef struct
{
	pthread_mutex_t* mutex;
	pthread_cond_t* cond;
	int *arr, *index;
	int n;
} data;

// first thread
void* f1(void* argument)
{
	data d = *((data*) argument);
	int i;
	pthread_mutex_lock(d.mutex);
	while(*(d.index) % 2 != 0) pthread_cond_wait(d.cond, d.mutex);

	while(*(d.index) < d.n)
	{
		int nr = (random() % 51) * 2;
		d.arr[*(d.index)] = nr;
		*(d.index) += 1;

		printf("T1: ");
		for (i = 0; i < *(d.index); i++)
			printf("%d ", d.arr[i]);
		printf("\n");
		pthread_cond_signal(d.cond);
		while (*(d.index) % 2 != 0 && *(d.index) < d.n) pthread_cond_wait(d.cond, d.mutex);
	}
	pthread_cond_signal(d.cond);
	pthread_mutex_unlock(d.mutex);
	return NULL;
}

// second thread
void* f2(void* argument)
{
        data d = *((data*) argument);
        int i;
        pthread_mutex_lock(d.mutex);
        while(*(d.index) % 2 != 1) pthread_cond_wait(d.cond, d.mutex);

        while(*(d.index) < d.n)
        {
                int nr = (random() % 50) * 2 + 1;
                d.arr[*(d.index)] = nr;
                *(d.index) += 1;

                printf("T2: ");
                for (i = 0; i < *(d.index); i++)
                        printf("%d ", d.arr[i]);
                printf("\n");
                pthread_cond_signal(d.cond);
                while (*(d.index) % 2 != 1 && *(d.index) < d.n) pthread_cond_wait(d.cond, d.mutex);
        }
        pthread_cond_signal(d.cond);
        pthread_mutex_unlock(d.mutex);
        return NULL;
}


int main(int argc, char** argv)
{
	if (argc != 2)
	{
		printf("provide 1 argument!\n");
		exit(1);
	}
	srandom(time(NULL));
	int n = atoi(argv[1]);
	int* array = malloc(n * sizeof(int));
	int index = 0;

	pthread_mutex_t mutex;
	pthread_cond_t cond;
	pthread_mutex_init(&mutex, NULL);
	pthread_cond_init(&cond, NULL);

	pthread_t T[2];
	data arguments[2];
	
	arguments[0].mutex = arguments[1].mutex = &mutex;
	arguments[0].cond = arguments[1].cond = &cond;
	arguments[0].arr = arguments[1].arr = array;
	arguments[0].index = arguments[1].index = &index;
	arguments[0].n = arguments[1].n = n;

	pthread_create(&T[0], NULL, f1, (void*) &arguments[0]);
	pthread_create(&T[1], NULL, f2, (void*) &arguments[1]);

	pthread_join(T[0], NULL);
	pthread_join(T[1], NULL);

	pthread_mutex_destroy(&mutex);
	pthread_cond_destroy(&cond);

	free(array);
	return 0;
}
