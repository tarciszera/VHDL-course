#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom shifter.vhd testbench.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /shft_input
add wave -radix binary  /shft_cont
add wave -radix binary  /shft_output


#Simula até um 500ns
run 1000ns

wave zoomfull
write wave wave.ps