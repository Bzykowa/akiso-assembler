;%include "io.inc"

section	.data
numToCheck dd 2
numToComp dd 2
print db "%d", 10, 0

section .text
global main
extern printf
main:
    mov ebp, esp; for correct debugging
    ;write your code here
    primeLoop:					;-------Top of loop--------------
        mov     edx, dword [numToCheck]
        cmp     edx, 10000
        je      EndLoop
        
	mov	edx, 0				;divide number we are checking
	mov	eax, dword [numToCheck]
	mov	ecx, dword [numToComp]
	div	ecx

	cmp	edx, 0				;if evenly devided, check if prime
	je	checkQuo
								;else 
	inc	dword [numToComp]
	jmp	primeLoop			;back to top if not evenly divisable

                         EndLoop:                               ;exit from loop
                                 mov	ecx, 0
			checkQuo:
				cmp	eax, 1				;remainder is 0, if quotent == 1, its prime
				je	printPrimes
				jmp	notPrime			;else, its not prime


			printPrimes:					;prints prime
				mov	eax, dword [numToCheck]
                                 push   ebp
                                 mov    ebp, esp
                                 push   ecx
                                 push   eax
                                 push   dword print
                                 call printf
                                 add    esp, 8
                                 pop    ecx
                                 mov    esp, ebp
                                 pop    ebp
                                 ;PRINT_UDEC 2, numToCheck
                                 ;NEWLINE

			notPrime:						;moves on to check next number
				mov     eax, 2
				mov	dword [numToComp], 2
				inc	dword [numToCheck]

        cmp ecx, 0
        jne	primeLoop		;_______back to top of loop_______
    
    xor eax, eax
    ret