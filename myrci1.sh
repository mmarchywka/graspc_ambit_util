
fn="myrci.txt"
echo > "$fn"
#Default settings? 
echo "y"  > "$fn"
#Name of state: 
echo "$1"  >> "$fn"
 #Include contribution of H (Transverse)?
echo "y"  >> "$fn"
 #Modify all transverse photon frequencies?
echo "n"  >> "$fn"
# Include H (Vacuum Polarisation)?
echo "y"  >> "$fn"
# Include H (Normal Mass Shift)?
echo "y"  >> "$fn"
# Include H (Specific Mass Shift)?
echo "n"  >> "$fn"
# Estimate self-energy?
echo "y"  >> "$fn"
echo "2"  >> "$fn"
# Loading Radial WaveFunction File ...
# There are            2  blocks  (block   J/Parity   NCF):
#  1  1/2-     774       2  3/2-    1100
#
# Enter ASF serial numbers for each block
# Block            1    ncf =          774  id =  1/2-
# Block            2    ncf =         1100  id =  3/2-
i=0
while [ "1" == "1" ]
do
echo "1 2 3 4 5"  >> "$fn"
i=$[ $i + 1 ]
if [ "$i" == "$2" ]
then
break
fi

if [ "$i" == "100" ]
then
echo too many for rci at line  $LINENO
break
fi
done

cat $fn | rci 
#cat $fn  


