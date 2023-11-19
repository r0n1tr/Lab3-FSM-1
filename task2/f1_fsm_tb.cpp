#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vf1_fsm.h"
#include "vbuddy.cpp"
#include <iostream>

#define MAX_SIM_CYC 1000000
#define ADDRESS_WIDTH 8
#define RAM_SZ pow(2,ADDRESS_WIDTH)

int main(int argc, char **argv, char **env) {
  int simcyc;
  int tick;

  Verilated::commandArgs(argc, argv);
  Verilated::traceEverOn(true);

  Vf1_fsm* top = new Vf1_fsm;
  VerilatedVcdC* tfp = new VerilatedVcdC;

  top->trace(tfp, 99);
  tfp->open("f1_fsm.vcd");

  if (vbdOpen() != 1) exit(-1);
  vbdHeader("L3T1: F1_FSM");
  vbdSetMode(1);
  top->clk = 1;
  top->rst = 1;
  top->en = 0;
  std::cout << "Starting sim" << std::endl;

  for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++) {
    for (tick = 0; tick < 2; tick++) {
      tfp->dump(2*simcyc+tick);
      top->clk = !top->clk;
      top->eval();
    }
    if(simcyc == 2){
      top->rst = 0;
    }
    top->en = vbdFlag();
    vbdHex(1, top->data_out & 0xF);
    vbdBar(top->data_out & 0xFF);
    vbdCycle(simcyc);

    if ((Verilated::gotFinish()) || (vbdGetkey() == 'q')) exit(0);
  }

  vbdClose();
  tfp->close();
  exit(0);
}