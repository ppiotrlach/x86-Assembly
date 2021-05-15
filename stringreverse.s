SYSEXIT = 1
SYSREAD = 3
SYSWRITE = 4
STDOUT = 1
EXIT_SUCCESS = 0


.text
msg_ala: .ascii "alamakota"
msg_ala_len = . - msg_ala
.global main



main:

movl $msg_ala_len, %esi


movl $msg_ala, %edi
addl $msg_ala_len, %edi
movl %edi, %ecx
#- decreases 

loop:
decl %esi
decl %ecx

movl $SYSWRITE, %eax
movl $STDOUT, %ebx
movl $1, %edx
int $0x80
 
testl $0xff, %esi
jz exit
jmp loop
#code above displays 

exit:
movl $SYSEXIT, %eax
movl $EXIT_SUCCESS, %ebx
int $0x80
