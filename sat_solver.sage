import sage.all


NFSR_SIZE = 40
LSFR_SIZE = 61
DIFF_BIT = 43
KEY_SIZE = 80
R=BooleanPolynomialRing(4181,['k%d'%(i) for i in range (80)]+['u%d'%(i) for i in range (2000)]+['v%d'%(i) for i in range (2000)]+['n%d'%(i) for i in range (40)]+['l%d'%(i) for i in range (61)])
R.inject_variables()

def gen_params():
    #setting up the LFSR
    L1 = [ZZ.random_element(2) for i in range(LSFR_SIZE)]
    L2 = L1[:]
    L2[43]+= 1


    #setting up the NFSR
    N1 = [ZZ.random_element(2) for i in range(NFSR_SIZE)]
    N2 = N1[:]

    #setting the Key
    K = [ZZ.random_element(2) for i in range(KEY_SIZE)]

    return [L1,L2,N1,N2,K]


def gen_forward_stream(params):
    _L1 = params[0][:] ; _L2 = params[1][:] ; _N1 = params[2][:] ; _N2 = params[3][:] ; _K = params[4][:]
    _Z1 = []
    _Z2 = []

    #compute the key stream for L1, N1
    for  ind in range(KEY_SIZE):

        L_update_1= R(_L1[0]+_L1[14]+_L1[20]+_L1[34]+_L1[43]+_L1[54])
        L_update_2= R(_L2[0]+_L2[14]+_L2[20]+_L2[34]+_L2[43]+_L2[54])
        c4= (ind//16)%2
        keybit = R(_K[ind])

        N_update_1 = R(_L1[0]+ c4+ keybit+ _N1[0]+_N1[13]+_N1[19]+_N1[35]+_N1[39]+ _N1[2]*_N1[25] + _N1[3]*_N1[5] +_N1[7]*_N1[8] + _N1[14]*_N1[21] + _N1[16]*_N1[18]+ _N1[22]*_N1[24] + _N1[26]*_N1[32] + _N1[33]*_N1[36]*_N1[37]*_N1[38] + _N1[10]*_N1[11]*_N1[12]+ _N1[27]*_N1[30]*_N1[31])
        N_update_2 = R(_L2[0]+ c4+ keybit+ _N2[0]+_N2[13]+_N2[19]+_N2[35]+_N2[39]+ _N2[2]*_N2[25] + _N2[3]*_N2[5] +_N2[7]*_N2[8] + _N2[14]*_N2[21] + _N2[16]*_N2[18]+ _N2[22]*_N2[24] + _N2[26]*_N2[32] + _N2[33]*_N2[36]*_N2[37]*_N2[38] + _N2[10]*_N2[11]*_N2[12]+ _N2[27]*_N2[30]*_N2[31])

        _Z1.append( R(_L1[30] +_N1[1]+ _N1[6]+ _N1[15]+_N1[17]+_N1[23]+_N1[28]+ _N1[34]+ _N1[4]*_L1[6] + _L1[8]*_L1[10] +  _L1[32]*_L1[17] +  _L1[19]*_L1[23] + _N1[4]*_L1[32]*_N1[38]  ))
        _Z2.append( R(_L2[30] +_N2[1]+ _N2[6]+ _N2[15]+_N2[17]+_N2[23]+_N2[28]+ _N2[34]+ _N2[4]*_L2[6] + _L2[8]*_L2[10] +  _L2[32]*_L2[17] +  _L2[19]*_L2[23] + _N2[4]*_L2[32]*_N2[38]  ))

        #rotate the NSFR and LSFR

        _L1 = _L1[-1:] + _L1[:-1]
        _L2 = _L2[-1:] + _L2[:-1]
        _N1 = _N1[-1:] + _N1[:-1]
        _N2 = _N2[-1:] + _N2[:-1]

        #change the last bit of NFSR and LFSR
        _L1[LSFR_SIZE -1] = L_update_1
        _L2[LSFR_SIZE -1] = L_update_2
        _N1[NFSR_SIZE -1] = N_update_1
        _N2[NFSR_SIZE -1] = N_update_2

        # print "LSFR is:"
        # print _L1
        # print _L2

    return [_Z1,_Z2]


def gen_backward_stream(params):
    _L1 = params[0][:] ; _L2 = params[1][:] ; _N1 = params[2][:] ; _N2 = params[3][:] ; _K = params[4][:]
    _Z1 = []
    _Z2 = []



    tt=KEY_SIZE-1
    while tt >= 0:
        at=KEY_SIZE -1 -tt

        L_update_1=_L1[LSFR_SIZE -1]
        N_update_1=_N1[NFSR_SIZE -1]

        L_update_2=_L2[LSFR_SIZE -1]
        N_update_2=_N2[NFSR_SIZE -1]

        #forward shift
        _N1 = _N1[1:] + _N1[:1]
        _L1 = _L1[1:] + _L1[:1]

        _N2 = _N2[1:] + _N2[:1]
        _L2 = _L2[1:] + _L2[:1]

        tl1= R( L_update_1+ _L1[14]+ _L1[20]+ _L1[34]+ _L1[43]+ _L1[54])
        tl2= R( L_update_2+ _L2[14]+ _L2[20]+ _L2[34]+ _L2[43]+ _L2[54])

        ct= tt%80
        c4= (ct//16)%2
        kt= _K[ct]

        tn1= R(_L1[0]+ c4+ kt+ _N1[0]+  _N1[13]+_N1[19]+_N1[35]+_N1[39]+ _N1[2]*_N1[25] + _N1[3]*_N1[5] +_N1[7]*_N1[8] + _N1[14]*_N1[21] + _N1[16]*_N1[18]+ _N1[22]*_N1[24] + _N1[26]*_N1[32] + _N1[33]*_N1[36]*_N1[37]*_N1[38] + _N1[10]*_N1[11]*_N1[12]+ _N1[27]*_N1[30]*_N1[31])
        tn2= R(_L2[0]+ c4+ kt+ _N2[0]+  _N2[13]+_N2[19]+_N2[35]+_N2[39]+ _N2[2]*_N2[25] + _N2[3]*_N2[5] +_N2[7]*_N2[8] + _N2[14]*_N2[21] + _N2[16]*_N2[18]+ _N2[22]*_N2[24] + _N2[26]*_N2[32] + _N2[33]*_N2[36]*_N2[37]*_N2[38] + _N2[10]*_N2[11]*_N2[12]+ _N2[27]*_N2[30]*_N2[31])

        _Z1.append(R(_L1[30] +_N1[1]+ _N1[6]+ _N1[15]+_N1[17]+_N1[23]+_N1[28]+ _N1[34]+_N1[4]*_L1[6] + _L1[8]*_L1[10] +  _L1[32]*_L1[17] +  _L1[19]*_L1[23] + _N1[4]*_L1[32]*_N1[38] ))
        _Z2.append(R(_L2[30] +_N2[1]+ _N2[6]+ _N2[15]+_N2[17]+_N2[23]+_N2[28]+ _N2[34]+_N2[4]*_L2[6] + _L2[8]*_L2[10] +  _L2[32]*_L2[17] +  _L2[19]*_L2[23] + _N2[4]*_L2[32]*_N2[38] ))


        _L1[0]=R(tl1)
        _N1[0]=R(tn1+_L1[0]+N_update_1)


        _L2[0]=R(tl2)
        _N2[0]=R(tn2+_L2[0]+N_update_2)

        tt-=1

    return [_Z1,_Z2]


def generate_eqs(params):

    forward_streams = gen_forward_stream(params)
    backward_streams = gen_backward_stream(params)

    ZF = forward_streams[0][:]
    # ZF2 = forward_streams[1][:]

    ZB = backward_streams[0][:]
    # ZB2 = backward_streams[1][:]



    #consider Ki and Ni values as unknowns
    L = params[0][:]
    N = [R('n%d'%(i)) for i in range (NFSR_SIZE)]
    K = [R('k%d'%(i)) for i in range (KEY_SIZE)]

    #the equations obtained by the forward stream
    EQ_F = []
    EQ_B = []
    for  ind in range(KEY_SIZE):

        L_update_1= R(L[0]+L[14]+L[20]+L[34]+L[43]+L[54])
        ct = ind % 80
        c4 = (ct//16)%2
        keybit = R(K[ind])

        N_update_1 = R(L[0]+ c4+ keybit+ N[0]+N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])

        EQ_F.append( R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+ N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38] - ZF[ind] ))

        #rotate the NSFR and LSFR

        L = L[-1:] + L[:-1]

        N = N[-1:] + N[:-1]


        #change the last bit of NFSR and LFSR
        L[LSFR_SIZE -1] = L_update_1

        N[NFSR_SIZE -1] = R('v%d'%ind)
        EQ_F.append(R('v%d'%ind) - N_update_1)


    #the equations obtained by the backward stream

    #reset the LFSR NFSR
    L = params[0][:]
    N = [R('n%d'%(i)) for i in range (NFSR_SIZE)]
    K = [R('k%d'%(i)) for i in range (KEY_SIZE)]



    tt=KEY_SIZE-1
    while tt >= 0:
        at=KEY_SIZE -1 -tt

        L_update=L[LSFR_SIZE -1]
        N_update=N[NFSR_SIZE -1]

        #forward shift
        N = N[1:] + N[:1]
        L = L[1:] + L[:1]


        tl= R( L_update+ L[14]+ L[20]+ L[34]+ L[43]+ L[54])

        ct= tt%80
        clock= (ct//16)%2
        kt= K[ct]

        tn= R(L[0]+ clock+ kt+ N[0]+  N[13]+N[19]+N[35]+N[39]+ N[2]*N[25] + N[3]*N[5] +N[7]*N[8] + N[14]*N[21] + N[16]*N[18]+ N[22]*N[24] + N[26]*N[32] + N[33]*N[36]*N[37]*N[38] + N[10]*N[11]*N[12]+ N[27]*N[30]*N[31])

        EQ_B.append(R(L[30] +N[1]+ N[6]+ N[15]+N[17]+N[23]+N[28]+ N[34]+N[4]*L[6] + L[8]*L[10] +  L[32]*L[17] +  L[19]*L[23] + N[4]*L[32]*N[38] ) - ZB[KEY_SIZE -1 - tt])

        L[0]=R(tl)
        N[0]=R(L[0]+N_update+ R('v%d'%(tt+KEY_SIZE)))
        EQ_B.append( R(R('v%d'%(tt+KEY_SIZE) - tn ))
        print type(tt)
        tt = tt -1





print gen_backward_stream(gen_params())
generate_eqs(gen_params())
