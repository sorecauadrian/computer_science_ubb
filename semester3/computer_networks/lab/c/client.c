#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

int main(int argc, char** argv) {
    if(argc < 3){
            printf("Introduceti o adresa si un port!\n");
            return 1;
    }
    int c;
    struct sockaddr_in server;
    uint16_t sir1[100], sir2[100], sir_interclasat[201];
    uint16_t n1, n2, port;

    c = socket(AF_INET, SOCK_STREAM, 0);
    if (c < 0) {
        printf("Eroare la crearea socketului client\n");
        return 1;
    }
    port = atoi(argv[2]);
    memset(&server, 0, sizeof(server));
    server.sin_port = htons(port);
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr(argv[1]);

    if (connect(c, (struct sockaddr*)&server, sizeof(server)) < 0) {
        printf("Eroare la conectarea la server\n");
        return 1;
    }
    printf("Lungimea primului sir: ");
    scanf("%hu", &n1);
    printf("Lungimea celui de-al doilea sir: ");
    scanf("%hu", &n2);
    printf("Elementele primului sir: ");
    for(int i = 0; i < n1; ++i)
        scanf("%hu", &sir1[i]);
    printf("Elementele celui de-al doilea sir: ");
    for(int i = 0; i < n2; ++i)
        scanf("%hu", &sir2[i]);

    for(int i = 0; i < n1; ++i)
            sir1[i] = htons(sir1[i]);
    for(int i = 0; i < n2; ++i)
            sir2[i] = htons(sir2[i]);

    n1 = htons(n1);
n2 = htons(n2);
    send(c, &n1, sizeof(n1), 0);
    send(c, &n2, sizeof(n2), 0);
    n1 = ntohs(n1);
    n2 = ntohs(n2);
    send(c, sir1, n1*sizeof(sir1[0]), 0);
    send(c, sir2, n2*sizeof(sir2[0]), 0);
    recv(c, sir_interclasat, (n1+n2)*sizeof(sir_interclasat[0]), 0);

    //convertire elemente din sirul interclasat
    for(int i = 0; i < n1+n2; ++i)
            sir_interclasat[i] = ntohs(sir_interclasat[i]);
    printf("Sirul interclasat este: ");
    for(int i = 0; i < n1+n2; ++i)
            printf("%d ", sir_interclasat[i]);
    printf("\n");
    close(c);

    return 0;

}
