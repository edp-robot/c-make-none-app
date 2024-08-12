#ifndef MAIN_H
#define MAIN_H

#include "../lib/microhttpd/include/microhttpd.h"



enum MHD_Result request_handler(void *cls, struct MHD_Connection *connection,
                                const char *url, const char *method,
                                const char *version, const char *upload_data,
                                size_t *upload_data_size, void **con_cls);


struct MHD_Daemon* start_http_daemon();

#endif // MAIN_H
