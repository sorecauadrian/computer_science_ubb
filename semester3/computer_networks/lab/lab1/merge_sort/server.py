import socket


def merge_sort(string):
    if len(string) > 1:
        mid = len(string) // 2
        left_half = string[:mid]
        right_half = string[mid:]

        merge_sort(left_half)
        merge_sort(right_half)

        i = j = k = 0

        while i < len(left_half) and j < len(right_half):
            if left_half[i] < right_half[j]:
                string[k] = left_half[i]
                i += 1
            else:
                string[k] = right_half[j]
                j += 1
            k += 1

        while i < len(left_half):
            string[k] = left_half[i]
            i += 1
            k += 1

        while j < len(right_half):
            string[k] = right_half[j]
            j += 1
            k += 1


def merge_sort_strings(s1, s2):
    combined_string = s1 + s2
    merge_sort(combined_string)
    return combined_string


server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(("127.0.0.1", 8888))

server_socket.listen(1)
print("server listening on port 8888")

client_socket, client_address = server_socket.accept()
print(f"accepted connection from {client_address}")

data = client_socket.recv(1024)
string1 = list(data.decode('utf-8'))
data = client_socket.recv(1024)
string2 = list(data.decode('utf-8'))

result = merge_sort_strings(string1, string2)
merged_string = ''.join(result)
client_socket.send(merged_string.encode('utf-8'))

client_socket.close()
server_socket.close()
