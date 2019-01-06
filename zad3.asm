section .data
  scan: db "%lf %c %lf", 0
  print: db "%lf", 10, 0
  a: dq 0
  b: dq 0
  op: db 0
  wynik: dq 0

section .text
  global main
  extern printf
  extern scanf

main:
    mov ebp, esp; for correct debugging
  push ebp
  mov ebp, esp
  push a
  push dword op
  push b
  push dword scan
  call scanf				;wczytanie linii do zmiennych
  add esp, 16
  mov esp, ebp
  pop ebp
  
  finit						;inicjalizacja modułu zmiennoprzecinkowego
  fld qword [b] 			;załaduj b
  fld qword [a]				;załaduj a
  
  cmp byte [op],'+'
  je add
  cmp byte [op],'-'
  je subtract
  cmp byte [op],'/'
  je divide
  cmp byte [op],'*'
  je multiply
  
  add:
    fadd
    jmp exit
  subtract:
    fsub
    jmp exit
  divide:
    fdiv
    jmp exit
  multiply:
    fmul
    jmp exit
    
exit:
  fstp qword [wynik]			;umieść wynik w zmiennej
  push ebp
  mov ebp, esp
  push dword [wynik+4]
  push dword [wynik]
  push dword print
  call printf
  add esp, 12
  mov esp, ebp
  pop ebp
  xor eax, eax
    ret