import socket
import threading
import subprocess

def handle_client(client_socket):
    command = client_socket.recv(1024).decode('utf-8')

    try:
        result = subprocess.run(command, shell = True, capture_output = True, text = True)
        output = result.stdout
        exit_code = result.returncode
    except Exception as e:
        output = str(e)
        exit_code = -1

    response = f"output:\n{output}\nexit code: {exit_code}"
    client_socket.send(response.encode('utf-8'))
    client_socket.close()

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

server_socket.bind(("127.0.0.1", 8888))

server_socket.listen(5)
print("server listening on port 8888")

while True:
    client_socket, client_address = server_socket.accept()
    print(f"accepted connection from {client_address}")

    client_handler = threading.Thread(target=handle_client, args=(client_socket, ))
    client_handler.start()
