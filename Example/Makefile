# Makefile for local development with iverilog
# Change SOURCES, TESTBENCH, TOP_LEVEL_MODULE, and TOP_EXECUTABLE to match your project

# Should include all the source files
SOURCES ?= MAJ.v Majority.v

# Should include the testbench file
TESTBENCH ?= Testbench.v

# Name of the top level module \
  If this is a testbench, the corresponding testbench file should be included in TESTBENCH. \
  The tests described in the testbench module will be run if 'make sim' is called. \
  If this is a non-testbench module, no tests will be run.
TOP_LEVEL_MODULE ?= Testbench

# Name of the top level executable (.out extension automatically appended)
TOP_EXECUTABLE ?= Testbench

# Default target
all: $(TOP_EXECUTABLE)

# Compilation command
$(TOP_EXECUTABLE): $(SOURCES) $(TESTBENCH)
	iverilog -o $(TOP_EXECUTABLE).out -s $(TOP_LEVEL_MODULE) $(TESTBENCH) $(SOURCES)

# Simulation command
sim: $(TOP_EXECUTABLE)
	vvp ./$(TOP_EXECUTABLE).out

# Clean up all .out files
clean:
	rm -f *.out

# Phony targets
.PHONY: all clean
