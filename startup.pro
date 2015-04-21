/* goals for SDE3 examples with data */
/* data */
image_i1cr([
[2,2,2,2,2,2,2,2,2],
[2,2,1,2,2,2,1,2,2],
[2,5,4,3,2,2,2,2,2],
[2,5,4,3,2,2,2,2,2],
[2,3,3,2,2,2,2,2,2],
[2,2,2,2,2,2,2,2,2],
[2,2,2,2,2,2,2,2,2],
[2,2,1,2,2,2,1,2,2],
[2,2,2,2,2,2,2,2,2],
[2,2,2,2,2,2,2,2,2]]).
image_i2cr([
[2,2,2,2,2,2,2,2,2],
[2,2,1,2,2,2,1,2,2],
[2,2,2,2,2,2,2,2,2],
[2,2,2,2,2,2,5,4,3],
[2,2,2,2,2,2,5,4,3],
[2,2,2,2,2,2,3,3,2],
[2,2,2,2,2,2,2,2,2],
[2,2,1,2,2,2,1,2,2],
[2,2,2,2,2,2,2,2,2],
[2,2,2,2,2,2,2,2,2]]).
image_tgr11([
[0,0,0,20,0],
[0,10,10,0,0],
[0,10,10,0,0],
[0,0,0,0,0],
[0,0,0,0,0]]).
image_tgr12([
[0,0,0,0,0],
[0,10,10,0,0],
[0,10,10,0,0],
[0,20,0,0,0],
[0,0,0,0,0]]).
image_tgr21([
[0,0,0,10,0],
[0,0,0,10,10],
[0,0,0,10,10],
[0,0,0,10,0],
[0,0,0,0,0]]).

image_tgr22([
[0,0,0,0,0],
[0,10,0,0,0],
[0,10,10,0,0],
[0,10,10,0,0],
[0,10,0,0,0]]).
image_tgr31([
[5,5,0,5,0],
[0,0,0,10,9],
[0,0,0,8,0],
[0,0,0,7,0],
[5,4,3,2,1]]).
image_tgr32([
[5,5,0,5,0],
[0,10,9,0,0],
[0,8,0,0,0],
[0,7,0,0,0],
[5,4,3,2,1]]).
/* for use in centriod tests */
image_mn1k(
[[0, 0, 0, 20, 0],
[0, 0, 0, 15, 0],
[0, 0, 0, 10, 0],
[0, 0, 0, 5, 0],
[0, 0, 0, 0, 0]]).
image_mp1k(
[[0, 0, 0, 0, 0],
[0, 20, 0, 0, 0],
[0, 15, 0, 0, 0],
[0, 10, 0, 0, 0],
[0, 5, 0, 0, 0]]).
startup :- [’motion.pro’]. /* consult the SWI-Prolog source file */