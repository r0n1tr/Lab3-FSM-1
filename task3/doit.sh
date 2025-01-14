#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f clktick.vcd

# run Verilator to translate Verilog into C++, inclduing C++ tesbench
verilator -Wall --cc --trace clktick.sv  --exe clktick_tb.cpp

# build cpp project via maqke automatically generated by verilator
make -j -C obj_dir/ -f Vclktick.mk Vclktick

obj_dir/Vclktick
