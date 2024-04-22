#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
	int n;
	scanf("%d", &n);
	int** matrix = (int**) malloc(sizeof(int*) * n);
	for (int i = 0; i < n; i++)
	{
		matrix[i] = (int*) malloc(sizeof(int) * n);
		for (int j = 0; j < n; j++)
			matrix[i][j] = i * n + j + 1;
	}
	for (int j = 0; j < n; j++)
	{
		int sum = 0;
		for (int i = 0; i < n; i++)
			sum += (matrix[i][j] % 2? matrix[i][j] : 0);
		printf("%d ", sum);
	}
	for (int i = 0; i < n; i++)
		free(matrix[i]);
	free(matrix);
	return 0;
}
