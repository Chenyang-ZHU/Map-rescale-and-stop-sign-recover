#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
This function is the second part of 'rescaling map'.
User needs to change three arguments:
    1. ind1: index of the first endpoint of a straight path
    2. ind2: index of the second endpoint of a straight path
    3. realdis: the corresponding real distance of the straight path,
       it is computed from the former part function 'GPS_data_proceser'.
      
The input is used in line 21. the slam map txt file. Change it if you want to do
other tests.

The final output if this function is 'scale', which is the scale of the SLAM map.
"""

import numpy as np
import matplotlib.pyplot as plt
import math

file = open('KeyFrameTrajectory3.txt')
data = file.read()
lines = data.replace(","," ").replace("\t"," ").split("\n") 
first_list = [[v.strip() for v in line.split(" ") if v.strip()!=""] for line in lines if len(line)>0 and line[0]!="#"]

Pos=np.asarray(first_list)
loca=Pos[:,1:3]
# change the following two indexs to find the proper endpoints of a straight path
ind1=153
ind2=225
plt.plot(loca[:,0], loca[:,1],'r.')
plt.plot(loca[ind1,0], loca[ind1,1],'b*')
plt.plot(loca[ind2,0], loca[ind2,1],'b*')

# change the realdis based on the result of 'GPS_data_processer'
realdis=60.5678203723
dis=math.hypot(float(loca[ind2,0])-float(loca[ind1,0]), float(loca[ind2,1])-float(loca[ind1,1]))
scale=realdis/dis
print scale






