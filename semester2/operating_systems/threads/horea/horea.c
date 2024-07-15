// i got 9.5 for this because i didn't use the barrier properly.
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

int N;
int M;
int* shared_array;
pthread_mutex_t mutex;
pthread_barrier_t barrier;

typedef struct
{
    int index;
} data;

void* thread_function(void* arg)
{
    data* d = (data*) arg;
    int index = d -> index;

    srand(time(NULL));

    pthread_mutex_lock(&mutex);

    int integer = rand() % 10 + 1;
    printf("thread %d from group %d generated the number %d\n", index, index / N, integer);
    shared_array[index / N] += integer;
        
    pthread_mutex_unlock(&mutex);

    printf("thread %d from group %d is waiting at the barrier\n", index, index / N);
    pthread_barrier_wait(&barrier);
    return NULL;
}

int main(int argc, char** argv)
{
    if (argc != 3)
    {
        printf("please provide 2 arguments\n");
        return 1;
    }
    N = atoi(argv[1]);
    M = atoi(argv[2]);

    pthread_t threads[N * M];
    data d[N * M];
    
    shared_array = malloc(N * sizeof(int));
    for (int i = 0; i < N; i++)
        shared_array[i] = 0;
    
    pthread_mutex_init(&mutex, NULL);
    pthread_barrier_init(&barrier, NULL, M);

    for (int i = 0; i < N * M; i++)
    {
        d[i].index = i;
        pthread_create(&threads[i], NULL, thread_function, &d[i]);
    }
    for (int i = 0; i < N * M; i++)
        pthread_join(threads[i], NULL);
    
    pthread_mutex_destroy(&mutex);
    pthread_barrier_destroy(&barrier);

    int max_index = 0;
    int maximum = 0;
    for (int i = 0; i < N; i++)
        if (shared_array[i] > maximum)
        {
            maximum = shared_array[i];
            max_index = i;
        }
    printf("the index with maximum value is %d\n the maximum value is %d\n", max_index, maximum);
    free(shared_array);
    return 0;
}

