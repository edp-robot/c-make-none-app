CC = gcc
CacheDIR = lib
CFLAGS = -Iinclude -Ilib/Unity/src -I$(CacheDIR)/microhttpd/include
LDFLAGS = -L$(CacheDIR)/microhttpd/lib -lmicrohttpd

SRC_DIR = src
TEST_DIR = tests
INCLUDE_DIR = include
BUILD_DIR = target

SRC_FILES = $(SRC_DIR)/main.c $(SRC_DIR)/server.c
OBJ_FILES = $(addprefix $(BUILD_DIR)/, $(notdir $(SRC_FILES:.c=.o)))

TEST_FILES = $(TEST_DIR)/test_main.c
TEST_OBJ_FILES = $(BUILD_DIR)/test_main.o $(BUILD_DIR)/unity.o $(BUILD_DIR)/server.o

EXEC = $(BUILD_DIR)/app
TEST_EXEC = $(BUILD_DIR)/test_main

.PHONY: all build test clean

all: build test

$(BUILD_DIR)/.dirstamp:
	mkdir -p $(BUILD_DIR)
	touch $(BUILD_DIR)/.dirstamp

build: $(BUILD_DIR)/.dirstamp $(EXEC)

$(EXEC): $(OBJ_FILES)
	$(CC) $^ -o $@ $(LDFLAGS)

test: $(BUILD_DIR)/.dirstamp $(TEST_EXEC)
	LD_LIBRARY_PATH=$(CacheDIR)/microhttpd/lib ./$(TEST_EXEC)

$(TEST_EXEC): $(TEST_OBJ_FILES)
	$(CC) $^ -o $@ $(CFLAGS) $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)/.dirstamp
	$(CC) -c $< -o $@ $(CFLAGS)

$(BUILD_DIR)/%.o: $(TEST_DIR)/%.c | $(BUILD_DIR)/.dirstamp
	$(CC) -c $< -o $@ $(CFLAGS)

$(BUILD_DIR)/%.o: $(CacheDIR)/Unity/src/%.c | $(BUILD_DIR)/.dirstamp
	$(CC) -c $< -o $@ $(CFLAGS)

clean:
	rm -rf $(BUILD_DIR)
