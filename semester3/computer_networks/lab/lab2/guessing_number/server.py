import socket
import threading
import random
import struct
import time

random.seed()
lower_bound = 1
upper_bound = 2 ** 17 - 1
myNumber = random.randint(lower_bound, upper_bound)
print("server number: ", myNumber)

mylock = threading.Lock()
clientGuessed = False
winnerThread = 0
e = threading.Event()
e.clear()
threads = []
clientCount = 0


def worker(clientSocket):
    global mylock, clientGuessed, myNumber, winnerThread, clientCount, e

    my_idcount = clientCount
    print('client #', clientCount, 'from: ', clientSocket.getpeername(), clientSocket)
    message = 'Hello client #' + str(clientCount) + ' ! You are entering the number guess competion now !'
    clientSocket.sendall(bytes(message, 'ascii'))

    while not clientGuessed:
        try:
            clientNumber = clientSocket.recv(4)
            clientNumber = struct.unpack('!I', clientNumber)[0]
            if clientNumber > myNumber:
                clientSocket.sendall(b'S')
            if clientNumber < myNumber:
                clientSocket.sendall(b'H')
            if clientNumber == myNumber:
                mylock.acquire()
                clientGuessed = True
                winnerThread = threading.get_ident()
                mylock.release()

        except socket.error as msg:
            print('Error:', msg.strerror)
            break

    if clientGuessed:
        if threading.get_ident() == winnerThread:
            clientSocket.sendall(b'G')
            print('We have a winner', clientSocket.getpeername())
            print("Thread ", my_idcount, " winner")
            e.set()
        else:
            clientSocket.sendall(b'L')
            print("Thread ", my_idcount, " looser")
    time.sleep(1)
    clientSocket.close()
    print("Worker Thread ", my_idcount, " end")


def resetSrv():
    global mylock, clientGuessed, winnerThread, myNumber, threads, e, clientCount
    while True:
        e.wait()
        for t in threads:
            t.join()
        print("all threads are finished now")
        e.clear()
        mylock.acquire()
        threads = []
        clientGuessed = False
        winnerThread = -1
        clientCount = 0
        myNumber = random.randint(lower_bound, upper_bound)
        print('Server number: ', myNumber)
        mylock.release()


if __name__ == '__main__':
    try:
        server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_socket.bind(('127.0.0.1', 8888))
        server_socket.listen(5)
    except socket.error as msg:
        print(msg.strerror)
        exit(-1)
    t = threading.Thread(target = resetSrv, daemon = True)
    t.start()
    while True:
        client_socket, addrc = server_socket.accept()
        t = threading.Thread(target=worker, args=(client_socket,))
        threads.append(t)
        clientCount += 1
        t.start()
