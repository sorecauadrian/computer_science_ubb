import socket

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(("127.0.0.1", 8888))

server_socket.listen(1)
print("server listening on port 8888")

client_socket, client_address = server_socket.accept()
print(f"accepted connection from {client_address}")

string = client_socket.recv(1024).decode('utf-8')
reversed_string = string[::-1]

client_socket.send(reversed_string.encode('utf-8'))

client_socket.close()
server_socket.close()

