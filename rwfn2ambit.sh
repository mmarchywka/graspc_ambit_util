
#  deep        -- always occupied in the CI model space
#        hole        -- sometimes occupied (below Fermi level)
#        particle    -- sometimes occupied (above Fermi level)
#        high        -- never occupied in the CI model space

#    Furthermore each orbital will appear in some of the following:
#        core        -- below Fermi level (includes deep + hole)
#        excited     -- above Fermi level (includes particle + high)
#        valence  

./mjm_graspc2ambit.out "test cmd=readrwfn;fn=runs/Nav3/rwfn4f1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn3d1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn3s1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn4p6;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn4p1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn4d1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn5f1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn5s1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn2s2;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn3p1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn4s1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn5p1;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn2p6;fflags=1" "test cmd=readrwfn;fn=runs/Nav3/rwfn4s2;fflags=1" "test cmd=sortrwfn" \
"test cmd=pickrwfn;sel=mid" \
"test cmd=listrwfn;fn=runs/Nav3/wfn.out;fflags=1" "test cmd=rwfn2a" \
"test cmd=add;cat=deep;1s" \
"test cmd=add;cat=hole;2s;2p-;2p;3s" \
"test cmd=add;cat=particle;3p-;3p;3d-;3d;4s;4p-;4p;5s" \
"test cmd=add;cat=core;1s;2s;2p;2p-" \
"test cmd=add;cat=excited;2s;2p-;2p;3s" \
"test cmd=add;cat=valence;3p-;3p;3d-;3d;4s;4p-;4p;5s" \
 "test cmd=writeambit;fn=myna.basis"   \
"test cmd=listrwfn;summary=1;fflags=1"  \
 quit 2>&1 





