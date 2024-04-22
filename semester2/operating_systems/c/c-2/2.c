#include <stdio.h>

int main(int argc, char** argv)
{
	int v[10];
	int media = 0;
	for (int i = 0; i < 10; i++)
	{
		scanf("%d", v + i);
		media += v[i];
	}
	media /= 10;
	int minimum = v[0];
	for (int i = 1; i < 10; i++)
		if (minimum > v[i])
			minimum = v[i];
	printf("minimum: %d, media: %d", minimum, media);
	return 0;
}
