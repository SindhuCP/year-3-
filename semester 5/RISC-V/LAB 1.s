.text 
    li x1,25
    li x2,100
    add x3, x1, x2
    mul x4, x1, x2
    li x5,3
    add x6, x4, x2
    blt x2,x1,next 
    sw x3, 3(x2)
next: j next
    