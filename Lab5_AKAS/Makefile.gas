#compile
%.o: %.s
	as $< -o$@
#link
%: %.o
	ld $< -o$@
#empty
% : %.s
