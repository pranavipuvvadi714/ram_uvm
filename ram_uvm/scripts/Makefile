# Filename: Makefile - Placed in the scripts/ directory

# --- Directory Paths ---
RTL_DIR  := ../rtl
SRC_DIR  := ../src
TOP_DIR  := ../top

# --- Project Configuration ---

TOP_MODULE := tb 

TEST_NAME  := ram_test 
SIMULATOR := vcs 

# --- Source File Lists ---
# All design (Verilog) files
RTL_FILES  := $(RTL_DIR)/ram_dut.v

# All SystemVerilog files (Interface, Package/Components, Top Module)
# Compiler must resolve packages (like adder_pkg) before linking the top module.
TB_FILES   := $(SRC_DIR)/ram_env.sv \
			  $(SRC_DIR)/interface.sv \
			  $(SRC_DIR)/ram_defines.svh \
			  $(SRC_DIR)/ram_env.sv \
			  $(SRC_DIR)/ram_pkg.sv \
			  $(SRC_DIR)/ram_rd_agent.sv \
			  $(SRC_DIR)/ram_rd_driver.sv \
			  $(SRC_DIR)/ram_rd_monitor.sv \
			  $(SRC_DIR)/ram_rd_seq.sv \
			  $(SRC_DIR)/ram_rd_sequencer.sv \
			  $(SRC_DIR)/ram_scoreboard.sv \
			  $(SRC_DIR)/ram_test.sv \
			  $(SRC_DIR)/ram_trans.sv \
			  $(SRC_DIR)/ram_wr_agent.sv \
			  $(SRC_DIR)/ram_wr_driver.sv \
			  $(SRC_DIR)/ram_wr_monitor.sv \
			  $(SRC_DIR)/ram_wr_seq.sv \
			  $(SRC_DIR)/ram_wr_sequencer.sv		  
              $(TOP_DIR)/testbench.sv

# --- Compiler Options ---
# -sverilog: Enable SystemVerilog
# -ntb_opts uvm: Enable UVM library
# -fullpkg: Instructs VCS to compile packages first and resolve dependencies
# +incdir+: Tell the compiler where to look for 'include files
VLOG_OPTS  := -sverilog -ntb_opts uvm -full64 -fullpkg +incdir+$(SRC_DIR) +incdir+$(TOP_DIR)

# --- Simulation Options ---
SIM_OPTS   :=  +UVM_TESTNAME=$(TEST_NAME) +UVM_VERBOSITY=UVM_LOW -l sim.log

# --- Targets ---

.PHONY: all compile sim clean

# Default target: compile and simulate
all: compile sim

# Target to compile and elaborate the design and testbench
compile:
	@echo "--- Compiling $(SIMULATOR) build for $(TOP_MODULE) ---"
	# Ensure the compilation order is correct: RTL -> Interface -> Package -> Top Module
	vcs $(VLOG_OPTS) $(RTL_FILES) $(TB_FILES) -o simv
	@echo "--- Compilation successful. Ready to simulate. ---"

# Target to run the simulation
sim:
	@echo "--- Running simulation for $(TEST_NAME) ---"
	./simv $(SIM_OPTS)

# Target to clean up generated files
clean:
	@echo "--- Cleaning up simulation files ---"
	rm -rf simv* csrc* *.log ucli.key DVEfiles* *.vpd
