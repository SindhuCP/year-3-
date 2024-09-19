#include<stdio.h>

int main()
{
    int Y, M, L, D, C, Z;
    int X;
    
    printf("enter Y M L D C Z respectively");
    scanf("%d",&Y);
    scanf("%d",&M);
    scanf("%d",&L);
    scanf("%d",&D);
    scanf("%d",&C);
    scanf("%d",&Z);
    X =(Y+M)-(L+D)+(Z+C)-D;
    printf("X : %d",X);
    
    
    
    }