# ============================================================================
# Name        : testbench.do
# Author      : Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Exemplo de script de compilação ModelSim
# ============================================================================

#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom reg16.vhd CircularQueue.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

add wave -height 31 -divider "Registers"
add wave -label clk /clk
add wave -label clear /clear
add wave -radix hex -label data_in /data_in
add wave -radix hex -label data_out /data_out
add wave -label w_flag /w_flag
add wave -label r_flag /r_flag
add wave -label empty_flag /empty_flag
add wave -label full_flag /full_flag
add wave -radix dec -label head /CircularQueue/head
add wave -radix dec -label tail /CircularQueue/tail
add wave -radix hex -label w_flag_encoder /CircularQueue/w_flag_encoder
add wave -radix hex -label registeers /CircularQueue/registers




#Simula até um 500ns
run 1000ns

wave zoomfull
write wave wave.ps
