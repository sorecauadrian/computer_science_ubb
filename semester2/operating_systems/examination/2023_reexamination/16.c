#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

void print_process_hierarchy(int depth) {
    // Print current process ID and parent's process ID
    pid_t pid = getpid();
    pid_t ppid = getppid();
    printf("Process ID: %d, Parent ID: %d, Depth: %d\n", pid, ppid, depth);
}

int main() {
    int i;
    
    // Initial parent process
    print_process_hierarchy(0);

    for (i = 0; i < 3; i++) {
        if (fork() > 0) {
            // Parent process after fork
            wait(0);
            wait(0);
            exit(0);
        } else {
            // Child process after fork
            print_process_hierarchy(i + 1);
        }
    }

    return 0;
}

