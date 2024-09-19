#include<stdio.h>

int main()
{
    int a[] ={10,23,43,56,77,54};
    int n=6;
    int max = a[0];
    int i;
    for(i=0; i<n; i++)
    {
        if(a[i]>max)
            max=a[i];
    }
    
    printf("max: %d",max);
    }