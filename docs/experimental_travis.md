#Test newestest scripts experimental 
dist: trusty
sudo: required

language: bash
install:
   - wget -L 'https://raw.githubusercontent.com/cpaxton/costar_plan/master/setup/experimental.sh?token=ANaJiE2xgEFhlKx9563omSOrmxT1jNLqks5ZdjznwA%3D%3D' -O travis_setup.sh
   - sudo bash travis_setup.sh
   - wget -L 'https://raw.githubusercontent.com/cpaxton/costar_plan/master/tests.sh?token=ANaJiKFtcJ3HESWRykpyO3jh3HEOzV8nks5ZeLXzwA%3D%3D' -O tests.sh
   - wget -L 'https://raw.githubusercontent.com/cpaxton/costar_plan/master/costar_task_plan/tests/cem_test.py?token=ANaJiOGdYEJI82ptwSBp4jzwEDB6Svyyks5ZeL50wA%3D%3D' -O cem_test.py
   - wget -L 'https://raw.githubusercontent.com/cpaxton/costar_plan/master/costar_task_plan/tests/sampler_test.py?token=ANaJiBo0lAbJ0bEHcvmXHuvZC-RFuGN3ks5ZeL58wA%3D%3D' -O sampler_test.py
   - wget -L 'https://raw.githubusercontent.com/cpaxton/costar_plan/master/costar_task_plan/tests/task_test.py?token=ANaJiJK9b7tqZUFwU6QQe39ts-eOyF45ks5ZeL5_wA%3D%3D' -O task_test.py   
   - source $HOME/costar_ws/devel/setup.bash
   - sudo bash tests.sh
