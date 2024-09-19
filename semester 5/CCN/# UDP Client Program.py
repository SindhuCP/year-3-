# UDP Client Program
from socket import * 
serv_addr = "192.168.43.170" 
serv_port = 8000
client_sock = socket(AF_INET,SOCK_DGRAM) 
msg = input("Enter the text message: ") 
client_sock.sendto(msg.encode(),(serv_addr,serv_port)) 
mod_msg,s = client_sock.recvfrom(2048) 
print("From Server: ", mod_msg.decode()) 