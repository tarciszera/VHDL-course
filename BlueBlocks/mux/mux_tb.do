#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom mux_when.vhd mux_sel.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix dec  /mux_sel
add wave -radix dec  /mux_in_a
add wave -radix dec  /mux_in_b
add wave -radix dec  /mux_outWS
add wave -radix dec  /mux_outWE


#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps
