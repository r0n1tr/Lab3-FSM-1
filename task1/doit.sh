#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f lfsr.vcd

# run Verilator to translate Verilog into C++, inclduing C++ tesbench
verilator -Wall --cc --trace lfsr.sv  --exe lfsr_tb.cpp

# build cpp project via maqke automatically generated by verilator
make -j -C obj_dir/ -f Vlfsr.mk Vlfsr

obj_dir/Vlfsr