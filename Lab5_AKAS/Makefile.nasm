#compile
%.o: %.s
	nasm -felf64 $< -o$@
#link
%: %.o
	ld $< -o$@
#empty
% : %.s
