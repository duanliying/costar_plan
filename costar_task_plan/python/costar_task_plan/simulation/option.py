
from costar_task_plan.abstract import AbstractOption, AbstractCondition

class GoalDirectedMotionOption(AbstractOption):
    '''
    This represents a goal that will move us somewhere relative to a particular
    object, the "goal."
    '''

    def __init__(self, goal, *args, **kwargs):
        pass


class GeneralMotionOption(AbstractOption):
    '''
    This motion is not parameterized by anything in particular.
    '''
    def __init__(self, *args, **kwargs):
        pass
