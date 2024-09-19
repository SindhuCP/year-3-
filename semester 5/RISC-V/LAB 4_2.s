.data
    Y: .word 10
    M: .word 5
    L: .word 8
    D: .word 3
    Z: .word 15
    C: .word 7
    X: .word 0

.text
    lw x1, Y        # Load Y
    lw x2, M        # Load M
    lw x3, L        # Load L
    lw x4, D        # Load D
    lw x5, Z        # Load Z
    lw x6, C        # Load C
    lw x14,X

    add x7, x1, x2  # Y + M
    sub x8, x3, x4  # L - D
    add x9, x5, x6  # Z + C
    sub x10, x4, x4 # D (redundant, just for symmetry)

    sub x11, x7, x8 # (Y + M) - (L - D)
    add x12, x11, x9 # (Y + M) - (L - D) + (Z + C)
    sub x13, x12, x4 # (Y + M) - (L - D) + (Z + C) - D

    sw x13,4(x14)