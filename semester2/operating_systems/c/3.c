#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
	int n;
	scanf("%d", &n);
	// idk why, but it reads a '\n' character
	getchar();
	char** strings = (char**)malloc(sizeof(char*) * n);
	if (strings == NULL)
	{
		printf("memory allocation failed for strings\n");
		return 1;
	}
	for (int i = 0; i < n; i++)
	{
		strings[i] = (char*)malloc(sizeof(char) * 20);
		if (strings[i] == NULL)
		{
			printf("memory allocation failed for strings at index %d\n", i);
			return 1;
		}
		fgets(strings[i], 20 * sizeof(char), stdin);
		// removing the newline character at the end of the string
		strings[i][strcspn(strings[i], "\n")] = '\0';
	}
	for (int i = 0; i < n - 1; i++)
		for (int j = i + 1; j < n; j++)
			if (strcmp(strings[i], strings[j]) > 0)
			{
				char* aux_string = malloc(sizeof(char) * 20);
				strcpy(aux_string, strings[i]);
				strcpy(strings[i], strings[j]);
				strcpy(strings[j], aux_string);
				free(aux_string);
			}
	printf("\n");
	for (int i = 0; i < n; i++)
	{
		printf("%s\n", strings[i]);
		free(strings[i]);
	}
	free(strings);
	return 0;
}
