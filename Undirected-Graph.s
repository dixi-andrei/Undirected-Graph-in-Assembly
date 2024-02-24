.data
n: .space 4
l: .asciz ""
newline: .asciz "\n"
matrix: .space  40000
m: .space 4
formatScanf: .asciz "%d"
formatPrintf: .asciz "%d "
cerinta: .space 4
vectorlegaturi: .space 400
v: .space 4
nr: .space 4
mxm: .space 4
ecx1: .space 4
ebx1: .space 4
eax1: .space 4
esi1: .space 100
edi1: .space 10000
lineindex: .space 4
columnindex: .space 4
.text
.globl main
main:
	pushl $cerinta
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	movl $matrix, %edi
	movl $vectorlegaturi, %esi
	mov n, %eax
	mull n
	mov %eax, mxm
	mov $0, %ecx
etloopmatricenula:
	cmp mxm , %ecx
	je etecx1
	movl $0, (%edi, %ecx, 4)
	inc %ecx
etecx1:
	mov $0, %ecx
etlooplegaturi:
	cmp n, %ecx
	je etecx2
	mov %ecx, ecx1

	pushl $m
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	mov m, %eax
	mov ecx1, %ecx
	movl %eax, (%esi, %ecx, 4)
	inc %ecx
	jmp etlooplegaturi
etecx2:
	mov $0, %ecx
	dec %ecx
etloopvectorlegaturi:
	mov $0, %eax
	mov %eax, nr
	inc %ecx
	mov %ecx, ecx1
	cmp n, %ecx
	je etecx3

	movl (%esi, %ecx, 4), %ebx
	mov %ebx, ebx1
	jmp etmatrice
etmatrice:
	cmp ebx1, %eax
	je etloopvectorlegaturi
	movl %esi, esi1
	movl %edi, edi1

	pushl $v
	pushl $formatScanf
	call scanf
	popl %edx
	popl %edx

	movl edi1, %edi
	movl esi1, %esi
	jmp etincmatrice
etincmatrice:
	mov n, %eax
	mov ecx1, %ecx
	mull ecx1
	add v, %eax
	movl $1, (%edi, %eax, 4)
	mov nr, %eax
	inc %eax
	mov %eax, nr
	jmp etmatrice
etecx3:
	mov $0, %ecx
etafisarematrice:
	movl $0, lineindex
	forlines:
		mov lineindex, %ecx
		cmp %ecx, n
		je etexit
		
		movl $0, columnindex
		forcolumns:
			mov columnindex, %ecx
			cmp %ecx, n
			je cont
			
			mov lineindex, %eax
			mov $0, %edx
			mull n
			add columnindex, %eax
			
			lea matrix, %edi
			movl (%edi, %eax, 4), %ebx
			
			pushl %ebx
			pushl $formatPrintf
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl columnindex
			jmp forcolumns
		cont:
			
			
			incl lineindex
			jmp forlines					
etexit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
