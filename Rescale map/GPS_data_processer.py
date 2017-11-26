#!/usr/bin/env python2
# -*- coding: utf-8 -*-


import numpy as np
import matplotlib.pyplot as plt
from geopy.distance import vincenty

#==============================================================================
'''
This function is part of the "rescale map".
This one is used to process GPS data. User needs to change the two endpoints'
indexs to find the proper endpoints so that we can compute the real distance 
of a straight path in the map.

The input of this file is used in line 23, change the txt file when you want 
to do your own test with other gps data. Make sure you have the same form of 
the data contained in the gps.txt file.

The final output 'realdis' is needed in the other function 'SLAM_processer&rescael'. 
'''
#==============================================================================
file = open("crag3_gps.txt")
data = file.read()
lines = data.replace(","," ").replace("\t"," ").split("\n") 
list = [line.split(" ") for line in lines if len(line)>0]
a=[]
for ele in list:
    if len(ele)==3:
        a.append(ele)       
a=[[b.split('LONG') for b in c] for c in a]

a_arr=np.asarray(a)
x=a_arr[:,1]
y=a_arr[:,2]
x_l=np.ndarray.tolist(x)
x_a=np.asarray(x_l)
x_pos=x_a[:,1]
np.asarray(x_pos)
y_l=np.ndarray.tolist(y)
y_pos=np.asarray(y_l)
position=[x_pos,y_pos]
plt.plot(x_pos, y_pos,'r.')

# handily change the index to find the turning points of a straight path 
turn1=27
turn2=43
plt.plot(x_pos[turn1], y_pos[turn1],'b*')
plt.plot(x_pos[turn2], y_pos[turn2],'b*')


newport_ri = (x_pos[turn1], float(y_pos[turn1][0]))
cleveland_oh = (x_pos[turn2], float(y_pos[turn2][0]))
realdis=vincenty(newport_ri, cleveland_oh).meters
print realdis