import socket
import struct

if __name__ == '__main__':
    try:
        s = socket.create_connection(('localhost', 8888))
    except socket.error as msg:
        print("error: ", msg.strerror)
        exit(-1)

    finished = False

    data = s.recv(1024)
    print(data.decode('ascii'))

    while not finished:
        myNumber = int(input("number: "))
        try:
            s.sendall(struct.pack('!I', myNumber))
            answer = s.recv(1)
        except socket.error as msg:
            print("error: ", msg.strerror)
            s.close()
            exit(-2)
        print('sent ', myNumber, ' answer ', answer.decode('ascii'))
        if answer == b'+':
            sr = myNumber
        if answer == b'-':
            er = myNumber
        if answer == b'0':
            finished = True
    s.close()

    print("game over!")