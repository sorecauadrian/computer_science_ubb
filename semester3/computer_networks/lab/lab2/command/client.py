import socket

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

client_socket.connect(("127.0.0.1", 8888))

command = input("enter a command: ")

client_socket.send(command.encode('utf-8'))

response = client_socket.recv(4096).decode('utf-8')
print(response)

client_socket.close()