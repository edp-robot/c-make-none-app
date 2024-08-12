#include "../lib/Unity/src/unity.h"
#include "../include/main.h"
#include "../lib/microhttpd/include/microhttpd.h"

void setUp(void) {
}

void tearDown(void) {
}

void test_request_handler(void) {
    struct MHD_Connection *connection = NULL;
    const char *url = "/";
    const char *method = "GET";
    const char *version = "HTTP/1.1";
    const char *upload_data = NULL;
    size_t upload_data_size = 0;
    void *con_cls = NULL;

    enum MHD_Result result = request_handler(NULL, connection, url, method, version, upload_data, &upload_data_size, &con_cls);
    TEST_ASSERT_EQUAL(MHD_NO, result);
}

void test_start_http_daemon(void) {
    struct MHD_Daemon *daemon = start_http_daemon();
    TEST_ASSERT_NOT_NULL(daemon);
    MHD_stop_daemon(daemon);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_request_handler);
    RUN_TEST(test_start_http_daemon);
    return UNITY_END();
}
