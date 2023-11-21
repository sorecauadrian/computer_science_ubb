import random
import socket

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect(("127.0.0.1", 8888))

client_number = random.uniform(0.0, 1.0)
print(f"client's random float number: {client_number:.2f}")

client_socket.send(str(client_number).encode('utf-8'))

result = client_socket.recv(1024).decode('utf-8')
print(result)

client_socket.close()