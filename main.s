.data
    n_value: .string "n = "
.text
    # result = n = a0
    jal solve
    mv s0 a0

    # print result (n = s0)
    li a7 4
    la a0 n_value
    ecall
    li a7 1
    mv a0 t0
    ecall
    
    # exit
    li a7 10
    ecall

solve:
    li t0 1 # n = 1
    # unsigned!
    li t1 1 # (n - 1)!
    li t2 1 # n!

    loop:
    divu t3 t2 t1
    bne t3 t0 end_loop # assert (n+1)! / n! == n
    mv t1 t2
    addi t0 t0 1
    mul t2 t1 t0
    j loop
    end_loop:

    addi t0 t0 -1
    mv a0 t0
    ret