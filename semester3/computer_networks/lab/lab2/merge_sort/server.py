import socket
import threading
import struct

def merge_sort(arr):
    if len(arr) > 1:
        mid = len(arr) // 2
        left_half = arr[:mid]
        right_half = arr[mid:]

        merge_sort(left_half)
        merge_sort(right_half)

        i = j = k = 0

        while i < len(left_half) and j < len(right_half):
            if left_half[i] < right_half[j]:
                arr[k] = left_half[i]
                i += 1
            else:
                arr[k] = right_half[j]
                j += 1
            k += 1

        while i < len(left_half):
            arr[k] = left_half[i]
            i += 1
            k += 1

        while j < len(right_half):
            arr[k] = right_half[j]
            j += 1
            k += 1

def handle_client(client_socket, client_number):
    try:
        while True:
            # Receive the size of the array (N)
            data = client_socket.recv(4)
            if not data:
                break

            n = struct.unpack('!I', data)[0]

            if n == 0:
                # If N is 0, the client is signaling the end
                break

            # Receive the array of floats
            float_data = client_socket.recv(4 * n)
            floats = list(struct.unpack('!' + 'f' * n, float_data))

            # Merge-sort the array
            merge_sort(floats)

            # Send the size of the merge-sorted array
            client_socket.send(struct.pack('!I', len(floats)))

            # Send the merge-sorted array
            float_data = struct.pack('!' + 'f' * len(floats), *floats)
            client_socket.send(float_data)

    except Exception as e:
        print(f"Error handling client {client_number}: {e}")

    finally:
        print(f"Closing connection with client {client_number}")
        # Close the client socket
        client_socket.close()


# Create a socket object
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to a specific address and port
server_socket.bind(("127.0.0.1", 8888))

# Listen for incoming connections
server_socket.listen(5)
print("Server listening on port 8888")

# Store client sockets in a list
client_sockets = []

while True:
    try:
        # Accept a connection from a client
        client_socket, client_address = server_socket.accept()
        print(f"Accepted connection from {client_address}")

        # Add the client socket to the list
        client_sockets.append(client_socket)

        # Start a new thread to handle the client
        client_handler = threading.Thread(target=handle_client, args=(client_socket, len(client_sockets)))
        client_handler.start()

    except KeyboardInterrupt:
        print("Server shutting down.")
        break

# Close all client sockets
for sock in client_sockets:
    sock.close()

# Close the server socket
server_socket.close()
