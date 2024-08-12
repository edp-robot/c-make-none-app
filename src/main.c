#include "../include/main.h"
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include "../lib/microhttpd/include/microhttpd.h"

volatile sig_atomic_t stop;

void handle_signal(int signal) {
    stop = 1;
}

int main() {
    struct MHD_Daemon *daemon;

    daemon = start_http_daemon();
    if (NULL == daemon) return 1;

    printf("Starting up http-server. Available on http://localhost:8000\n");
    printf("Press Enter to stop the server...\n");

    signal(SIGINT, handle_signal);
    signal(SIGTERM, handle_signal);

    while (!stop) {
        if (getchar() == '\n') {
            break;
        }
    }

    MHD_stop_daemon(daemon);
    return 0;
}
