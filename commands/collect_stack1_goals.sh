
#!/usr/bin/env bash

# NOTE: may manually need to switch between start and gui_start for now
echo "Starting data collection, must be either 'start' or 'gui_start'"
rosrun costar_bullet $1 \
  --robot ur5 --task stack1 --agent task \
  -i 1000 --features multi  --verbose \
  --seed 0 \
  --cpu \
  --save --data_file newdata.h5f \
  --collection_mode goal

# NOTE: removing this flag now that we are predicting both successful and
# unsuccessful futures from any given state.
#--success_only \

