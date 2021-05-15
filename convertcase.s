.global main

.text
SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
EXIT_SUCCESS = 0

// for (size_t i = 0; i < alamakota.size() ; i++)
// {
//     if(alamakota[i] >= 'a' && alamakota[i] <= 'z') {
//         alamakota[i] -= 32;
//     }
//     else{
//         alamakota[i] += 32;
//     }
// }

main:

movl $buff, %edi
movl $msg_hello, %eax
xorl %esi, %esi

loop:
leal (%eax, %esi), %ebx
# great 65-90 small 97-122

cmpb $65,(%ebx)
jb small_jump

cmpb $122,(%ebx)
ja small_jump

cmpb $96, (%ebx)
ja togreater

cmpb $91, (%ebx)
jb tosmaller

small_jump:

movl %esi, %edx

movl %ebx, %esi
movl $1, %ecx
cld
movsb #esi -> edi

movl %edx, %esi


loop_continue:

incl %esi

cmpl $msg_hello_len, %esi
je exit
jmp loop

exit:
movl $SYSWRITE, %eax
movl $STDOUT, %ebx
movl $buff, %ecx
movl $msg_hello_len, %edx
int $0x80

movl $SYSEXIT, %eax
movl $EXIT_SUCCESS, %ebx
int $0x80

tosmaller:
cmpb $65, (%ebx) 
jb loop_continue

movl %esi, %edx

addb $32, (%ebx)
movl %ebx, %esi
movl $1, %ecx
cld
movsb

movl %edx, %esi #*edx +=32

jmp loop_continue

togreater:
cmpb $123, (%ebx)
ja loop_continue

movl %esi, %edx

subb $32, (%ebx)
movl %ebx, %esi
movl $1, %ecx
cld
movsb #esi -> edi

movl %edx, %esi

jmp loop_continue


.data
msg_hello: .asciz "A123lam--AKOTaa\n"
msg_hello_len = . - msg_hello

.data
buff: .byte 20