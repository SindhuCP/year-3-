import socket
import time

# Simulate the scenario: Start on Wi-Fi and switch to Cellular
handoff_trigger = 5  # Simulate a handoff after 5 messages
server_address = ('10.20.201.102', 12345)  # Replace SERVER_IP with the server's IP address

# Client socket
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    client_socket.connect(server_address)
    print("Connected over Wi-Fi...")
    
    for message_count in range(1, 11):
        data = client_socket.recv(1024).decode()
        if not data:
            break
        
        print(f"Received data over Wi-Fi: {data}")
        
        if message_count == handoff_trigger:
            print("Simulating signal loss. Switching to Cellular...")
            client_socket.close()
            
            # Connect over Cellular
            client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            client_socket.connect(server_address)
            print("Connected over Cellular...")
        
        message = f"Hello from client (Cellular), message {message_count}"
        print(f"Sending data over Cellular: {message}")
        client_socket.sendall(message.encode())
except KeyboardInterrupt:
    print("Client stopped.")

finally:
    client_socket.close()
    print("Client socket closed.")
