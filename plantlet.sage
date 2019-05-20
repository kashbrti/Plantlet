import sage.all


R=BooleanPolynomialRing(2181-22-61,['k%d'%(i) for i in range (80)]+['u%d'%(i) for i in range (1000)]+['v%d'%(i) for i in range (1000)]+['n%d'%(i) for i in range (18)])#+['l%d'%(i) for i in range (61)])
R.inject_variables()
init_Z = [0]*1000
A=[]
Nr=320
gs=45
K=[0]*80
KV=[0]*80
L = [0]*61
N = [0]*40
IL = [0]*61
NV = [0]*40
LV = [0]*61
IN = [0]*40
Z = [0]*1000
ZV = [0]*1000
U = [0]*1000
V = [0]*1000

for i in range (1000):
    U[i]=R('u%d'%(i))
    V[i]=R('v%d'%(i))

for i in range (18):
    NV[i]=R('n%d'%(i))

for i in range(18,40):
    NV[i] = R(0)

for i in range (80):
    KV[i]=R('k%d'%(i))

for i in range (61):
    LV[i]= 1#R('l%d'%(i))

# LV[2] = 0

for i in range (61):
    L[i]=LV[i]


for i in range (40):
    N[i]=NV[i]

#gs=60


#for i in range (gs):
    #L[i]=KV[i]

for i in range (80):
    K[i]=KV[i]


for tt in range(0,10):
    tl= R(L[0]+L[14]+L[20]+L[34]+L[43]+L[54])
    ct= tt%80
    c4= (ct//16)%2
    kt= K[ct]


    tn= R(c4+ kt+L[0]+N[0]+N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])
    init_Z[tt]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+ N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38]  )

    for i in range(60):
        L[i]=L[i+1]
    for i in range(39):
        N[i]=N[i+1]
    L[60]=tl
    N[39]=tn
    # print tt,":",Z[tt]

for count in range(2,10):
    A=[]
    Nr=320
    gs=45
    K=[0]*80
    KV=[0]*80
    L = [0]*61
    N = [0]*40
    IL = [0]*61
    NV = [0]*40
    LV = [0]*61
    IN = [0]*40
    Z = [0]*1000
    ZV = [0]*1000
    U = [0]*1000
    V = [0]*1000

    for i in range (1000):
        U[i]=R('u%d'%(i))
        V[i]=R('v%d'%(i))

    for i in range (18):
        NV[i]=R('n%d'%(i))

    for i in range(18,40):
        NV[i] = R(0)

    for i in range (80):
        KV[i]=R('k%d'%(i))

    for i in range (61):
        LV[i]= 1#R('l%d'%(i))

    LV[60] = 0

    for i in range (61):
        L[i]=LV[i]


    for i in range (40):
        N[i]=NV[i]

    #gs=60


    #for i in range (gs):
        #L[i]=KV[i]

    for i in range (80):
        K[i]=KV[i]


    for tt in range(0,6):
        tl= R(L[0]+L[14]+L[20]+L[34]+L[43]+L[54])
        ct= tt%80
        c4= (ct//16)%2
        kt= K[ct]


        tn= R(c4+ kt+L[0]+N[0]+N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])
        Z[tt]= R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+ N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38]  )

        for i in range(60):
            L[i]=L[i+1]
        for i in range(39):
            N[i]=N[i+1]
        L[60]=tl
        N[39]=tn
        print tt,":",R(init_Z[tt]+Z[tt])
    print "-----------------------------------"
