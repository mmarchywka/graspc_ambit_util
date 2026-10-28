
# https://www.researchgate.net/profile/Nishita-Manohar-Hosea/publication/393945599_A_systematic_study_of_the_dipole_and_non-dipole_effects_of_photoionisation_in_the_region_of_Cooper_minimum/links/6880eb45253dcb78df875b5a/A-systematic-study-of-the-dipole-and-non-dipole-effects-of-photoionisation-in-the-region-of-Cooper-minimum.pdf
# file:///home/marchywka/Downloads/GRASP2018-manual.pdf ( file name not path lol ) 


# rm -f  modellay*
model1=model71.1o
model2=model71.2o
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

5s,4p,4d
1,3
2
y
1s(2,i)2s(2,1)2p(6,4)3p(1,*)

5s,4p,4d
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
hfcodestuff "3s(1) 3s(2) 3p(1) 3p(2) 3d(1) 4s(1) 4s(2) 4p(1) 4p(6) 4d(1) 5s(1) " "$fixed"  
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

#echo $LINENO ; return 

mark
rwfnestimate << ---xxx---
y
1
rwfn.inp
*
---xxx---

x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

mark
rmcdhf << ---xxx---
y
1 2
1 2
1 2
1 2
5
 1s 2s 2p- 2p 3s 3p- 3p 3d- 4s 4p- 4p 4d-  5s 5p- 5p


1000
---xxx---

#1s,2s,2p,s3,3p-,3p,4s,4p-,4p
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi

saveamodel $model1
x="$?"; echo at $LINENO ;  after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return ; fi
echo $LINENO ; return 



} # layering

layering
echo $LINENO  

