prepare_external_library(OpenCV git@github.com:opencv/opencv.git 4.11.0 "-DWITH_GTK=ON -DBUILD_opencv_highgui=ON" FALSE)
prepare_external_library(GameNetworkingSockets git@github.com:ValveSoftware/GameNetworkingSockets.git a246ee39c32cc4b34580dc24d434ac9a4007a74b "" FALSE)
prepare_external_library(argparser git@github.com:p-ranav/argparse.git v3.2 "" FALSE)

