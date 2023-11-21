import socket
import struct
import random
import sys
import time

if __name__ == '__main__':
    try:
        s = socket.create_connection(('localhost', 8888))
    except socket.error as msg:
        print("error: ", msg.strerror)
        exit(-1)

    finished = False
    sr = 1
    er = 2 ** 17 - 1
    random.seed()

    data = s.recv(1024)
    print(data.decode('ascii'))
    step_count = 0

    while not finished:
        myNumber = random.randint(sr, er)
        try:
            s.sendall(struct.pack('!I', myNumber))
            answer = s.recv(1)
        except socket.error as msg:
            print("error: ", msg.strerror)
            s.close()
            exit(-2)
        step_count += 1
        print('sent ', myNumber, ' answer ', answer.decode('ascii'))
        if answer == b'H':
            sr = myNumber
        if answer == b'S':
            er = myNumber
        if answer == b'G' or answer == b'L':
            finished = True
        time.sleep(0.25)
    s.close()
    if answer == b'G':
        print("i am the winner with ", myNumber, " in ", step_count, " steps")
    else:
        print("i lost!")
