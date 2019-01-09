# Half-Car-Model-Dynamics
MODSIM Unit CW3 Dynamic Modelling of a Half Car Model

## Submission Information
In the submissions folder, or Moodle folder;

__halfmodel_improved_17b.slx__ is the final half car model with all improvements. Note this does not function with unrealistic positive step inputs (it would break the wheel)! This can be overridden by setting tyreLimit to a value larger than twice the step input value.
The conversion for 17b means some graphical elements aren't fully compatible but this does not impact the model's functionality in any way.

__initModel.m__ is the setup file for the half car model. This should autorun on opening the model provided they are both in the path.

__quartermodel.slx__ is the final quarter car model in non-linear form.

__initModelQuarter.m__ is the setup file for the quarter car model. This should autorun on opening the model provided they are both in the path.

_These models are verified to work fully as expected at time of release. Please check your coefficients and inputs carefully if you do not get the results you expect._
