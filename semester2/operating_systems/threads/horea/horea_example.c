#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

int N; 
int M; 
int shared_variable = 0; 
pthread_mutex_t mutex; 
pthread_barrier_t barrier; 

typedef struct 
{
    int index; 
    int frequency_a[20]; 
    int frequency_b[3];
} ThreadParam;

void* thread_function(void* arg) 
{
    ThreadParam* param = (ThreadParam*)arg;
    int index = param->index;
    int a, b;

    for (int i = 0; i < 20; i++)
        param->frequency_a[i] = 0;
    for (int i = 0; i < 3; i++)
        param->frequency_b[i] = 0;

    srand(time(NULL) + index);

    for (int round = 0; round < M; round++) 
    {
        a = rand() % 20 + 1;
        b = rand() % 3 + 1;

        param->frequency_a[a - 1]++;
        param->frequency_b[b - 1]++;

        pthread_mutex_lock(&mutex);
        shared_variable += a * b;
        printf("Thread %d: A = %d, B = %d, Shared Variable = %d\n", index, a, b, shared_variable);
        pthread_mutex_unlock(&mutex);

        pthread_barrier_wait(&barrier);
    }

    printf("Thread %d Frequency A: ", index);
    for (int i = 0; i < 20; i++) 
        printf("%d ", param->frequency_a[i]);
    printf("\n");

    printf("Thread %d Frequency B: ", index);
    for (int i = 0; i < 3; i++)
        printf("%d ", param->frequency_b[i]);
    printf("\n");

    return NULL;
}

int main(int argc, char* argv[]) 
{
    if (argc != 3) 
    {
        printf("insufficient number of arguments\n");
        return 1;
    }

    N = atoi(argv[1]);
    M = atoi(argv[2]);

    pthread_t threads[N];
    ThreadParam thread_params[N];

    pthread_mutex_init(&mutex, NULL);
    pthread_barrier_init(&barrier, NULL, N);

    for (int i = 0; i < N; i++) 
    {
        thread_params[i].index = i;
        if (pthread_create(&threads[i], NULL, thread_function, &thread_params[i])) 
	{
            printf("could not create thread %d\n", i);
            return 1;
        }
    }

    for (int i = 0; i < N; i++)
        pthread_join(threads[i], NULL);

    pthread_mutex_destroy(&mutex);
    pthread_barrier_destroy(&barrier);

    return 0;
}

