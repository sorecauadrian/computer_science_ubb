import socket
import struct

# Create a socket object
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to a specific address and port
server_socket.bind(("127.0.0.1", 8888))

# Listen for incoming connections (maximum 1 connection in the queue)
server_socket.listen(1)
print("Server listening on port 8888")

# Accept a connection from a client
client_socket, client_address = server_socket.accept()
print(f"Accepted connection from {client_address}")

# Receive the first number (a) from the client
data = client_socket.recv(2)
a = struct.unpack('!H', data)[0]

# Receive the second number (b) from the client
data = client_socket.recv(2)
b = struct.unpack('!H', data)[0]

# Calculate the sum
result = a + b

# Send the result back to the client
client_socket.send(struct.pack('!H', result))

# Close the sockets
client_socket.close()
server_socket.close()
