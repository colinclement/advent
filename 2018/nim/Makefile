PROBLEMS := $(patsubst %.nim,%.out,$(wildcard *.nim))

print-%  : ; @echo $* = $($*)
all: $(PROBLEMS)
.PHONY: all print-% clean

%.out: %.nim
	nim c -d:release -o:$@ $<

clean:
	rm *.out
