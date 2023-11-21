import socket

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect(("127.0.0.1", 8888))

string = input("string: ")

client_socket.send(string.encode('utf-8'))
reversed_socket = client_socket.recv(1024).decode('utf-8')

print(string + " -> " + reversed_socket)

client_socket.close()
