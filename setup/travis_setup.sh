#!/usr/bin/env bash

export ROS_DISTRO=indigo
export ROS_CI_DESKTOP="`lsb_release -cs`"  # e.g. [precise|trusty|...]
export CI_SOURCE_PATH=$(pwd)
export CATKIN_OPTIONS="$CI_SOURCE_PATH/catkin.options"
export ROS_PARALLEL_JOBS='-j8 -l6'
export CATKIN_WS="$HOME/costar_ws"
export COSTAR_PLAN_DIR="$HOME/costar_ws/src/costar_plan"

sudo apt-get update -qq
sudo rm -rf /var/lib/apt/lists/*

echo "======================================================"
echo "PYTHON"
echo "Installing python dependencies:"
echo "Installing basics from apt-get..."
sudo apt-get -y install python-pygame python-dev
echo "Installing libraries and drivers..."
sudo apt-get -y install -y build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev libssl-dev
sudo apt-get -y install -y libx11-dev libpq-dev python-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev
echo "Installing smaller libraries from pip..."
sudo -H pip install --no-binary numpy
sudo -H pip install h5py keras keras-rl sympy matplotlib pygame gmr networkx \
  dtw pypr gym PyPNG pybullet numba

# TODO(cpaxton): come up with a better way to install tensorflow here. We want
# to ensure that everything is configured properly for tests.
if [ nvidia-smi ]
then
  sudo -H pip install tensorflow
else
  sudo -H pip install tensorflow
fi

echo "======================================================"
echo "installing ROS"

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# updates
sudo apt-get update -qq

# install indigo
sudo apt-get -y install ros-indigo-desktop-full

sudo rosdep init
rosdep update

echo "source /opt/ros/indigo/setup.bash" >> ~/.bashrc
source $HOME/.bashrc
sudo apt-get -y install python-rosinstall


echo "======================================================"
echo "CATKIN"
echo "Create catkin workspace..."
mkdir -p $CATKIN_WS/src
cd $CATKIN_WS
#source /opt/ros/indigo/setup.bash
catkin init
cd $CATKIN_WS/src

git clone https://github.com/cpaxton/hrl-kdl.git  --branch indigo-devel
git clone https://github.com/cburbridge/python_pcd.git
git clone https://github.com/jhu-lcsr/costar_objects.git
git clone https://github.com/cpaxton/dmp.git --branch indigo
git clone https://github.com/cpaxton/robotiq_85_gripper.git


# Need to find less complicated way to integrate the repo besides annoying ssh authentication
# git clone https://a5a923019bfb3202ebdf3e3eb63b7866c913218d@github.com/cpaxton/costar_plan.git


rosdep install -y --from-paths ./ --ignore-src --rosdistro $ROS_DISTRO
cd $CATKIN_WS/src
catkin build
source $CATKIN_WS/devel/setup.bash
