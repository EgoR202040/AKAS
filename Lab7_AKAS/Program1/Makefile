TARGET = num_cores
SRC_DIR = src
SRCS = $(wildcard $(SRC_DIR)/*.s)
OBJS = $(SRCS:$(SRC_DIR)/%.s=$(SRC_DIR)/%.o)
COMPILER = nasm -felf64

$(TARGET): $(OBJS)
	ld $(OBJS) -o $(TARGET)

$(SRC_DIR)/%.o: $(SRC_DIR)/%.s
	$(COMPILER) $< -o $@

clean:
	rm -f $(SRC_DIR)/*.o $(TARGET)

rebuild: clean $(TARGET)

.PHONY: all clean rebuild
all: $(TARGET)
