
# https://www.researchgate.net/profile/Nishita-Manohar-Hosea/publication/393945599_A_systematic_study_of_the_dipole_and_non-dipole_effects_of_photoionisation_in_the_region_of_Cooper_minimum/links/6880eb45253dcb78df875b5a/A-systematic-study-of-the-dipole-and-non-dipole-effects-of-photoionisation-in-the-region-of-Cooper-minimum.pdf
# file:///home/marchywka/Downloads/GRASP2018-manual.pdf ( file name not path lol ) 


# rm -f  modellay*
model1=model34lay1j1o
model2=model34lay2j1o

mark()
{
mjmfiletime -mark
} 
newfiles()
{
mjmfiletime -newer .
} 
after()
{
echo new files : `newfiles` | highlight -red "new files "
}
Zatom=0
nucleus()
{
rnucleus << ---xxx---
$Zatom
23
n
23
1.5
2.2
.01
---xxx---

} # nucleus

angular()
{
rangular << ---xxx---
y
---xxx---
} # angular 
estimate()
{
rwfnestimate << ---xxx---
y
2
*
---xxx---

} # estimate 

genall1in()
{

cat << ---xxx---
*
0
1s(2,i)2s(2,i)2p(6,i)3p(1,i)
1s(2,i)2s(2,i)2p(6,i)4p(1,i)
1s(2,i)2s(2,i)2p(6,i)5p(1,i)

5s,5p,5d
1,1
0
n
---xxx---
#5s,5p,5d,5f
} # genall1in


genall1()
{
genall1in | rcsfgenerate 
} # genall1

genall2in()
{

cat << ---xxx---
*
0
1s(2,i)2s(2,i)2p(6,i)3s(1,*)
1s(2,i)2s(2,i)2p(6,i)3p(1,*)
1s(2,i)2s(2,i)2p(6,i)3d(1,*)
1s(2,i)2s(2,i)2p(6,i)4s(1,*)

5s,5p,5d
1,1
1
n
---xxx---
#6s,5p,5d,5f
} # genall2in


genall2()
{
genall2in | rcsfgenerate 
} # genall2

genall2bin()
{

cat << ---xxx---
*
0
1s(2,i)2s(2,i)2p(6,4)3p(1,*)
1s(2,i)2s(2,i)2p(6,4)4p(1,*)
1s(2,i)2s(2,i)2p(6,4)5p(1,*)

5s,5p,5d
1,1
2
n
---xxx---
#3s,3p
#6s,5p,5d,5f
#4s,3p,3d
} # genall2in

genall2b()
{
genall2bin | rcsfgenerate 
} # genall2




rmcdhf1()
{
echo rmcdhf now uses mjm auto numbering 

# mpirun -np 4 rmcdhf_mpi << ---xxx---
rmcdhf << ---xxx---
y
1 2
1
1
1
1
5
 1s 2s 3s 3p- 3p  3d- 3d 4s
*
 
1000
---xxx---
# 1s 2s 3s 3p- 3p  3d- 3d 4s 4p- 4p 4d- 4d 4f- 4f 5s
} # rmcdhf1


mynahf()
{
if [ "$2" == "" ]
then 
return -1
fi
if [ -e "$2" ]
then
rm "$2"
fi

mark
# /home/ubuntu/dev/grasp/grasp-2018-12-03/bin/hf << ---xxx---
hf << ---xxx---
Na,AV,$Zatom
  1s  2s  2p
$1
all
y
y
n
n
---xxx---
xxx="$?"
echo "rc="   $xxx
cp wfn.out "$2"
after
echo $1 $2 >> nahflog
mjmgraspc -hfe >> nahflog
return $xxx
} # mynahf
myrmcdhf21()
{
# 1  1/2+       3       2  1/2-       3       3  3/2+       3       4  3/2-       3
#  5  5/2+       3
rmcdhf << ---xxx---
y 
1 
5 
$1

2000
---xxx---
x="$?"
if [ "$x" == "0" ]
then
cp rwfn.out rwfn.inp
fi
#echo orbitals usd at $LINENO $1
return $x
} # myrmcdhf21


myrmcdhf()
{
# 1  1/2+       3       2  1/2-       3       3  3/2+       3       4  3/2-       3
#  5  5/2+       3
rmcdhf << ---xxx---
y 
1 2 3   
1  2 3
1 2 3
1 2 3 
1 2 3 
5 
$1

2000
---xxx---
x="$?"
cp rwfn.out rwfn.inp
return $x
} # myrmcdhf

myrmcdhf12311()
{
# 1  1/2+       3       2  1/2-       3       3  3/2+       3       4  3/2-       3
#  5  5/2+       3

#1  1/2+      32       2  1/2-      92       3  3/2+      32       4  3/2-     168 5  5/2+      30
rmcdhf << ---xxx---
y 
1 2 3
1 4 5 6 30 
1 4 5 6 7 8 9  30 31 32
1 4 5 6 30 
1 4 5 6 30 
5
$1

2000
---xxx---
x="$?"
cp rwfn.out rwfn.inp
return $x
} # myrmcdhf12311
myrmcdhf666()
{
# 1  1/2+       3       2  1/2-       3       3  3/2+       3       4  3/2-       3
#  5  5/2+       3

#1  1/2+      32       2  1/2-      92       3  3/2+      32       4  3/2-     168 5  5/2+      30
rmcdhf << ---xxx---
y 
1 2 3   
1 2 3  
1 2 3  
1 2 3 4 5 
1 2 3 4 5 
5
$1

2000
---xxx---
x="$?"
cp rwfn.out rwfn.inp
return $x
} # myrmcdhf666
myrmcdhf12()
{
# 1  1/2+       3       2  1/2-       3       3  3/2+       3       4  3/2-       3
#  5  5/2+       3

#1  1/2+      32       2  1/2-      92       3  3/2+      32       4  3/2-     168 5  5/2+      30
rmcdhf << ---xxx---
y 
1 2 3   
1 2 3  
1
1
1
5
$1

2000
---xxx---
x="$?"
cp rwfn.out rwfn.inp
return $x
} # myrmcdhf12



myrmcdhfss()
{
rmcdhf << ---xxx---
y 
1 2 4 5 14 15 23 24 25 26 27 28 29 30 31 32
1 3 4 5 10 12 13 14 15 23 24 25 27 28 33 34 35 36 37 38 39 40 56 57 58 59 60 61 62 63 64 66 67 68 69 70 71 86 87 88 89 90 91
1 2 3 4 12 13 14 15 16 17 25 26 27 28 29 30 31
1 2 3 4 5 13 14 15 17 18 19 20 21 22 35 36 37 38 41 42 48 49 50 51 52 53 54 55 56 57 58 59 60 61 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 117 118 119 120 121 122 123 124 125 126 154 155 156 157 158 159 160 161 162 163 164 165 166 167
1 2 3 4 11 12 13 14 15 16 23 24 25 26 27 28 29
5
$1

2000
---xxx---
x="$?"
cp rwfn.out rwfn.inp
return $x
} # myrmcdhfss
# 1 3 4 5 10 12 13 14 15 23 24 25 27 28 33 34 35 36 37 38 39 40 56 57 58 59 60 61 62 63 64 66 67 68 69 70 71 86 87 88 89 90 91

myrmcdhfpp()
{
rmcdhf << ---xxx---
y 
1 6 7 8 16 17 18 27 28 29
1 6 7 16 17 18 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92
1 5 6 7 18 19 20
1 1 6 7 8 23 24 25 26 27 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168
1 5 6 17 18
5
$1

2000
---xxx---
x="$?"
cp rwfn.out rwfn.inp
return $x
} # myrmcdhfpp

myrmcdhfspd()
{
rmcdhf << ---xxx---
y 
1 1 2 3 4 5 12 13 14 15 22 23 24 25 26 27 28 29 30 31 32
1 6 16 17 18 29 41 42 43 44 72 73 74 75
1 5 6 7 18 19 20
1 2 3 4 9 10 11 12 13 14 15 17 18 19 20 28 29 30 31 32 33 34 35 36 37 38 45 46 48 49 50 51 52 53 54 55 56 57 58 59 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 117 118 119 120 121 122 123 124 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167
1 2 3 7 8 9 11 12 14 15 19 20 21 23 24 26 27 28 29 30
5
$1

2000
---xxx---
x="$?"
cp rwfn.out rwfn.inp
return $x
# 120 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 154 155 156 157 158 159 160
} # myrmcdhfspd



myjjtolsj()
{
jj2lsj << ---xxx---
$1
n
y
y
---xxx---
} # myjjtolsj

hfcode()
{
echo >   nahflog
mynahf "3s(1)" wfn3s1
#x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
mynahf "3p(1)" wfn3p1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
mynahf "3p-(1)" wfn3p-1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi


mynahf "3d(1)" wfn3d1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
mynahf "4s(1)" wfn4s1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
mynahf "4p(1)" wfn4p1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
mynahf "4d(1)" wfn4d1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
mynahf "5s(1)" wfn5s1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi

mynahf "4p-(1)" wfn4p-1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi

mynahf "2s-(1)" wfn2s1
x="$?"; if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi




cat  nahflog
cat wfn2s1 wfn3s1 wfn3p1 wfn3p-1 wfn3d1 wfn4s1 wfn4p1 wfn4p-1  wfn4d1 wfn5s1 >  wfn.inp
rm -f rwfn.out
mark
rwfnmchfmcdf 
x="$?"; after;  if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
cp rwfn.out rwfn.inp
return 0
} # hfcode

savemodel2()
{
rsave $model2

mark
myjjtolsj $model2
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
rlevelseV $model2.m  
#rlevelseV xxx.xxx  model72p.m 
x="$?"
return $x
} # savemodel2


layering()
{

Zatom=11
mark
nucleus
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
genall1
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rcsf.out rcsf.inp

cp rcsf.out rcsfmr.inp

mark
angular
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
estimate
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
hfcode
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
rwfnestimate << ---xxx---
y
1

*
3
*
---xxx---
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi


mark
rmcdhf << ---xxx---
y 
1 2 3
5
*
*
2000
---xxx---
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

echo $LINENO ; return 

rsave $model1

mark
myjjtolsj $model1
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rlevelseV $model1.m  
#rlevelseV xxx.xxx  model72p.m 

#################################### mr done


mark
genall2b
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rcsf.out rcsf.inp
cp rcsf.out xxx.inp
#vi rcsf.inp

if [ 0 == 1 ]
then 
mark
rcsfinteract << ---xxx---
2
---xxx---
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rcsf.out rcsf.inp
cp rcsf.out yyy.inp
fi

mark
angular
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
rwfnestimate << ---xxx---
y
1
$model1.w
*
2
*
---xxx---
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
#  1s 2s 2p- 2p 3s 3p- 3p 3d- 3d 4s 4p- 4p 4d- 4d 5s 5p- 5p 5d- 5d
myrmcdhf21  "2p- 2p 3s 3p- 3p "
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

echo $LINENO ; return 
#mark
#myrmcdhf21  "3d- 3d"
#x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

#savemodel2
#x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
#echo good stop $LINENO ; return

mark
myrmcdhf21  "1s 2s 2p- 2p"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

#mark
#myrmcdhf21  "3s 4s  5s "
#x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi


mark
#myrmcdhf12  "1s 2s 2p- 2p 3s 3p- 3p 3d- 3d  4s 4p- 4p 4d- 4d  5s "
# 1s 2s 2p- 2p 3s 3p- 3p 3d- 3d 4s

myrmcdhf12  "1s 2s 2p- 2p 3s 3p-  4s  "
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi


savemodel2
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
echo good stop $LINENO ; return

################################################################3

for j in 1 2 3 4
do


mark
myrmcdhfss  "1s"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
myrmcdhfss  "2s"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
myrmcdhfpp  "2p- 2p"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
myrmcdhfss  "3s"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
myrmcdhfpp  "3p- 3p"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
myrmcdhfspd  "3d- 3d"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
myrmcdhfss  " 4s"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

done

mark
#myrmcdhf666  "1s 2s 2p- 2p 3s 3p- 3p  3d- 3d 4s"
myrmcdhfss  "1s 2s 2p- 2p 3s"
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

savemodel2
return 


##############################################################



rsave $model2
mark
myjjtolsj $model2
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rlevelseV $model2.m  


} # layering

layering

