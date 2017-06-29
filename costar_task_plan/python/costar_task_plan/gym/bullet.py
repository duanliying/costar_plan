import os, subprocess, time, signal
import gym
from gym import error, spaces
from gym import utils
from gym.utils import seeding
from gym.spaces import Box

from costar_task_plan.simulation import CostarBulletSimulation

import numpy as np

class BulletSimulationEnv(gym.Env, utils.EzPickle):

    def __init__(self, *args, **kwargs):
        '''
        Read in args to set up client information
        '''

        self.client = CostarBulletSimulation(*args, **kwargs)
        self.action_space = self.client.robot.getActionSpace()

        self.world = self.client.task.world
        self.task = self.client.task.task
        #self.spec = None

    def _step(self, action):
        '''
        Tick world with this action
        '''
        return self.client.tick(action)

    def _reset(self):
        '''
        Reset client and world
        Return current features
        '''
        self.client.reset()
        self.world = self.client.task.world
        return self.world.computeFeatures()

    def taskModel(self):
        '''
        Returns a usable task model.
        '''
        return self.task
