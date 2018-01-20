python2 grasp_train.py --grasp_model grasp_model_levine_2016  --data_dir=~/.keras/datasets/grasping/ --grasp_success_label 'move_to_grasp/time_ordered/grasp_success' --grasp_sequence_motion_command_feature 'move_to_grasp/time_ordered/reached_pose/transforms/endeffector_current_T_endeffector_final/vec_sin_cos_5' --loss 'binary_crossentropy' --metric 'binary_accuracy' --batch_size 15 --distributed keras
