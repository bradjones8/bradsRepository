//Bradley Jones, Mikhail Ajaj
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <math.h>

//Create my gloabal variables
float theAverage;
float theMax;
float theMin;
float theStandDev;
int g_argc = 0;

//Thread function to find average
void* avg_runner(float arg[])
{

float avg; 

int limit = g_argc-1;


for (int i = 1; i <= limit; i++)

{

	avg = avg + arg[i];
}

avg = avg/limit;
theAverage = avg;

pthread_exit(0);

}


//Thread function to find min value
void *min_runner(float arg[])
{
float min = arg[1];
int limit = g_argc - 1;
for (int i = 1; i<= limit; i++)
{

	if (min > arg[i])
	{
		min = arg[i];
	}

}

theMin = min;
pthread_exit(0);
}

//Thread function to find max value
void *max_runner(float arg[])
{
float max = arg[1];
int limit = g_argc - 1;
for (int i = 1; i<= limit; i++)
{

	if (max < arg[i])
	{
		max = arg[i];
	}

}

theMax = max;
pthread_exit(0);
}


void *standev_runner(float arg[])
{

	float sum = 0;
	float mean = 0;
	float stdev = 0; 
	int limit = g_argc - 1;
	for(int i = 1; i <= limit; i++)
		{
		sum += arg[i];
		}
	mean = sum/limit;

	for(int i = 1; i <= limit; i++)
		{
		stdev += pow((arg[i] - mean), 2);
		}
	
	theStandDev = sqrt(stdev/limit);
	pthread_exit(0);

}


int main(int argc, char *argv[])

{
//Set the global argc value
g_argc = argc;
//Create array of float type to hold the command line arguments
float numArray[argc];
for (int i = 1; i<argc; i++)
{
numArray[i] = atof(argv[i]);

}

//Thread ID's
pthread_t tid1;
pthread_t tid2;
pthread_t tid3;
pthread_t tid4;

//Create my attribute
pthread_attr_t attr;
pthread_attr_init(&attr);

//Create the threads
pthread_create(&tid1, &attr, avg_runner, numArray);
pthread_create(&tid2, &attr, min_runner, numArray);
pthread_create(&tid3, &attr, max_runner, numArray);
pthread_create(&tid4, &attr, standev_runner, numArray);
//Wait for thread to complete task
pthread_join(tid1, NULL);
pthread_join(tid2, NULL);
pthread_join(tid3, NULL);
pthread_join(tid4, NULL);
//Display the statistical data
printf("\nStatistical Report\n");
printf("--------------------\n");
printf("The Average Value is:\t\t%.0f\n", theAverage);
printf("The Minimum Value is:\t\t%.0f\n", theMin);
printf("The Maximum Value is:\t\t%.0f\n", theMax);
printf("The Standard Deviation is:\t%1.1f\n", theStandDev);

}
