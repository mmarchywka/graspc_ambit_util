
# https://www.researchgate.net/profile/Nishita-Manohar-Hosea/publication/393945599_A_systematic_study_of_the_dipole_and_non-dipole_effects_of_photoionisation_in_the_region_of_Cooper_minimum/links/6880eb45253dcb78df875b5a/A-systematic-study-of-the-dipole-and-non-dipole-effects-of-photoionisation-in-the-region-of-Cooper-minimum.pdf
# file:///home/marchywka/Downloads/GRASP2018-manual.pdf ( file name not path lol ) 


# rm -f  modellay*
model1=model71.1o
modeleven=model71.2e
modelevenf=model71.2ef
modelxxx=model71.2xxx
modelodd=model71.2o
modeloddf=model71.2of


Zatom=11

. common_graspc.sh


mynahf()
{
mymyhf "$1"  "$2" "  1s  2s  2p"
} # mynahf 

hfcode()
{
fixed="  1s  2s  2p"
hfcodestuff "1s(1) 2s(1)"  "$fixed"
x="$?"
return $x
} #hfcode

rmcdsss()
{
mark
rmcdhf << ---xxx---
y 
1 2 
1 2 
5
$1 


1000
---xxx---
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rwfn.out rwfn.inp
return 0
} # rmcdsss

rmcdssa()
{
mark
rmcdhf << ---xxx---
y 
1 2 
1 2
5
$1 


1000
---xxx---
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rwfn.out rwfn.inp
return 0
} # rmcdssa


layering()
{

Zatom=11
mark
nucleus
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
rcsfgenerate  <<---xxx---
*
0
1s(2,i)2s(2,1)2p(6,4)3s(1,*)

5s,4p,4d,4f
1,3
2
y
1s(2,i)2s(2,1)2p(6,4)3p(1,*)

5s,4p,4d,4f
1,3
2
n

--xxx---

x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rcsf.out rcsf.inp
cp rcsf.out rcsfmr.inp


mark
angular
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
fixed="  1s  2s  2p"
#hfcodestuff "1s(1) 2s(1) 2s(2)  2p(1) 2p(6) 3s(1) 3p(1) 3p(2)" $fixed  
hfcodestuffrrr "3s(1) 2s(2) 2p-(6) 2p(6)  3p-(1) 3p(1) 3d-(1) 3d(1) 4s(1) 4s(2) 4p-(1) 4p(1) 4p(6) 4d-(1) 4d(1) 4f-(1) 4f(1) 5s(1) 5p-(1) 5p(1) 5f-(1) 5f(1) " "$fixed"  
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

cat estfile.txt | rwfnestimate
cp rwfn.inp initmodel.inp
#mark
#rwfnestimate << ---xxx---
#y
#1
#rwfn.inp
#*
#---xxx---
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

# echo $LINENO ; return 
mark
rmcdhf << ---xxx---
y
1 2 3 4
1 2 3 4 
1 2
1 2
5
 1s 2s 2p- 2p 3s 3p- 3p 3d- 3d 4s 4p- 4p 4d- 4d 4f- 4f  5s 5p- 5p


1000
---xxx---
 # 1s 2s 2p- 2p 3s 3p- 3p 3d- 4s 4p- 4p 4d- 4f- 4f  5s 5p- 5p

#1s,2s,2p,s3,3p-,3p,4s,4p-,4p
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rwfn.out rwfn.inp
saveamodel $model1
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

} # layering

jeven()
{

Zatom=11
mark
nucleus
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
rcsfgenerate  <<---xxx---
*
0
1s(2,i)2s(2,i)2p(6,i)3s(1,*)
1s(2,i)2s(2,*)2p(6,i)3s(1,i)
1s(2,i)2s(2,i)2p(6,i)4s(1,*)
1s(2,i)2s(2,i)2p(6,i)5s(1,*)

5s,4p,4d,4f
1,1
0
n

--xxx---


x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rcsf.out rcsf.inp

cp rcsf.out rcsfmr.inp

mark
angular
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rm -f rwfn.inp
rm -f rwfn.out
mark
estimatem $model1.w
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
rmcdhf << ---xxx---
y 
1 2 3 
5
*
*
1000
---xxx---
 # 1s 2s 2p- 2p 3s 3p- 3p 3d- 4s 4p- 4p 4d- 4f- 4f  5s 5p- 5p

#1s,2s,2p,s3,3p-,3p,4s,4p-,4p
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rwfn.out rwfn.inp
mark
saveamodel $modeleven
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
# was 3 excitation but may not work with rasfsplit 
rcsfgenerate  <<---xxx---
*
0
1s(2,i)2s(2,i)2p(6,i)3s(1,*)
1s(2,i)2s(2,*)2p(6,i)3s(1,i)
1s(2,i)2s(2,i)2p(6,i)4s(1,*)
1s(2,i)2s(2,i)2p(6,i)5s(1,*)

5s,4p,4d,4f
1,1
2
n

--xxx---
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rcsf.out rcsf.inp


mark
angular
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
estimatemm $modeleven.w  $model1.w
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
rmcdhf << ---xxx---
y 
1 2 3 
5
*

1000
---xxx---
 # 1s 2s 2p- 2p 3s 3p- 3p 3d- 4s 4p- 4p 4d- 4f- 4f  5s 5p- 5p

#1s,2s,2p,s3,3p-,3p,4s,4p-,4p
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rwfn.out rwfn.inp
mark
saveamodel $modelevenf
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi


echo good return  $LINENO ; return 


return 0
} # jeven

jodd()
{

Zatom=11
mark
nucleus
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
rcsfgenerate  <<---xxx---
*
0
1s(2,i)2s(2,i)2p(6,4)3p(1,*)
1s(2,i)2s(2,i)2p(6,4)4p(1,*)
1s(2,i)2s(2,i)2p(6,4)5p(1,*)

5s,4p,4d
1,5
0
n

--xxx---


x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rcsf.out rcsf.inp

cp rcsf.out rcsfmr.inp

mark
angular
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rm -f rwfn.inp
rm -f rwfn.out
mark
estimatems $model1.w 3
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
mark
rmcdhf << ---xxx---
y 
1 2
1 2
5
*
*
1000
---xxx---
 # 1s 2s 2p- 2p 3s 3p- 3p 3d- 4s 4p- 4p 4d- 4f- 4f  5s 5p- 5p

#echo good return  $LINENO ; return 
#1s,2s,2p,s3,3p-,3p,4s,4p-,4p
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rwfn.out rwfn.inp
mark
saveamodel $modelodd
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
rcsfgenerate  <<---xxx---
*
0
1s(2,i)2s(2,i)2p(6,4)3p(1,*)
1s(2,i)2s(2,i)2p(6,4)4p(1,*)
1s(2,i)2s(2,i)2p(6,4)5p(1,*)

5s,5p
1,3
2
n

--xxx---
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rcsf.out rcsf.inp

mark
angular
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
#estimatemm3 $modelodd.w  $model1.w
#estimatemm3 $model1.w $modelodd.w 
#estimatemm2 $modelodd.w initmodel.inp 
#estimatemm2 $modelevenf.w initmodel.inp 
rwfnestimate << ---xxx---
y
1
$modelevenf.w
1s 2s 2p- 2p 3s 4s 5s 
1
$modelodd.w
3p- 3p
1
initmodel.inp
*
2
*

---xxx---

x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
#cp rwfn.inp rwfn.out
#saveamodel xxx
#echo good return  $LINENO ; return 
mark
#  1s 2s 2p- 2p 3s 3p- 3p 3d- 3d 4s 4p- 4p 4d- 4d 4f- 4f 5s 5p- 5p

rmcdhf << ---xxx---
y 
1 2 3 4
1 2 3 4
5
1s


1000
---xxx---
 # 1s 2s 2p- 2p 3s 3p- 3p 3d- 4s 4p- 4p 4d- 4f- 4f  5s 5p- 5p
#echo good return  $LINENO ; return 

#1s,2s,2p,s3,3p-,3p,4s,4p-,4p
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rwfn.out rwfn.inp

saveamodel $modelxxx 

rmcdsss "2s "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "2p- "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "2p  "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "3s  "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "3p- 3p  "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "3d- 3d  "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "3s "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "4s 5s "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "1s 2s 2p- 2p "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

rmcdsss "4p- 4p "
$x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi




#echo good return  $LINENO ; return 

if [ "1" == "0" ]
then
mark
rmcdhf << ---xxx---
y 
1 2 
1 2 
5
* 


1000
---xxx---
 # 1s 2s 2p- 2p 3s 3p- 3p 3d- 4s 4p- 4p 4d- 4f- 4f  5s 5p- 5p

#1s,2s,2p,s3,3p-,3p,4s,4p-,4p
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
cp rwfn.out rwfn.inp
fi



mark
saveamodel $modeloddf
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi



return 0

} # jodd
jeo()
{
mark
rciamodel $modeloddf 
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
#echo good return  $LINENO ; return 
mark
rciamodel $modelevenf 
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi



return 0
} # jeo
xformetc()
{
me=$1
mo=$2
mark
myjjtolsjrci $me
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
mark
myjjtolsjrci $mo
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
mark
rbiotransform << ---xxx---
y
y
$me
$mo
n
1
1
1
1

---xxx---
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi

mark
myjjtolsjrci $me
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
mark
myjjtolsjrci $mo
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi

mark
rtransition << ---xxx---
n
n
y
$me 
$mo
n
E1
eV
n
n
---xxx---
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
return 0
} # xformetc


doxphoto()
{
rm -f photo.sum
mark
mymev=$1
mymod=$2
xphoto << ---xxx---
photo.sum
isodata
E1
eV
40
y
.1 10 .2
n
$mymod.c
$mymev.c
$mymod.bm
$mymev.bm
$mymod.bw
$mymev.bw


---xxx---
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi

return 0
} # doxphoto

x=0

#layering
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
#jeven
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
#jodd
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
#jeo
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
mark
me=$modelevenf
mo=$modeloddf
#xformetc $me $mo
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi
mark
mymev=./model71.2ef_even1
mymod=./model71.2of_odd1
doxphoto $mymev $mymod
#doxphoto $me $mo
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x  ; fi

#rlevelseV $modeloddf.m $modelevenf.m
#rlevelseV $modeloddf.cm $modelevenf.cm

echo  end of file return $LINENO  


