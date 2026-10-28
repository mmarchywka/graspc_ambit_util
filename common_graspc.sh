


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
myjjtolsj()
{
jj2lsj << ---xxx---
$1
n
y
y
---xxx---
} # myjjtolsj
myjjtolsjrci()
{
jj2lsj << ---xxx---
$1
y
y
y
---xxx---
} # myjjtolsjrci
rciamodel()
{
nm="$1"
mark
./myrci1.sh $nm 10
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x for $nm ; return $x ; fi
myjjtolsjrci $nm
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x for $nm ; return $x  ; fi
rlevelseV $nm.m
x="$?"
return $x
} # savemodel2




saveamodel()
{
nm="$1"
rsave $nm
mark
myjjtolsj $nm
x="$?"; after ;if [ "$x" != "0" ] ;  then echo bad $LINENO end $x for $nm ; return ; fi
rlevelseV $nm.m
x="$?"
return $x
} # savemodel2


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
estimatem()
{
rwfnestimate << ---xxx---
y
1
$1
*
---xxx---
x="$?"
return $x
} # estimatem
estimatemm()
{
rwfnestimate << ---xxx---
y
1
$1
*
1
$2
*
---xxx---
x="$?"
return $x
} # estimatemm
estimatemm3()
{
rwfnestimate << ---xxx---
y
1
$1
*
1
$2
*
3
*

---xxx---
x="$?"
return $x
} # estimatemm3
estimatemm2()
{
rwfnestimate << ---xxx---
y
1
$1
*
1
$2
*
2
*

---xxx---
x="$?"
return $x
} # estimatemm2




estimatems()
{
rwfnestimate << ---xxx---
y
1
$1
*
$2
*
---xxx---
x="$?"
return $x
} # estimatems





# 3 is list of orbitals fixed 
mymyhf()
{
if [ "$2" == "" ]
then
return -1
fi
if [ -e "$2" ]
then
rm "$2"
fi
# up to caller
#mark
# /home/ubuntu/dev/grasp/grasp-2018-12-03/bin/hf << ---xxx---
hf << ---xxx---
Na,AV,$Zatom
$3
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
} # mymyhf

hfloop()
{
fn=`echo "$1" | sed -e 's/[()]//g' `
fn="wfn$fn"
rm -f "$fn"
echo fn=$fn fixed=$2 
#mymyhf "$1"  "$2" "  1s  2s  2p"
mymyhf "$1"  "$fn" "$2"
#mynahf "$1" "$fn" 
x="$?"; if [ "$x" != "0" ] ;  then echo bad $1 $fn $LINENO end $x; return $x ; fi
cat "$fn" >> wfn.inp
return 0
} # hfloop 

hflooprrr()
{
fn=`echo "$1" | sed -e 's/[()]//g' `
fn="wfn$fn"
rm -f "$fn"
echo fn=$fn fixed=$2 
#mymyhf "$1"  "$2" "  1s  2s  2p"
mymyhf "$1"  "$fn" "$2"
#mynahf "$1" "$fn" 
x="$?"; if [ "$x" != "0" ] ;  then echo bad $1 $fn $LINENO end $x; return $x ; fi
cp "$fn"  wfn.inp
rwfnmchfmcdf
// this creates rwfn.out
cp rwfn.out "r$fn"
echo "r$fn ">> rfiles.txt
return 0
} # hflooprrr



xxhfcodestuff()
{

fixed="$2"
for f in  $1          
do
echo fixed $fixed  f is $f

done
} 

hfcodestuff()
{
echo >   nahflog
rm -f  wfn.inp
fixed="  1s  2s  2p"
fixed="$2"
#for f in  "1s(1) 2s(1) " 
for f in  $1          
 do xx=`hfloop "$f" "$fixed"   `; x="$?" ; echo $xx ; if [ "$x" != "0" ] ;  then  return $x; fi ; done
#mynahf "3s(1)" wfn3s1
cat  nahflog
#rm -f rwfn.out
cp wfn.inp wfn.out
# up to call er 
#mark
rwfnmchfmcdf
x="$?"; after;  if [ "$x" != "0" ] ;  then echo bad $LINENO end $x; return $x ; fi
cp rwfn.out rwfn.inp
return 0
} # hfcodestuff

hfcodestuffrrr()
{
echo >   nahflog
rm -f  wfn.inp
rm -f rfiles.txt
fixed="  1s  2s  2p"
fixed="$2"
#for f in  "1s(1) 2s(1) " 
for f in  $1          
 do xx=`hflooprrr "$f" "$fixed"   `; x="$?" ; echo $xx ; if [ "$x" != "0" ] ;  then  return $x; fi ; done
#mynahf "3s(1)" wfn3s1
cat  nahflog
echo y > estfile.txt
cat rfiles.txt | while read ; do echo 1 >> estfile.txt ; echo $REPLY >> estfile.txt; echo "*" >> estfile.txt ;  done
echo 2 >> estfile.txt
echo "*" >> estfile.txt
cat estfile.txt
return 0
} # hfcodestuffrrr




