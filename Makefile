CC := clang

SRC_DIR := ./src
OBJ_DIR := ./obj
BIN_DIR := ./bin
HEADER_DIR := ./include
TEST_DIR := ./test

SRCS := $(shell find $(SRC_DIR) -name '*.c')
OBJS := $(patsubst $(SRC_DIR)/%, $(OBJ_DIR)/%, $(SRCS:.c=.o))
HEADERS := $(shell find $(HEADER_DIR) -name '*.h')
TEST_SRCS := $(shell find $(TEST_DIR) -name '*.c')
TEST_BINS := $(patsubst $(TEST_DIR)/%, $(BIN_DIR)/%, $(TEST_SRCS:.c=))
CFLAGS := -W -Wall -I$(HEADER_DIR) -g

.PHONY: build
build: $(OBJS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: test
test: $(TEST_BINS)

$(BIN_DIR)/%: $(TEST_DIR)/%.c $(OBJS)
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $< $(OBJS) -o $@

.PHONY: clean
clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.DEFAULT_GOAL := test
