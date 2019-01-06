section .data
    scan: db "%lf", 0
    printsinh: db "sinh(x) = %lf", 10, 0
    printarcsin: db "arcsinh(x) = %lf", 10, 0
    x: dq 0
    res: dq 0
    
section .text
    global main
    extern printf
    extern scanf
main:
    ;write your code here
    push ebp                                ;ramka pamieciowa do scanf
    mov ebp, esp
    push x
    push dword scan
    call scanf				;wczytanie linii do zmiennych
    add esp, 8                              ;czyszczenie stosu
    mov esp, ebp
    pop ebp                                 ;koniec ramki
    finit                                   ;inicjacja fpu
sinh:
    fldl2e
    fld qword [x]
    fmul
    fld1
    fsub
    fld st0
    frndint
    fsub st1, st0
    fxch st1
    f2xm1
    fld1
    fadd
    fscale
    fstp st1
    
    fldl2e
    fld qword [x]
    fldz
    fld1
    fsub
    fmul
    fmul
    fld1
    fsub
    fld st0
    frndint
    fsub st1, st0
    fxch st1
    f2xm1
    fld1
    fadd
    fscale
    fstp st1
    fsub
    fstp qword [res]
    push ebp
    mov ebp, esp
    push dword [res+4]
    push dword [res]
    push dword printsinh
    call printf
    add esp, 12
    mov esp, ebp
    pop ebp
arcsinh:
    fld1
    fld qword [x]
    fld qword [x]
    fmul
    fld1
    fadd
    fsqrt
    fld qword [x]
    fadd
    fyl2x
    fldl2e
    fdiv
    fstp qword [res]
    push ebp
    mov ebp, esp
    push dword [res+4]
    push dword [res]
    push dword printarcsin
    call printf
    add esp, 12
    mov esp, ebp
    pop ebp
    
    xor eax, eax
    ret