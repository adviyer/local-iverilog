# Local Development with Icarus Verilog
This is a guide to local development with Icarus Verilog.
A `Makefile` has been included for convenience. 
This is primarily intended for students of [EECS 270](https://ece.engin.umich.edu/academics/course-information/course-descriptions/eecs-270/) at the University of Michigan.
Others may find this useful as well, although it is a pretty barebones guide.

## Prerequisites
Icarus Verilog (iverilog). Installation guide: https://steveicarus.github.io/iverilog/usage/installation.html

## Using the Makefile
The provided `Makefile` has some basic rules which enables local Verilog compilation and simulation.

It is important to note that this is different from the Quartus Prime compiler, and **does not support synthesis**. Compiler errors and error messages are likely to differ on occasion.

However, it is fast and convenient (compilation takes > 1 ms). 
And, more importantly, *it isn't Quartus Prime \:)*

### How to Use
1. Clone this repository
`git clone git@github.com:adviyer/local-iverilog.git`
If you don't have an SSH key set up to access Github, you would need to refer to [this tutorial](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
2. If you don't have Icarus Verilog installed, refer to [this guide](https://steveicarus.github.io/iverilog/usage/installation.html).
3. Create a new folder with your Verilog files. 
4. Copy the provided `Makefile` into your folder.

Great! Now, read the next couple of sections to figure out where you should add your source and testbench .v files to compile and simulate Verilog code locally!

An example has been provided to illustrate this process.
### Variables
The provided `Makefile` has the following variables:

`SOURCES`: source .v files

`TESTBENCH`: testbench .v file

`TOP_LEVEL_MODULE`: name of the top level module

`TOP_EXECUTABLE`: name of the executable file

### Rules
The provided `Makefile` has the following rules:

`make`: compiles `SOURCES` and `TESTBENCH` with `TOP_LEVEL_MODULE` as the top level module.

`make sim`: compiles `SOURCES` and `TESTBENCH` with `TOP_LEVEL_MODULE` as the top level module. Then, executes `TOP_EXECUTABLE`. If `TOP_LEVEL_MODULE` is a testbench, the tests defined therein will be executed.

`make clean`: removes executable (.out) files.

### Example

In the `Makefile` defined in `Example/`:
```
SOURCES ?= MAJ.v Majority.v

TESTBENCH ?= Testbench.v

TOP_LEVEL_MODULE ?= Testbench

TOP_EXECUTABLE ?= Testbench
```
When the rule `make sim` is run, the following should be the terminal output:
```
Advaits-MacBook:Example advait$ make sim
iverilog -o Testbench.out -s Testbench Testbench.v MAJ.v Majority.v
vvp ./Testbench.out
Tests Passed!!!
Testbench.v:37: $finish called at 48 (1ns)
```

If the `Makefile` is changed as follows,
`TOP_LEVEL_MODULE = Majority`

and `make sim` is run, the following should be the terminal output:
```
Advaits-MacBook:Example advait$ make sim
iverilog -o Testbench.out -s Majority Testbench.v MAJ.v Majority.v
vvp ./Testbench.out
```

As the `TOP_LEVEL_MODULE` is not a testbench, no tests are run.

`make clean` removes all .out files.

### (Optional) Useful VS Code Extensions
The following VS Code Extensions might be useful:

**Verilog-HDL/SystemVerilog/Bluespec SystemVerilog** by *mshr-h*: Verilog syntax highlighting
**Makefile Tools** by *ms-vscode*: Makefile syntax highlighting

### (Optional) Verilog Tasks and Functions
`Example/Testbench.v` contains a `task` called `check_majority`.

```
task check_majority();
begin
    #1; // delay for signals to stabilize
    if (((SW[2] && SW[1]) || (SW[2] && SW[0]) || (SW[1] && SW[0])) != LEDG[0]) begin
        $display("Test failed: SW = %b, LEDG = %b", SW, LEDG);
    end
end
endtask
```
This checks whether the outputs of the `MAJ` instance match the expected behaviour for a majority module. In addition to waveform debuggers, this is a useful tool for debugging and verifying functionality.

The `$display` function is also useful for testing modules in simulation.

Tasks can be synthesized, but are outside the scope of EECS 270 and should not be used for non-testing purposes.
`$display` is not synthesizable.


