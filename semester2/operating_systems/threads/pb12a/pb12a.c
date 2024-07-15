#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>

typedef struct
{
	int* row;
	int length;
	int sum;
} threadData;

void *sum_row(void *arg)
{
	threadData *data = (threadData*)arg;
	data -> sum = 0;
	for (int i = 0; i < data -> length; i++)
		data -> sum += data -> row[i];
	return NULL;
}

int main(int argc, char** argv)
{
	FILE *file = fopen("matrix.txt", "r");
	if (file == NULL)
	{
		printf("unable to open file\n");
		return 1;
	}
	
	int rows, cols;
	fscanf(file, "%d %d", &rows, &cols);

	int **matrix = malloc(rows * sizeof(int*));
	for (int i = 0; i < rows; i++)
		matrix[i] = malloc(cols * sizeof(int));

	for (int i = 0; i < rows; i++)
		for (int j = 0; j < cols; j++)
			fscanf(file, "%d", &matrix[i][j]);

	fclose(file);

	pthread_t *threads = malloc(rows * sizeof(pthread_t));
	threadData *thread_data = malloc(rows * sizeof(threadData));

	for (int i = 0; i < rows; i++)
	{
		thread_data[i].row = matrix[i];
		thread_data[i].length = cols;
		pthread_create(&threads[i], NULL, sum_row, &thread_data[i]);
	}

	for (int i = 0; i < rows; i++)
		pthread_join(threads[i], NULL);

	for (int i = 0; i < rows; i++)
	       printf("sum of row %d: %d\n", i, thread_data[i].sum);

	for (int i = 0; i < rows; i++)
		free(matrix[i]);
	free(matrix);
	free(threads);
	free(thread_data);

	return 0;
}
