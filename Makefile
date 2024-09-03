# Makefile for local development with iverilog

# Should include all the source files
SRC_FILES ?= MAJ.v Majority.v
# Should include the testbench file
TB_FILES ?= Testbench.v
# Name of the top level module (.top file extension added for .gitignore)
TOP_EXECUTABLE ?= Testbench.top 

# Default target
all: $(TOP_EXECUTABLE)

# Compilation command
$(TOP_EXECUTABLE): $(SRC_FILES) $(TB_FILES)
	iverilog -o $(TOP_EXECUTABLE) $(TB_FILES) $(SRC_FILES)

# Simulation command
sim: $(TOP_EXECUTABLE)
	vvp ./$(TOP_EXECUTABLE)

# Clean up
clean:
	rm -f $(TOP_EXECUTABLE)

# Phony targets
.PHONY: all clean
