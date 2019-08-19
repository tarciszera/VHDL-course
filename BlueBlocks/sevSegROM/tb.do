#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom seven_segment_cntrl.vhd seven_segment_cntrlTB.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /seg_input
add wave -radix binary  /seg_a
add wave -radix binary  /seg_b
add wave -radix binary  /seg_c
add wave -radix binary  /seg_d
add wave -radix binary  /seg_e
add wave -radix binary  /seg_f
add wave -radix binary  /seg_g

#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps
