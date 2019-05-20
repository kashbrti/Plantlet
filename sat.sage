import threading
import time
def test(is_correct):
    reset()
    R=BooleanPolynomialRing(4181,['k%d'%(i) for i in range (80)]+['u%d'%(i) for i in range (2000)]+['v%d'%(i) for i in range (2000)]+['n%d'%(i) for i in range (40)]+['l%d'%(i) for i in range (61)])
    R.inject_variables()
    Nloop=1
    A=[]
    Nr=80
    gsn=10
    K=[0]*80
    KV=[0]*80
    L = [0]*61
    N = [0]*40
    IL = [0]*61
    NV = [0]*40
    LV = [0]*61
    IN = [0]*40
    RG=[0]*40
    Z = [0]*2000
    ZV = [0]*2000
    U = [0]*2000
    V = [0]*2000

    for i in range (1000):
        U[i]=R('u%d'%(i))
        V[i]=R('v%d'%(i))

    for i in range (40):
        NV[i]=R('n%d'%(i))

    for i in range (61):
        LV[i]=R('l%d'%(i))

    for i in range (61):
        IL[i]=ZZ.random_element(2)


    for i in range (61):
        L[i]=IL[i]


    for i in range (40):
        IN[i]=ZZ.random_element(2)
        RG[i]=ZZ.random_element(2)
        N[i]=IN[i]



    for i in range (80):
        K[i]=ZZ.random_element(2)
        KV[i]=R('k%d'%(i))

    #forward val

    for tt in range(Nr):
        tl= R(L[0]+L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2

        kt= R(K[ct])

        tn= R(L[0]+ c4+ kt+ N[0]+N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])
        Z[tt]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+ N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38]  )

        for i in range(60):
            L[i]=L[i+1]
        for i in range(39):
            N[i]=N[i+1]
        L[60]=tl
        N[39]=tn

    #backward val

    for i in range (61):
        L[i]=IL[i]


    for i in range (40):
        N[i]=IN[i]

    tt=Nr-1
    while tt >= 0:
        at=Nr-1-tt
        lp=L[60]
        np=N[39]
        j=39
        while(j>0):
            N[j]=N[j-1]
            j=j-1
        j=60
        while(j>0):
            L[j]=L[j-1]
            j=j-1
        tl= R( lp+ L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2
        kt= K[ct]

        tn= R(L[0]+ c4+ kt+ N[0]+  N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])

        Z[Nr+at]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38] )

        L[0]=R(tl)
        N[0]=R(tn+L[0]+np)
        tt=tt-1

    #difference forward val
    # exit()

    for i in range (61):
        L[i]=IL[i]

    for i in range (40):
        N[i]=IN[i]

    L[43] = R(1+L[43])

    for tt in range(Nr):
        tl= R(L[0]+L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2

        kt= R(K[ct])

        tn= R(L[0]+ c4+ kt+ N[0]+N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])
        Z[2*Nr+tt]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+ N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38]  )

        for i in range(60):
            L[i]=L[i+1]
        for i in range(39):
            N[i]=N[i+1]
        L[60]=tl
        N[39]=tn

    #difference backward val

    for i in range (61):
        L[i]=IL[i]

    for i in range (40):
        N[i]=IN[i]

    L[43] = R(1+L[43])


    tt=Nr-1
    while tt >= 0:
        at=Nr-1-tt
        lp=L[60]
        np=N[39]
        j=39
        while(j>0):
            N[j]=N[j-1]
            j=j-1
        j=60
        while(j>0):
            L[j]=L[j-1]
            j=j-1
        tl= R( lp+ L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2
        kt= K[ct]

        tn= R(L[0]+ c4+ kt+ N[0]+  N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])

        Z[3*Nr+at]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38] )

        L[0]=R(tl)
        N[0]=R(tn+L[0]+np)
        tt=tt-1
    # exit()
    ####variables forward
    # for i in range (61):
    #     L[i]=LV[i]

    for i in range (61):
        L[i]=IL[i]

    for i in range (40):
        N[i]=NV[i]

    for i in range (40-gsn,40):
        N[i]=IN[i]



    for tt in range(Nr):
        tl= R(L[0]+L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2
        kt= KV[ct]
        tn= R(L[0]+ c4+ kt+ N[0]+N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])
        ZV[tt]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+ N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38]  )
        A.append(Z[tt]+ZV[tt])
        for i in range(60):
            L[i]=L[i+1]
        for i in range(39):
            N[i]=N[i+1]
        L[60]=tl
        N[39]=V[tt]
        #A.append(U[tt]+tl)
        A.append(V[tt]+tn)

    # exit()
    ####variables backward
    #
    # for i in range (61):
    #     L[i]=LV[i]

    for i in range (61):
        L[i]=IL[i]

    for i in range (40):
        N[i]=NV[i]
    for i in range (40-gsn,40):
        N[i]=IN[i]

    tt=Nr-1
    while tt >= 0:
        at=Nr-1-tt
        lp=L[60]
        np=N[39]
        j=39
        while(j>0):
            N[j]=N[j-1]
            j=j-1
        j=60
        while(j>0):
            L[j]=L[j-1]
            j=j-1
        tl= R( lp+ L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2
        kt= KV[ct]

        tn= R(L[0]+ c4+ kt+ N[0]+  N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])

        ZV[Nr+at]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38] )
        A.append(Z[Nr+at]+ZV[Nr+at])
        L[0]=tl
        #A.append(R(tl+U[Nr+at]))
        N[0]=V[Nr+at]
        A.append(R(tn+L[0]+np+V[Nr+at]))
        tt=tt-1


    ####variables forward diff
    L = IL[:]
    # if is_correct  :
    #     L = IL[:]
    #     L[43] += 1
    # else :
    #     L = [ZZ.random_element(2) for i in range(61)]
    # for i in range (gs):
    #     if is_correct:
    #     # L[i] = random_element(2)
    #     L[i]=IL[i]

    for i in range (40):
        N[i]=NV[i]

    for i in range (40-gsn,40):
        N[i]=IN[i]




    L[43]= R(1+L[43])

    for tt in range(Nr):
        tl= R(L[0]+L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2
        kt= KV[ct]
        tn= R(L[0]+ c4+ kt+ N[0]+N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])
        ZV[2*Nr+tt]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+ N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38]  )
        A.append(Z[2*Nr+tt]+ZV[2*Nr+tt])
        for i in range(60):
            L[i]=L[i+1]
        for i in range(39):
            N[i]=N[i+1]
        L[60]=tl
        N[39]=V[2*Nr+tt]
        #A.append(U[2*Nr+tt]+tl)
        A.append(V[2*Nr+tt]+tn)

    ####variables backward diff


    for i in range (61):
        L[i]=IL[i]

    for i in range (40):
        N[i]=NV[i]

    for i in range (40-gsn,40):
        N[i]=IN[i]


    L[43]=1+L[43]

    tt=Nr-1
    while tt >= 0:
        at=Nr-1-tt
        lp=L[60]
        np=N[39]
        j=39
        while(j>0):
            N[j]=N[j-1]
            j=j-1
        j=60
        while(j>0):
            L[j]=L[j-1]
            j=j-1
        tl= R( lp+ L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2
        kt= KV[ct]

        tn= R(L[0]+ c4+ kt+ N[0]+  N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])

        ZV[3*Nr+at]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38] )
        A.append(Z[3*Nr+at]+ZV[3*Nr+at])
        L[0]=tl
        #A.append(R(tl+U[3*Nr+at]))
        N[0]=V[3*Nr+at]
        A.append(R(tn+L[0]+np+V[3*Nr+at]))
        tt=tt-1

    print len(A)
    #print A
    tt=cputime()
    I = Ideal(A)

    import sage.sat.boolean_polynomials
    C= sage.sat.boolean_polynomials.solve(I.gens())
    print cputime(tt)

    print C


    C1=C[0]
    S1=[]

    for i in range(80):
        a=R.variable(i)
        S1.append(a)

    US=[]
    for i in range(80):
        if(K[i]!=C1[S1[i]]):
            US.append(i)



    print Set(US).cardinality()
    reset()


t1 = threading.Thread(target: test, args= true)
t2 = threading.Thread(target: test, args= true)
t3 = threading.Thread(target: test, args= true)
t4 = threading.Thread(target: test, args= true)
t5 = threading.Thread(target: test, args= true)
t6 = threading.Thread(target: test, args= true)
t7 = threading.Thread(target: test, args= true)
t8 = threading.Thread(target: test, args= true)
t9 = threading.Thread(target: test, args= true)
t10 = threading.Thread(target: test, args= true)

t1.start()
t2.start()

t1.join()
t2.join()

print "done!"
