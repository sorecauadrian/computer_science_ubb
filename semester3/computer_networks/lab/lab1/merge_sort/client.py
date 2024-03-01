import socket

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect(("127.0.0.1", 8888))

string1 = input("string1: ")
string2 = input("string2: ")

client_socket.send(string1.encode('utf-8'))
client_socket.send(string2.encode('utf-8'))

result = client_socket.recv(1024).decode('utf-8')
print(f"merged and sorted result: {result}")

client_socket.close()
