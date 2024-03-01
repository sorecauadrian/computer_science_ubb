import socket
import struct

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

client_socket.connect(("127.0.0.1", 8888))

file_path = input("enter the complete path to the file: ")

client_socket.send(file_path.encode('utf-8'))

file_length = struct.unpack('!Q', client_socket.recv(8))[0]

if file_length != -1:
    file_content = client_socket.recv(file_length)

    output_file_path = file_path + "-copy"
    with open(output_file_path, 'wb') as output_file:
        output_file.write(file_content)

    print(f"file content saved to: {output_file_path}")
else:
    print("file does not exist on the server")

client_socket.close()