#include <sys/types.h>
#include <unistd.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char** argv) {
    if(argc < 2){
            printf("Introduceti un port!\n");
            return 1;
    }
    int s;
    struct sockaddr_in server, client;
    int c;
    socklen_t l;
    uint16_t port;

    s = socket(AF_INET, SOCK_STREAM, 0);
    if (s < 0) {
        printf("Eroare la crearea socketului server\n");
        return 1;
    }

    memset(&server, 0, sizeof(server));
    port = atoi(argv[1]);
    server.sin_port = htons(port);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = INADDR_ANY;

    if (bind(s, (struct sockaddr*)&server, sizeof(server)) < 0) {
        printf("Eroare la bind\n");
        return 1;
    }

    listen(s, 5);

    l = sizeof(client);
    memset(&client, 0, sizeof(client));

    while (1) {
        uint16_t sir1[100], sir2[100], sir_intercalat[201];
        uint16_t n1, n2;
        c = accept(s, (struct sockaddr*)&client, &l);
        if(fork()==0){
                printf("S-a conectat un client!\n");
                recv(c, &n1, sizeof(n1), MSG_WAITALL);
                recv(c, &n2, sizeof(n2), MSG_WAITALL);

                n1 = ntohs(n1);
                n2 = ntohs(n2);
                recv(c, sir1, n1*sizeof(uint16_t), MSG_WAITALL);
		recv(c, sir2, n2*sizeof(uint16_t), MSG_WAITALL);
                for(int i = 0; i < n1; ++i)
                        sir1[i] = ntohs(sir1[i]);
                for(int i = 0; i < n2; ++i)
                        sir2[i] = ntohs(sir2[i]);
                int i = 0, j = 0, k = 0;
                while(i < n1 && j < n2){
                        if(sir1[i] < sir2[j]){
                                sir_intercalat[k++] = sir1[i];
                                i++;
                        } else{
                                sir_intercalat[k++] = sir2[j];
                                j++;
                        }
                }
                while(i < n1)
                        sir_intercalat[k++] = sir1[i++];
                while(j < n2)
                        sir_intercalat[k++] = sir2[j++];
                for(i = 0; i < n1+n2; ++i)
                        sir_intercalat[i] = htons(sir_intercalat[i]);
                send(c, sir_intercalat, (n1+n2)*sizeof(uint16_t), 0);
                close(c);
                exit(0);
        }
    }

}
