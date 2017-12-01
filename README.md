# Map-rescale-and-stop-sign-recover
This project is aiming at recovering the real size of stop sign based on the rescales ORB_SLAM map. Please read the pdf file carefully, which is a report of this peoject.

1. ORB-SLAM:https://github.com/raulmur/ORB_SLAM2

Before starting this project, make sure you've understand how to use ORB-SLAM. You can have access to anything you want about ORB-SLAM from the above link.

The System.cc file included in this reporsitory is the modified system.cc file of ORB-SLAM. Please replace the original system.cc file in your ORB-SLAM src folder with the new one. The only difference is that I added a new function: SaveMapPoints. So you also need to add this function to the head file in System.h and add SLAM.SaveMapPoints("MapPointsSave.txt"); in the example file like mono_euroc.cc.

2. Rescale the map:

In this part, we will use the GPS map as ground truth to compute the scale of SLAM map. GPS_data_processer.py is used to process the gps data. Make sure the gps txt file has the same form like the example file. Another function SLAM_processer&rescale.py is used to process the SLAM map and compute the scale. Detailed information you need has been described in the comments in these two functions.

3. Recover the real size of stop sign

After the rescaling part, we will try to recover the real size of stop sign. The folder Recover_Size/Data1 includes all the 3D map points in the key frame and all the map points' observations in other frames(Go to ORB-SLAM for more details). Folder Recover_Size/frames includes the frames containing stop sign, which means that all these frames are possible to be keyframe, because every time you run ORB-SLAM, the keyframes will be different. 

What we need to do is to find the specific keyframe containg a stop sign, to detect the stop sign and compute the real size of it. The matlab function recover_stop_sign.m  is what you want to run. All the details you need to know have been made as comments in the code.

4. Acknowledgements:

This peoject is based on ORB-SLAM, if you want to use this project, please cite: https://github.com/raulmur/ORB_SLAM2

This project is finished by Chenyang Zhu during his internship in Navigation Lab, Robotics Institute, Carnegie Mellon University http://www.cs.cmu.edu/afs/cs/project/alv/www/index.html. Chenyang is highly thankful for the help and instructions from Dr.Christoph Mertz: https://www.ri.cmu.edu/ri-people/christoph-mertz/.


