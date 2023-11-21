import socket
import struct
import random

# Create a socket object
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Replace the IP address with the one of your server
client_socket.connect(("127.0.0.1", 8888))

# Generate an array of random float values
n = random.randint(1, 10)
floats = [random.uniform(0.0, 1.0) for _ in range(n)]

# Send the size of the array (N)
client_socket.send(struct.pack('!I', n))

# Send the array of floats
float_data = struct.pack('!' + 'f' * n, *floats)
client_socket.send(float_data)

# Receive the size of the merge-sorted array
size_data = client_socket.recv(4)
while len(size_data) < 4:
    size_data += client_socket.recv(4 - len(size_data))

merge_sorted_size = struct.unpack('!I', size_data)[0]

# Receive the merge-sorted array
float_data = b""
while len(float_data) < 4 * merge_sorted_size:
    float_data += client_socket.recv(4 * merge_sorted_size - len(float_data))

merge_sorted_floats = struct.unpack('!' + 'f' * merge_sorted_size, float_data)

print(f"Size of merge-sorted array: {merge_sorted_size}")
print(f"Merge-sorted array: {merge_sorted_floats}")

# Close the socket
client_socket.close()
