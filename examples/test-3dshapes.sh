#!/bin/bash
# solve a one-dimensional slab with different schemes

. locateruntest.sh

checkgmsh

for i in cube cylinder sphere bunny; do
 runmilonga 3dshape.mil $i | tee $i.dat
done

cat << EOF > bunny_phi.geo
Merge "bunny_phi.msh";
General.Clip0A = 0;
General.Clip0B = +1;
General.ClipWholeElements = 1;
View[0].Clip = 1;
General.Trackball=1;
General.TrackballQuaternion0 = 0.44;
General.TrackballQuaternion1 = -0.01;
General.TrackballQuaternion2 = 0.02;
General.TrackballQuaternion3 = 0.90;
Geometry.Surfaces = 1;
Mesh.SurfaceEdges = 0;
Mesh.VolumeEdges = 0;
EOF

callgmsh bunny_phi.geo

exit 0
