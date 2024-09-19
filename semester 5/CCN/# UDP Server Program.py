# UDP Server Program
from socket import *
serv_addr = "192.168.43.170"
serv_port = 8000
serv_sock = socket(AF_INET, SOCK_DGRAM)
serv_sock.bind((serv_addr, serv_port))
print("The server is ready to receive")
while 1:
    msg, client_addr = serv_sock.recvfrom(2048)
    print("Got message from", client_addr)
    mod_msg = msg. upper()
    serv_sock. sendto(mod_msg, client_addr)