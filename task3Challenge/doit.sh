#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f f1_fsm.vcd

# run Verilator to translate Verilog into C++, inclduing C++ tesbench
verilator -Wall --cc --trace f1_fsm.sv  --exe f1_fsm_tb.cpp

# build cpp project via maqke automatically generated by verilator
make -j -C obj_dir/ -f Vf1_fsm.mk Vf1_fsm

obj_dir/Vf1_fsm
