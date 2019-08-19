#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom adder.vhd counter.vhd mult.vhd mult_control.vhd mux_sel.vhd reg.vhd seven_segment_cntrl.vhd shifter.vhd multiplicador_8x8.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /clk
add wave -radix binary  /reset_a
add wave -radix binary  /start
add wave -radix dec  /dataa
add wave -radix dec  /datab
add wave -radix binary  /done_flag
add wave -radix dec  /product8x8_out
add wave -radix hex  /seg_a
add wave -radix hex  /seg_b
add wave -radix hex  /seg_c
add wave -radix hex  /seg_d
add wave -radix hex  /seg_e
add wave -radix hex  /seg_f
add wave -radix hex  /seg_g
add wave -radix hex  /seg_h
#add wave -radix hex  mul88/aout



#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps
