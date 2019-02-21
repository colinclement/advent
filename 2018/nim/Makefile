PROBLEMS := $(patsubst %.nim,%.out,$(wildcard *.nim))

print-%  : ; @echo $* = $($*)
all: $(PROBLEMS)
.PHONY: all

%.out: *.nim
	nim c -d:release -o:$@ $<
