TARGET = Program4

SOURCE = Program4.s

NASM_FLAGS = -f elf64

$(TARGET): $(SOURCE)
	nasm $(NASM_FLAGS) -o $(TARGET).o $(SOURCE)
	ld -o $(TARGET) $(TARGET).o

clean:
	rm -f $(TARGET) $(TARGET).o


run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run
all: $(TARGET)
