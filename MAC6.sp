****  Final Project: Two stage pipeline Two mode 6-bit MAC  ***

*************************************************************
*************************************************************
***************Don't touch settings below********************
*************************************************************
*************************************************************
.lib "../../umc018.l" L18U18V_TT
.vec 'MAC6.vec'

.temp 25
.op
.options brief post

***************** parameter ****************************
.global  VDD  GND
.param supply = 1.8v
.param load = 10f
.param tr = 0.2n

***************** voltage source ****************************
Vclk CLK GND pulse(0 supply 0 0.1ns 0.1ns "1*period/2-tr" "period*1")
Vd1 VDD GND supply

***************** top-circuit ****************************
XMAC6  CLK A[5] A[4] A[3] A[2] A[1] A[0]
+ B[5] B[4] B[3] B[2] B[1] B[0]
+ MODE
+ ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0]
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0] MAC6

CLOAD01 OUT[0] GND load
CLOAD02 OUT[1] GND load
CLOAD03 OUT[2] GND load
CLOAD04 OUT[3] GND load
CLOAD05 OUT[4] GND load
CLOAD06 OUT[5] GND load
CLOAD07 OUT[6] GND load
CLOAD08 OUT[7] GND load
CLOAD09 OUT[8] GND load
CLOAD10 OUT[9] GND load
CLOAD11 OUT[10] GND load
CLOAD12 OUT[11] GND load
CLOAD13 OUT[12] GND load

***************** Average Power ****************************
.meas tran Iavg avg I(Vd1) from=0ns to='100*period'
.meas Pavg param='abs(Iavg)*supply'

.tran 0.1n '210*period'

***********************************************************
***********************************************************
**************Don't touch settings above*******************
***********************************************************
***********************************************************

*** you can modify clock cycle here, remember synchronize with clock cycle in MAC6.vec **
.param period = 1.17n

*** Define your sub-circuit and self-defined parameter here , and only need to submmit this part **
.param wn = 0.44u
.param wp = 0.44u
.param ln = 0.18u
.param lp = 0.18u

.subckt MAC6 CLK
+ A[5] A[4] A[3] A[2] A[1] A[0]
+ B[5] B[4] B[3] B[2] B[1] B[0]
+ MODE
+ ACC[11] ACC[10] ACC[9]  ACC[8] ACC[7] ACC[6] ACC[5] ACC[4] ACC[3] ACC[2] ACC[1] ACC[0]
+ OUT[12] OUT[11] OUT[10] OUT[9] OUT[8] OUT[7] OUT[6] OUT[5] OUT[4] OUT[3] OUT[2] OUT[1] OUT[0]

*--------------------DFF1---------------------
Xdff1 A[5] clk AA[5] DFF
Xdff2 A[4] clk AA[4] DFF
Xdff3 A[3] clk AA[3] DFF
Xdff4 A[2] clk AA[2] DFF
Xdff5 A[1] clk AA[1] DFF
Xdff6 A[0] clk AA[0] DFF
Xdff7 B[5] clk BB[5] DFF
Xdff8 B[4] clk BB[4] DFF
Xdff9 B[3] clk BB[3] DFF
Xdff10 B[2] clk BB[2] DFF
Xdff11 B[1] clk BB[1] DFF
Xdff12 B[0] clk BB[0] DFF
Xdff13 MODE clk MODEE DFF
Xdff14 ACC[11] clk AACC[11] DFF
Xdff15 ACC[10] clk AACC[10] DFF
Xdff16 ACC[9] clk AACC[9] DFF
Xdff17 ACC[8] clk AACC[8] DFF
Xdff18 ACC[7] clk AACC[7] DFF
Xdff19 ACC[6] clk AACC[6] DFF
Xdff20 ACC[5] clk AACC[5] DFF
Xdff21 ACC[4] clk AACC[4] DFF
Xdff22 ACC[3] clk AACC[3] DFF
Xdff23 ACC[2] clk AACC[2] DFF
Xdff24 ACC[1] clk AACC[1] DFF
Xdff25 ACC[0] clk AACC[0] DFF

*--------Mode : ACC or -ACC--------
Xxor0 AACC[0] MODEE YACC[0] XOR
Xxor1 AACC[1] MODEE YACC[1] XOR
Xxor2 AACC[2] MODEE YACC[2] XOR
Xxor3 AACC[3] MODEE YACC[3] XOR
Xxor4 AACC[4] MODEE YACC[4] XOR
Xxor5 AACC[5] MODEE YACC[5] XOR
Xxor6 AACC[6] MODEE YACC[6] XOR
Xxor7 AACC[7] MODEE YACC[7] XOR
Xxor8 AACC[8] MODEE YACC[8] XOR
Xxor9 AACC[9] MODEE YACC[9] XOR
Xxor10 AACC[10] MODEE YACC[10] XOR
Xxor11 AACC[11] MODEE YACC[11] XOR

*---------Booth Encoder-----------------
Xbooth_encoder1 GND AA[0] AA[1] S[0] D[0] booth_encoder
Xbooth_encoder2 AA[1] AA[2] AA[3] S[1] D[1] booth_encoder
Xbooth_encoder3 AA[3] AA[4] AA[5] S[2] D[2] booth_encoder

*--------Booth Selector-----------------
Xbooth_selector_bs10 S[0] D[0] AA[1] BB[0] GND  P0[0] booth_selector
Xbooth_selector_bs11 S[0] D[0] AA[1] BB[1] BB[0] P0[1] booth_selector
Xbooth_selector_bs12 S[0] D[0] AA[1] BB[2] BB[1] P0[2] booth_selector
Xbooth_selector_bs13 S[0] D[0] AA[1] BB[3] BB[2] P0[3] booth_selector
Xbooth_selector_bs14 S[0] D[0] AA[1] BB[4] BB[3] P0[4] booth_selector
Xbooth_selector_bs15 S[0] D[0] AA[1] BB[5] BB[4] P0[5] booth_selector
Xbooth_selector_bs16 S[0] D[0] AA[1] BB[5] BB[5] P0[6] booth_selector

Xbooth_selector_bs20 S[1] D[1] AA[3] BB[0] GND  P1[0] booth_selector
Xbooth_selector_bs21 S[1] D[1] AA[3] BB[1] BB[0] P1[1] booth_selector
Xbooth_selector_bs22 S[1] D[1] AA[3] BB[2] BB[1] P1[2] booth_selector
Xbooth_selector_bs23 S[1] D[1] AA[3] BB[3] BB[2] P1[3] booth_selector
Xbooth_selector_bs24 S[1] D[1] AA[3] BB[4] BB[3] P1[4] booth_selector
Xbooth_selector_bs25 S[1] D[1] AA[3] BB[5] BB[4] P1[5] booth_selector
Xbooth_selector_bs26 S[1] D[1] AA[3] BB[5] BB[5] P1[6] booth_selector

Xbooth_selector_bs30 S[2] D[2] AA[5] BB[0] GND  P2[0] booth_selector
Xbooth_selector_bs31 S[2] D[2] AA[5] BB[1] BB[0] P2[1] booth_selector
Xbooth_selector_bs32 S[2] D[2] AA[5] BB[2] BB[1] P2[2] booth_selector
Xbooth_selector_bs33 S[2] D[2] AA[5] BB[3] BB[2] P2[3] booth_selector
Xbooth_selector_bs34 S[2] D[2] AA[5] BB[4] BB[3] P2[4] booth_selector
Xbooth_selector_bs35 S[2] D[2] AA[5] BB[5] BB[4] P2[5] booth_selector
Xbooth_selector_bs36 S[2] D[2] AA[5] BB[5] BB[5] P2[6] booth_selector

*-------------------CSA1----------------------
xp1_07 P0[6] P0[7] INV
xp2_07 P1[6] P1[7] INV
xp3_07 P2[6] P2[7] INV
XFA1_0 P0[0] AA[1] S10_ C10_ HA
XFA1_2 P0[2] P1[0] AA[3] S12_ C12 FA
XHA1_3 P0[3] P1[1] S13 C13 HA
XFA1_4 P0[4] P1[2] P2[0] S14 C14 FA
XFA1_5 P0[5] P1[3] P2[1] S15 C15 FA
XFA1_6 P0[6] P1[4] P2[2] S16 C16 FA
XFA1_7 P0[6] P1[5] P2[3] S17 C17 FA
XFA1_8 P0[6] P1[6] P2[4] S18 C18 FA
XFA1_9 P0[7] P1[7] P2[5] S19 C19 FA
XFA3_0 S10_ MODEE YACC[0] FOUT[0] C30_temp pseudo_FA
XFA3_1 P0[1] C10_ YACC[1] S31_temp C31_temp pseudo_FA
XHA3_2 S12_ YACC[2] S32_temp C32_temp HA
XFA3_3 S13 C12 YACC[3] S33_temp C33_temp FA
XFA2_4 S14 C13 S24_temp C24_temp HA
XHA2_5 S15 C14 S25_temp C25_temp HA
XHA2_6 S16 C15 S26_temp C26_temp HA
XHA2_7 S17 C16 S27_temp C27_temp HA
XHA2_8 S18 C17 S28_temp C28_temp HA
XHA2_9 S19 C18 S29_temp C29_temp HA
XHA2_10 P2[7] C19 S210_temp C210_temp HA

*--------------------DFF2---------------------
Xdfff1 S24_temp clk S24  DFF
Xdfff2 S25_temp clk S25 DFF
Xdfff3 S26_temp clk S26 DFF
Xdfff4 S27_temp clk S27 DFF
Xdfff5 S28_temp clk S28  DFF
Xdfff6 S29_temp clk S29 DFF
Xdfff7 S210_temp clk S210 DFF
Xdfff8 C24_temp clk C24 DFF
Xdfff9 C25_temp clk C25  DFF
Xdfff10 C26_temp clk C26  DFF
Xdfff11 C27_temp clk C27  DFF
Xdfff12 C28_temp clk C28  DFF
Xdfff13 C29_temp clk C29  DFF
Xdfff14 C210_temp clk C210  DFF
Xdfff15 S31_temp clk S31  DFF
Xdfff16 S32_temp clk S32  DFF
Xdfff17 S33_temp clk S33  DFF
Xdfff18 C30_temp clk C30  DFF
Xdfff19 C31_temp clk C31  DFF
Xdfff20 C32_temp clk C32  DFF
Xdfff21 C33_temp clk C33  DFF
Xdfff22 YACC[4] clk ZACC[4]  DFF
Xdfff23 YACC[5] clk ZACC[5]  DFF
Xdfff24 YACC[6] clk ZACC[6]  DFF
Xdfff25 YACC[7] clk ZACC[7]  DFF
Xdfff26 YACC[8] clk ZACC[8]  DFF
Xdfff27 YACC[9] clk ZACC[9]  DFF
Xdfff28 YACC[10] clk ZACC[10]  DFF
Xdfff29 YACC[11] clk ZACC[11]  DFF
Xdfff30 AA[5] clk n2  DFF
Xdfff31 FOUT[0] clk DOUT[0]  DFF

*------------------Second  Stage---------------------
XHA3_4 S24 ZACC[4] n2 S4 C4 pseudo_FA
XFA3_5 S25 C24 ZACC[5] S5 C5 pseudo_FA
XFA3_6 S26 C25 ZACC[6] S6 C6 pseudo_FA
XFA3_7 S27 C26 ZACC[7] S7 C7 pseudo_FA
XFA3_8 S28 C27 ZACC[8] S8 C8 pseudo_FA
XFA3_9 S29 C28 ZACC[9] S9 C9 pseudo_FA
XFA3_10 S210 C29 ZACC[10] S10 C10 pseudo_FA
Xfuck C210 ZACC[11] S11 C11 HA1
XRCA00 S31 C30 DOUT[1] c1 HA
XRCA01 S32 C31 c1 DOUT[2] c2 pseudo_FA
XRCA02 S33 C32 c2 DOUT[3] CIN pseudo_FA
Xfuckyou ZACC[11] ZACC[11]_inv INV
XRCA03 S4 C33 CIN DOUT[4] 444 pseudo_FA
XRCA04 S5 C4 444 DOUT[5] c55 pseudo_FA
XRCA05 S6 C5 c55 DOUT[6] c66 pseudo_FA
XRCA06 S7 C6 c66 DOUT[7] c77 pseudo_FA
XRCA07 S8 C7 c77 DOUT[8] COUT pseudo_FA

XRCA08_A S9 C8 OUT[9]!_A c99 HA
XRCA09_A S10 C9 c99 OUT[10]!_A c100 FA
XRCA10_A S11 C10 c100 OUT[11]!_A c110 FA
XRCA11_A ZACC[11]_inv C11 c110 OUT[12]!_A c121 FA

XRCA08_B S9 C8 OUT[9]!_B c99_ HA1
XRCA09_B S10 C9 c99_ OUT[10]!_B c101_ FA
XRCA10_B S11 C10 c101_ OUT[11]!_B c11_ FA
XRCA11_B ZACC[11]_inv C11 c11_ OUT[12]!_B c122_ FA

xinv COUT COUT_inv INV
xmux1 OUT[9]!_A OUT[9]!_B COUT COUT_inv DOUT[9] MUX
xmux2 OUT[10]!_A OUT[10]!_B COUT COUT_inv DOUT[10] MUX
xmux3 OUT[11]!_A OUT[11]!_B COUT COUT_inv DOUT[11] MUX
xmux4 OUT[12]!_A OUT[12]!_B COUT COUT_inv DOUT[12] MUX

*------------------------DFF3---------------------------
Xdff300 DOUT[0] clk   OUT[0] DFF
Xdff301 DOUT[1] clk   OUT[1] DFF
Xdff302 DOUT[2] clk   OUT[2] DFF
Xdff303 DOUT[3] clk   OUT[3] DFF
Xdff304 DOUT[4] clk   OUT[4] DFF
Xdff305 DOUT[5] clk   OUT[5] DFF
Xdff306 DOUT[6] clk   OUT[6] DFF
Xdff307 DOUT[7] clk   OUT[7] DFF
Xdff308 DOUT[8] clk   OUT[8] DFF
Xdff309_A DOUT[9]  clk  OUT[9] DFF
Xdff310_A DOUT[10] clk  OUT[10] DFF
Xdff311_A DOUT[11] clk  OUT[11] DFF
Xdff312_A DOUT[12] clk  OUT[12] DFF
.ends

.subckt MUX A B S SINV OUT
mn0 A SINV OUT GND N_18_G2 l=0.18u w=0.44u
mn1 B S OUT GND N_18_G2 l=0.18u w=0.44u
.ends

.subckt FA A B CIN SUM COUT
mp1 1 A VDD VDD P_18_G2 l=0.18u w=wp
mp2 2 B 1 VDD P_18_G2 l=0.18u w=wp
mp3 3 A VDD VDD P_18_G2 l=0.18u w=wp
mp4 3 B VDD VDD P_18_G2 l=0.18u w=wp
mp5 2 CIN 3 VDD P_18_G2 l=0.18u w=wp
mp6 4 CIN VDD VDD P_18_G2 l=0.18u w=wp
mp7 4 A VDD VDD P_18_G2 l=0.18u w=wp
mp8 4 B VDD VDD P_18_G2 l=0.18u w=wp
mp9 5 2 4 VDD P_18_G2 l=0.18u w=wp
mp10 6 A VDD VDD P_18_G2 l=0.18u w=wp
mp11 7 B 6 VDD P_18_G2 l=0.18u w=wp
mp12 5 CIN 7 VDD P_18_G2 l=0.18u w=wp

mn1 2 B 8 GND N_18_G2 l=0.18u w=wn
mn2 8 A GND GND N_18_G2 l=0.18u w=wn
mn3 2 CIN 9 GND N_18_G2 l=0.18u w=wn
mn4 9 A GND GND N_18_G2 l=0.18u w=wn
mn5 9 B GND GND N_18_G2 l=0.18u w=wn
mn6 5 2 10 GND N_18_G2 l=0.18u w=wn
mn7 10 CIN GND GND N_18_G2 l=0.18u w=wn
mn8 10 A GND GND N_18_G2 l=0.18u w=wn
mn9 10 B GND GND N_18_G2 l=0.18u w=wn
mn10 5 CIN 11 GND N_18_G2 l=0.18u w=wn
mn11 11 B 12 GND N_18_G2 l=0.18u w=wn
mn12 12 A GND GND N_18_G2 l=0.18u w=wn
x01 2 COUT INV
x02 5 SUM INV
.ends

.subckt pseudo_FA A B CIN SUM COUT
mp1 COUT_ GND VDD VDD P_18_G2 l=0.18u w=0.4u
MN1 COUT_ CIN 2 GND N_18_G2 l=0.18u w=0.44u
MN2 2 A GND GND N_18_G2 l=0.18u w=0.44u
MN3 2 B GND GND N_18_G2 l=0.18u w=0.44u
MN4 COUT_ A 3 GND N_18_G2 l=0.18u w=0.44u
MN5 3 B GND GND N_18_G2 l=0.18u w=0.44u

mp2 SUM_ GND VDD VDD P_18_G2 l=0.18u w=0.4u
MN6 SUM_ COUT_ 5 GND N_18_G2 l=0.18u w=0.44u
MN7 5 A GND GND N_18_G2 l=0.18u w=0.44u
MN8 5 B GND GND N_18_G2 l=0.18u w=0.44u
MN9 5 CIN GND GND N_18_G2 l=0.18u w=0.44u
MN10 SUM_ CIN 6 GND N_18_G2 l=0.18u w=0.44u
MN11 6 A 7 GND N_18_G2 l=0.18u w=0.44u
MN12 7 B GND GND N_18_G2 l=0.18u w=0.44u
x1 COUT_ COUT INV
x2 SUM_ SUM INV
.ends

.subckt HA A B SUM COUT
X1 B A SUM XOR
X2 A B 1 NAND
X3 1 COUT INV
.ends

.subckt HA1 A B SUM COUT
X0 B A SUMt XNOR
Xs SUMt SUM BUFF
X1 A B 1 NOR
X2 1 COUT INV
.ends

.subckt booth_encoder X1 X2 X3 S D
X0 X1 X2 St XOR
X1 St 1 Dt NOR
X2 X2 X3 1 XNOR
Xs St S BUFF
Xd Dt D BUFF
.ends

.subckt booth_selector S D N A A_pre OUT
x1 D A_pre 1 NAND
x2 S A 2 NAND
x3 1 2 3 NAND
x4 N 3 OUT XOR
.ends

.subckt DFF D CLK Q
M1 1 D VDD VDD P_18_G2 l=0.18u w=0.44u
M2 2 CLK 1 VDD P_18_G2 l=0.18u w=0.84u
M3 2 D GND GND N_18_G2 l=0.18u w=0.44u
M4 3 CLK VDD VDD P_18_G2 l=0.18u w=0.84u
M5 3 2 4 GND N_18_G2 l=0.18u w=0.44u
M6 4 CLK GND GND N_18_G2 l=0.18u w=0.44u
M7 Q_ 3 VDD VDD P_18_G2 l=0.18u w=0.44u
M8 Q_ CLK 5 GND N_18_G2 l=0.18u w=0.44u
M9 5 3 GND GND N_18_G2 l=0.18u w=0.44u
M10 Q Q_ VDD VDD P_18_G2 l=0.18u w=0.44u
M11 Q Q_ GND GND N_18_G2 l=0.18u w=0.44u
.ends

.subckt INV in out
Mp1 out in VDD VDD P_18_G2 w=0.44u l=lp
Mn1 out in GND GND N_18_G2 w=0.44u l=lp
.ends

.subckt NAND A B OUT
Mp1 OUT GND VDD VDD P_18_G2 w=0.3u l=lp
Mn1 OUT A 1 GND N_18_G2 w=0.44u l=ln
Mn2 1 B GND GND N_18_G2 w=0.44u l=ln
.ends

.subckt NOR A B OUT
Mp2 OUT GND VDD VDD P_18_G2 w=0.3u l=lp
Mn1 OUT A GND GND N_18_G2 w=0.44u l=ln
Mn2 OUT B GND GND N_18_G2 w=0.44u l=ln
.ends

.subckt XOR A B OUT
Mp0 A_INV A VDD VDD P_18_G2 l=lp w=0.24u 
Mn0 A_INV A GND GND N_18_G2 l=ln w=0.24u 
Mp1 OUTt B A VDD P_18_G2 l=lp w=0.44u
Mn1 OUTt B A_INV GND N_18_G2 l=ln w=0.24u
Mp2 OUTt A B VDD P_18_G2 l=lp w=0.24u
Mn2 B A_INV OUTt GND N_18_G2 l=ln w=0.24u
Xt OUTt OUT BUFF
.ends

.subckt XNOR a b out
Mp0 1 a vdd vdd P_18_G2 w=wp l=lp
Mp1 out b 1 vdd P_18_G2 w=wp l=lp
Mn0 out b a gnd N_18_G2 w=wn l=ln
Mn1 out a b gnd N_18_G2 w=wn l=ln
.ends

.subckt BUFF IN OUT
Mp1 1 GND VDD VDD P_18_G2 w=0.3u l=lp
Mn1 1 IN GND GND N_18_G2 w=0.3u l=lp
Mp2 OUT GND VDD VDD P_18_G2 w=0.52u l=lp
Mn2 OUT 1 GND GND N_18_G2 w=0.52u l=lp
.ends
.end