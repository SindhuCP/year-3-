digits=[4,3,2,1]
s=0
for i in range(len(digits)):
    s =s+ digits[i] *(10*(len(digits)-i-1))
print(s)