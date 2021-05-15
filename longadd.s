.global main

.text
SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
EXIT_SUCCESS = 0
LOOP_CONDITION = 16

main:
clc
// xorl %ecx, %ecx
movl $LOOP_CONDITION, %ecx
movl $0, %esi
decl %ecx

add_loop:
movl number1(, %ecx, 4), %eax 
movl number2(, %ecx, 4), %ebx
adc %eax, %ebx
movl %ebx, result(, %ecx, 4)

dec %ecx
js print_loop

jmp add_loop

print_loop:

movl result(, %esi, 4), %eax
push %eax
push $format
call printf
add $4, %esp
pop %eax

incl %esi
testl $LOOP_CONDITION-1, %esi
je exit

jmp print_loop

exit:
// movl 
push $flush
call printf
add $4, %esp

movl $SYSEXIT, %eax
movl $EXIT_SUCCESS, %ebx
int $0x80

.bss
.comm result, 512

// 0x804a080 <result>:     0x00000000      0xaaaaaaaa      0xbbbbbbbb      0xffffffff
// 0x804a090 <result+16>:  0x00000003      0x55555553      0x57777776      0x20000000
// 0x804a0a0 <result+32>:  0x00000003      0x55555553      0x57777776      0x20000000
// 0x804a0b0 <result+48>:  0x00000003      0x55555553      0x57777776      0x20000000 
//                         0x80000000

.data
number1: .long 0x00000001, 0xAAAAAAA9, 0xABBBBBBB, 0x10000000, 0x00000001, 0xAAAAAAA9, 0xABBBBBBB, 0x10000000, 0x00000001, 0xAAAAAAA9, 0xABBBBBBB, 0x10000000, 0x00000001, 0xAAAAAAA9, 0xABBBBBBB, 0x10000000
number2: .long 0xFFFFFFFE, 0x00000001, 0x10000000, 0xEFFFFFFF, 0x00000001, 0xAAAAAAA9, 0xABBBBBBB, 0x10000000, 0x00000001, 0xAAAAAAA9, 0xABBBBBBB, 0x10000000, 0x00000001, 0xAAAAAAA9, 0xABBBBBBB, 0x10000000
format: .asciz "%#010x "
flush: .asciz "\n"
# number2: .string "0xFFFFFFFFEEEE"
