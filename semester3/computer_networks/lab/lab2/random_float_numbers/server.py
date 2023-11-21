import socket
import threading
import time
import random

def handle_client(client_socket, client_number, server_number):
    # Receive the client's guess
    client_guess = float(client_socket.recv(1024).decode('utf-8'))

    # Calculate the error between the server's number and the client's guess
    error = abs(server_number - client_guess)

    # Store the client's guess and error in a dictionary
    client_results[client_number] = error

    # Sleep for 10 seconds to allow other clients to connect
    time.sleep(10)

    # Check if there are no new incoming connections
    if not new_connection_event.is_set():
        # Find the client with the best (closest) guess
        best_client = min(client_results, key=client_results.get)

        # Send the result to the best client
        if best_client == client_number:
            message = f"You have the best guess with an error of {error:.2f}"
            client_socket.send(message.encode('utf-8'))
        else:
            message = "You lost!"
            client_socket.send(message.encode('utf-8'))

        # Send the result to all other clients
        for other_client_socket in client_sockets:
            if other_client_socket != client_socket:
                message = "You lost!"
                other_client_socket.send(message.encode('utf-8'))

        # Close all connections
        for sock in client_sockets:
            sock.close()

        # Set the event to indicate that the server is closing connections
        server_closing_event.set()

# Create a socket object
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to a specific address and port
server_socket.bind(("127.0.0.1", 8888))

# Listen for incoming connections
server_socket.listen(5)
print("Server listening on port 8888")

# Generate a random float number for the server
server_number = random.uniform(0.0, 1.0)
print(f"Server's random float number: {server_number:.2f}")

# Store client results in a dictionary
client_results = {}

# Store client sockets in a list
client_sockets = []

# Event to signal when a new connection is made
new_connection_event = threading.Event()

# Event to signal when the server is closing connections
server_closing_event = threading.Event()

while True:
    try:
        # Accept a connection from a client
        client_socket, client_address = server_socket.accept()
        print(f"Accepted connection from {client_address}")

        # Add the client socket to the list
        client_sockets.append(client_socket)

        # Set the event to indicate a new connection
        new_connection_event.set()

        # Start a new thread to handle the client
        client_handler = threading.Thread(target=handle_client, args=(client_socket, len(client_sockets), server_number))
        client_handler.start()

        # Clear the event to wait for the next connection
        new_connection_event.clear()

        # Wait for the server to finish processing and closing connections
        server_closing_event.wait()

        # Reset the event for the next iteration
        server_closing_event.clear()

        # Break out of the loop if the server is closing
        break

    except KeyboardInterrupt:
        print("Server shutting down.")
        break

# Close the server socket
server_socket.close()
