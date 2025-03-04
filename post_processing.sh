#!/bin/bash
for i in {1..64}
do
cat $i/md200ns.log > REMD200ns.log
done

demux.pl REMD200ns.log

for i in {1..64}
#o
echo 10 | gmx energy -f md200ns.edr -s md200ns.tpr -o Epot_$i.xvg
done &> Epot_200ns.out

gmx trjcat -f 1/md200ns.xtc 2/md200ns.xtc 3/md200ns.xtc 4/md200ns.xtc 5/md200ns.xtc 6/md200ns.xtc 7/md200ns.xtc 8/md200ns.xtc 9/md200ns.xtc 10/md200ns.xtc 11/md200ns.xtc 12/md200ns.xtc 13/md200ns.xtc 14/md200ns.xtc 15/md200ns.xtc 16/md200ns.xtc 17/md200ns.xtc 18/md200ns.xtc 19/md200ns.xtc 20/md200ns.xtc 21/md200ns.xtc 22/md200ns.xtc 23/md200ns.xtc 24/md200ns.xtc 25/md200ns.xtc 26/md200ns.xtc 27/md200ns.xtc 28/md200ns.xtc 29/md200ns.xtc 30/md200ns.xtc 31/md200ns.xtc 32/md200ns.xtc 33/md200ns.xtc 34/md200ns.xtc 35/md200ns.xtc 36/md200ns.xtc 37/md200ns.xtc 38/md200ns.xtc 39/md200ns.xtc 40/md200ns.xtc 41/md200ns.xtc 42/md200ns.xtc 43/md200ns.xtc 44/md200ns.xtc 45/md200ns.xtc 46/md200ns.xtc 47/md200ns.xtc 48/md200ns.xtc 49/md200ns.xtc 50/md200ns.xtc 51/md200ns.xtc 52/md200ns.xtc 53/md200ns.xtc 54/md200ns.xtc 55/md200ns.xtc 56/md200ns.xtc 57/md200ns.xtc 58/md200ns.xtc 59/md200ns.xtc 60/md200ns.xtc 61/md200ns.xtc 62/md200ns.xtc 63/md200ns.xtc 64/md200ns.xtc -demux replica_index.xvg


echo 1 0 | gmx trjconv -s control_md_1micS.tpr -f WT_c-rescale_1micS.xtc -o md_center_1mics.xtc -center -boxcenter rect 
echo 0 | gmx trjconv -s control_md_1micS.tpr -f md_center_1mics.xtc -o md_nopbc1_1mics.xtc -ur compact -pbc atom
echo 0 | gmx trjconv -f md_nopbc1_1mics.xtc -s control_md_1micS.tpr -o md_nopbc2_1mics.xtc -pbc mol
echo 0 | gmx trjconv -f md_nopbc2_1mics.xtc -s control_md_1micS.tpr -o md_nojump_1mics.xtc -pbc nojump

echo 3 3 | gmx rms -s control_md_1micS.tpr -f md_nojump_1mics.xtc -o rmsd_calpha_af9_bcor.xvg
echo 1 1 | gmx rms -s control_md_1micS.tpr -f md_nojump_1mics.xtc -o rmsd_allatom_af9_bcor.xvg 
echo 1 | gmx gyrate -s control_md_1micS.tpr -f md_nojump_1mics.xtc -o rg_af9_bcor_all_atom.xvg
#awk ' {if ( $1 !~ /[#@]/) print $2 } ' rg_cluster516_200ns_all_atom.xvg > rg200.dat
#awk ' {if ( $1 !~ /[#@]/) print $2 } ' rmsd_cluster516_200ns_all_atom.xvg > rmsd200.dat
#paste rg200.dat rmsd200.dat > rg_rmsd200.dat
#echo 3 1 | gmx -s 1/md200ns.tpr -f replica0_200nsfinal.xtc -cl cluster_200ns_cluster516.pdb -cutoff 0.12 
