
#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom bitToInt.vhd bitToIntTB.vhd

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -t ns work.tb

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda
add wave -radix binary  /bit
add wave -radix binary  /int


#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps
