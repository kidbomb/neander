vsim -gui work.tb

add wave  tb/neander_ent/clock_in
add wave  tb/neander_ent/reset_in
add wave -format Literal -radix hexadecimal tb/neander_ent/data_in
add wave -format Literal -radix hexadecimal tb/neander_ent/data_out
add wave -format Literal -radix hexadecimal tb/neander_ent/address_out
add wave -format Literal -radix hexadecimal tb/neander_ent/write_enable_out
add wave -format Literal -radix hexadecimal tb/neander_ent/pc
add wave -format Literal -radix hexadecimal tb/neander_ent/ac
add wave -format Literal -radix hexadecimal tb/neander_ent/n
add wave -format Literal -radix hexadecimal tb/neander_ent/z
add wave -format Literal  tb/neander_ent/write_enable
add wave  tb/neander_ent/stall
add wave -format Literal -radix hexadecimal tb/neander_ent/opcode

add wave  tb/memory_ent/clock_in
add wave  tb/memory_ent/reset_in
add wave -format Literal -radix hexadecimal tb/memory_ent/data_in
add wave -format Literal -radix hexadecimal tb/memory_ent/data_out
add wave -format Literal -radix hexadecimal tb/memory_ent/address_in