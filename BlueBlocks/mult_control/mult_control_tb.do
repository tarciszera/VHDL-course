#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom counter.vhd mult_control.vhd testbench.vhd

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
add wave -radix binary  /count
add wave -radix binary  /done
add wave -radix binary  /clk_ena
add wave -radix binary  /sclr_n
add wave -radix binary  /input_sel
add wave -radix binary  /shift_sel
add wave -radix binary  /state_out

#Simula até um 500ns
run 500ns

wave zoomfull
write wave wave.ps
