import socket
import threading
import os
import struct

def handle_client(client_socket):
    file_path = client_socket.recv(1024).decode('utf-8')

    if os.path.exists(file_path):
        file_length = os.path.getsize(file_path)

        with open(file_path, 'rb') as file:
            file_content = file.read()

        client_socket.send(struct.pack('!Q', file_length))
        client_socket.send(file_content)
    else:
        client_socket.send(struct.pack('!Q', -1))

    client_socket.close()

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_socket.bind(("127.0.0.1", 8888))

server_socket.listen(5)
print("server listening on port 8888")

while True:
    client_socket, client_address = server_socket.accept()
    print(f"accepted connection from {client_address}")

    client_handler = threading.Thread(target=handle_client, args=(client_socket,))
    client_handler.start()