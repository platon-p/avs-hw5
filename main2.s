.data
n_value: .string "n = "
.text
    # result = n = a0
    jal solve
    mv s0 a0

    li a7 4
    la a0 n_value
    ecall

    li a7 1
    mv a0 s0
    ecall

    # exit
    li a7 10
    ecall

solve:
    addi sp sp -4
    sw ra (sp)

    # store s0, s1
    addi sp sp -8
    sw s0 4(sp)
    sw s1 0(sp)
    ###

    li s0 1 # n = 1
    li s1 1 # (n - 1)!

    loop:
    addi s0 s0 1
    mv a0 s0
    jal factorial
    divu t0 a0 s1
    bne t0 s0 endloop
    mv s1 a0
    j loop
    endloop:
    addi s0 s0 -1
    mv a0 s0

    ###
    # restore s0, s1
    lw s0 4(sp)
    lw s1 0(sp)
    addi sp sp 8

    lw ra 0(sp)
    addi sp sp 4

    ret

# n = a0
# recursive calculation n!
factorial:
    li t0 1
    bne a0 t0 calc
    ret
    calc:

    # push ra, n=a0
    addi sp sp -8
    sw ra 4(sp)
    sw a0 0(sp)

    addi a0 a0 -1
    jal factorial
    # calculate a0 = (n-1)!

    # pop ra, n=a0
    lw t0 0(sp)
    lw ra 4(sp)
    addi sp sp 8

    # n! = n * (n-1)!
    mul a0 a0 t0
    ret