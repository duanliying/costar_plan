
import keras.backend as K
import keras.losses as losses
import numpy as np

from matplotlib import pyplot as plt

from keras.callbacks import TensorBoard
from keras.layers.advanced_activations import LeakyReLU
from keras.layers import Input, RepeatVector, Reshape
from keras.layers import UpSampling2D, Conv2DTranspose
from keras.layers import BatchNormalization, Dropout
from keras.layers import Dense, Conv2D, Activation, Flatten
from keras.layers.recurrent import LSTM
from keras.layers.convolutional_recurrent import *
from keras.layers.merge import Concatenate
from keras.layers.wrappers import TimeDistributed
from keras.losses import binary_crossentropy
from keras.models import Model, Sequential
from keras.optimizers import Adam

'''
This file defines models that rely just on hand-coded features -- obvious
features that we don't need to worry about so much.
'''

def GetEncoder(num_frames, num_features, dense_size, lstm_size, dense_layers=1,
        lstm_layers=1):
    '''
    Get LSTM encoder.
    '''
    xin = Input((num_frames, num_features))
    x = xin
    for _ in xrange(dense_layers):
        x = TimeDistributed(Dense(dense_size))(x)
        x = TimeDistributed(Activation('relu'))(x)
    for i in xrange(lstm_layers):
        #if i == lstm_layers - 1:
        #    sequence_out = False
        #else:
        #    sequence_out = True
        sequence_out = True
        x = LSTM(lstm_size, return_sequences=sequence_out)(x)
        x = Activation('relu')(x)
    return [xin], x


def GetDenseEncoder(xin, dense_size, dense_layers=1):
