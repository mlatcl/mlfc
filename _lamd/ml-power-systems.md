\\subsection{Practical 6: Machine Learning for Power Systems}



\\subsection{Primer: Power Systems}



\\notes{NOTE: You don't have to read this primer, although it is helpful to do so. If you wish to skip it, feel free to jump to \[Section 7](#7-the-ieee-30-bus-test-case).



Before getting into the machine learning aspects, we shall first get a basic introduction to power systems that will help us understand the dataset better.



\## 1. What is a Power System?

A \*\*power system\*\* is a network that produces, transports, and consumes alternating-current (AC) electrical energy. Think of it as the complex system that comprises generation, transmission, distribution, and consumption of electrical power. It can be modelled as a graph where nodes are the \_buses\_ and edges are the \_lines/branches\_. Below is a sample graph representing a power system.



<center>

&nbsp;   <img src="https://invenia.github.io/blog/public/images/power\_grid\_graphs.png">

</center>



Let's define some terms.



\*\*Bus\*\*  

A \_bus\_ is simply a network node (a graph vertex) where equipment connects and where we measure or impose voltages and injections. Here are some examples:

\- Bus G: a generator terminal (power plant tied to the network).

\- Bus S: a substation feeding a neighborhood.

\- Bus L: a distribution node where many customer loads connect.



At a bus we typically care about voltage (magnitude and \*phase\*) and how much power is being injected or withdrawn there.



\*\*Phase\*\*  

AC voltages and currents are sinusoids. A \_phase\_ refers to one such sinusoidal waveform. Many power systems use \*\*three-phase\*\* (three sinusoids separated by 120°)—that’s how large systems deliver power efficiently. When electrical engineers analyse power systems, they formulate equations known as power flow equations.



For conceptual power-flow equations, they normally analyse one representative phase (single-phase equivalent) because steady-state three-phase, balanced systems reduce to three identical single-phase problems shifted in time. So when we talk about a voltage $V=V\\angle\\theta$  we refer to the magnitude and the \_phase angle\_ $\\theta$ (the time shift of the sinusoid).}



\\subsubsection{2. Representing Voltages and Currents as Phasors}



\\notes{A steady sinusoidal voltage is

$$v(t)=V\_m \\cos⁡(ωt+θ)$$



where $V\_m$​ is amplitude, $\\omega$ is angular frequency, and $\\theta$ is the phase offset.



When everything is sinusoidal at the same $\\omega$ (steady-state), we replace $v(t)$ by its phasor

$$\\mathbf{V} = V e^{j\\theta}$$

where VVV commonly denotes RMS amplitude (engineer’s convention) and θ\\thetaθ is the phase angle. Similarly current $i(t)$ $\\leftrightarrow$ phasor $\\mathbf{I}=I e^{j\\phi}$.



By doing this, differentiation/integration become algebraic multiplications by $j\\omega$, and Ohm’s/Kirchhoff’s laws become \_algebraic equations in the complex domain\_. This converts time-domain differential equations into linear algebra with complex numbers — huge simplification.



\## 3. AC Power is Complex

A \*\*port\*\* is a terminal or pair of terminals through which a device exchanges electrical power with the network. Practically, a generator terminal is a port (the place it injects current/voltage to the grid).



\*\*Complex power\*\* $S$ at a port is defined as $S=P+jQS$.

&nbsp;   - $P$ (real/active power) is the energy per second doing useful work (watts).

&nbsp;   - $Q$ (reactive power) is the power that oscillates back and forth because of inductors/capacitors — it doesn’t do long-term work but it affects voltages and currents.



In phasor form we use:  

&nbsp; $$S=VI^\*$$

&nbsp; where $V$ and $I$ are complex phasors and $I^\*$ is the complex conjugate of the current phasor. This convention gives $P$ and $Q$ values that are independent of the arbitrary reference angle.}



\\subsubsection{4. Real, Reactive, and Apparent power}



\\notes{Think of the grid as a big circuit built from resistors (R), inductors (L), and capacitors (C). These elements create different relationships between voltage and current:

\- \*\*Resistor (R):\*\* voltage and current are \_in phase\_. Energy is dissipated as heat → this is \_real\_ (active) power $P$.

\- \*\*Inductor/Capacitor (L/C):\*\* voltage and current are \_out of phase\_. Energy is alternately stored in fields and returned to the network → \_reactive\_ behavior $Q$. Over a cycle, ideal L/C do not consume net energy.



\*\*Formal quantities:\*\*

\- \*\*Complex power (apparent):\*\* $S=P+jQS$.

&nbsp;   - $P$ = real/active power (watts) = average power delivered/consumed.

&nbsp;   - $Q$ = reactive power (vars) = oscillatory exchange due to L/C.

&nbsp;   

\- \*\*Apparent power magnitude:\*\* $∣S∣= V\_\\text{rms} I\_\\text{rms}$.

&nbsp;   

\- \*\*Power factor:\*\* $\\text{PF} = P / |S| = \\cos(\\phi)$, where $\\phi$ is the phase difference between voltage and current phasors.



\*\*Why reactive power matters operationally:\*\*  

Reactive power does not perform useful work but increases currents for the same real power. Higher currents lead to more $I^2 R$ losses, larger thermal stress on lines and transformers, and difficulty maintaining acceptable voltages. Operators must manage reactive power to keep voltages in safe ranges and limit losses.}



\\subsubsection{5. Power Flow Expressions}



\\notes{### Part 1: The Simple Case

Consider two buses $i$ and $j$ connected by a single series line. The quantity $p\_{ij}$​ denotes the \_real power flowing on that branch from bus $i$ toward bus $j$\_ (positive means power leaves $i$ toward $j$). Similarly $q\_{ij}$​ is the reactive power on that same directed branch.



Let

\- $V\_i = v\_i e^{j\\theta\_i}$ and $V\_i = v\_i e^{j\\theta\_j}$ be the complex phasor voltages at the two buses (magnitudes $v$, angles $\\theta$).

\- The line series admittance is $y\_{ij} = g\_{ij} + j b\_{ij}$ (the inverse of the line impedance $z\_{ij}=r\_{ij}+j x\_{ij}$).

\- The angle difference $\\delta\_{ij}:=\\theta\_i - \\theta\_j$



Then, the current from $i$ to $j$  is

$$I\_{ij}=y\_{ij}​(V\_i​ − V\_j​)$$

The complex power at bus $i$ into the branch is

$$

\\begin{align}

&nbsp;	S\_{ij} \&= V\_i I^\*\_{ij} \\\\\\\\

&nbsp;	\&= V\_i (y^\*\_{ij}​(V^\*\_i​ − V^\*\_j​)) = v^2\_i y^\*\_{ij} - v\_i v\_j e^{j\\delta\_{ij}}y^\*\_{ij}

\\end{align}

$$

where $y^\*\_{ij} = g\_{ij} - jb\_{ij}$. We then take the real and imaginary parts to get the real and reactive branch powers, which are:

\* \*\*Real power on branch $i$ → $j$\*\* :

&nbsp; $$p\_{ij} = v\_i^2 g\_{ij} - v\_i v\_j (g\_{ij} \\cos \\delta\_{ij} + b\_{ij} \\sin \\delta\_{ij})$$

\* \*\*Reactive on branch $i$ → $j$\*\*:

&nbsp; $$q\_{ij} = -v\_i^2 b\_{ij} - v\_i v\_j (g\_{ij} \\sin \\delta\_{ij} - b\_{ij} \\cos \\delta\_{ij})$$



Note the following:

\- The first term ($v\_i^2 g\_{ij}$ in $p\_{ij}$ and $-v\_i^2 b\_{ij}$ in $q\_{ij}$) are \_local\_ contributions (depend only on bus $i$ and the branch admittance).

\- The second term contains $v\_i v\_j$​ and trig of the angle difference: these are \_coupling\_ terms between buses $i$ and $j$.



\*\*Note the nonlinearity:\*\* Terms like $v\_i v\_j \\cos\\delta\_{ij}$ ​and $\\sin\\delta\_{ij}$​ produce \*products of magnitudes\* and \*trigonometric functions of angle differences\*. Those are the nonlinear pieces that make AC power flow non-linear and non-convex.



\*However\*, if you set $v\_i = v\_j =1\\;pu$ and assume small $\\delta\_{ij}$​ and small $r$ vs $x$, you can linearize these expressions (that leads to the DC approximation).



\### Part 2: The General Case - Nodal Power Balance

At a given bus $i$, many branches (lines) can meet. The \*\*net complex power injected\*\* at bus $i$ (positive if injected by generation, negative if consumed by loads) equals the sum of the complex powers on all branches leaving $i$ plus any shunt injections at the bus. This is the (complex) nodal power balance — it enforces Kirchhoff’s current law and defines the power-flow equations we solve.



We end up with these equations:

\- \*\*Nodal real power injection at bus $i$:\*\*

$$P\_i \\;=\\; \\sum\_{j=1}^N v\_i v\_j\\big(G\_{ij}\\cos\\delta\_{ij} + B\_{ij}\\sin\\delta\_{ij}\\big)$$

\- \*\*Nodal reactive power injection at bus $j$:\*\*

$$Q\_i \\;=\\; \\sum\_{j=1}^N v\_i v\_j\\big(G\_{ij}\\sin\\delta\_{ij} - B\_{ij}\\cos\\delta\_{ij}\\big)$$



\### Part 3: What are we solving?

We are given \_specified\_ injections at each bus (depending on bus type):



\- For a \*\*PQ bus\*\*: specified ($P\_i^\\text{spec}$, $Q\_i^\\text{spec}$).

\- For a \*\*PV bus\*\*: specified ($P\_i^\\text{spec}$, $Q\_i^\\text{spec}$) (reactive $Q\_i$​ is unknown).

\- For the \*\*slack bus\*\*: specified ($V\_i^\\text{spec}$, $\\theta\_i^\\text{spec}$) (it absorbs any net mismatch).



The \*\*computed\*\* injections from the current voltage guess are $P\_i^\\text{calc}(V, \\theta)$, $Q\_i^\\text{calc}(V, \\theta)$) given by the nodal formulas above. They can be obtained by simulation e.g. on MATLAB Simulink.



The mismatch (power residuals) for each bus are:



for each bus:

$$

\\begin{align}

&nbsp;	\\Delta P\_i(V,\\theta) \&\\;=\\; P\_i^{\\text{spec}} \\;-\\; P\_i^{\\text{calc}}(V,\\theta)\\\\\[10pt]

&nbsp;	\\Delta Q\_i(V,\\theta) \&\\;=\\; Q\_i^{\\text{spec}} \\;-\\; Q\_i^{\\text{calc}}(V,\\theta)

\\end{align}

$$



Collect the relevant mismatches into a vector $F(x)$ where $x$ stacks the \*\*unknown\*\* voltage magnitudes and angles (the exact components of $x$ depend on bus types). For example, if all PQ buses have unknown $(v,\\theta)$ and PV buses have unknown $\\theta$, then



$$

F(x) = \\begin{bmatrix}\\text{(unknown angles)}\\\\\[2pt]\\text{(unknown magnitudes)}\\end{bmatrix}, \\qquad F(x) = \\begin{bmatrix}\\Delta P\\\\\[2pt]\\Delta Q\\end{bmatrix}

$$

(with rows corresponding only to the equations that must be satisfied — e.g., no $\\Delta Q$ row for a PV bus where $Q$ is not specified).



Concisely put, our \*\*goal\*\* is to \*find x (unknown voltages/angles) such that $F(x)=0$\* i.e., \_find the voltage magnitudes and angles so that every bus’s power balance holds\_.}



\\subsubsection{6. Optimal Power Flow (OPF)}



\\notes{When we solve the power flow equations alone, we are simply finding voltages and currents consistent with physics. The only constraints we are following are physical ones. But in real power grids, we are concerned with more than just physics. For example, we might be interested in solving the power flow equations such that generator cost is minimised. This is especially useful in complex power grids where there many generators generating power at different costs. Our desire would be to \*solve the power flow equations such that both the physical constraints and economic constraints are satisfied\*.



This is known as optimal power flow (OPF). The goal of OPF is to choose control variables (generator outputs, tap settings, etc.) to minimize an objective (cost, losses, whatever) subject to the physical power-flow equations and operational limits. To the power flow equations, we add:

\- Decision variables: generator real power $P\_G$, reactive power $Q\_G$, and voltage magnitudes $V$.

\- Objective function e.g., minimise cost

\- Constraints:

&nbsp;	- PF equations must hold

&nbsp;	- Generator limits ($P^{min}\_G$, $P^{max}\_G$ )

&nbsp;	- Voltage limits ($V^{min}\_G$, $V^{max}\_G$ )

&nbsp;	- Line limits (flows can't exceed ratings)



In short, OPF says \*choose generator setpoints and voltages that satisfy physics and minimize some objective\*.



\### Part 1: AC-OPF

Here we use the \*\*full nonlinear PF equations\*\* and solve it subject to chosen constraints.



$$

\\begin{aligned} \\min\_{P\_G, Q\_G, V, \\theta} \& \\quad \\sum\_{g \\in \\text{generators}} C\_g(P\_{Gg}) \\\\ \\text{s.t.} \& \\quad P\_i = P\_{Gi} - P\_{Li}, \\\\ \& \\quad Q\_i = Q\_{Gi} - Q\_{Li}, \\\\ \& \\quad \\text{(PF equations hold for all buses)} \\\\ \& \\quad P\_{G}^{\\min} \\le P\_G \\le P\_{G}^{\\max}, \\\\ \& \\quad V^{\\min} \\le V \\le V^{\\max}, \\\\ \& \\quad |S\_{ij}| \\le S\_{ij}^{\\max}. \\end{aligned}

$$

\- $P\_{Li}$, $Q\_{Li}$: load demand at bus $i$

\- $C\_g(\\cdot)$: generator cost (often quadratic)

\- $S\_{ij}$: apparent power flow on line $i$-$j$



AC-OPF is accurate but hard. The equalities are nonlinear and nonconvex (products $v\_i v\_j$​ and trig of angle differences). It is therefore a nonconvex constrained nonlinear program.



\### Part 2: DC-OPF

To make OPF tractable, we simplify it as follows:

\- Assume all voltages are ~$1$ p.u. (ignore magnitude variation)

\- Ignore reactive power

\- Assume lines are mostly inductive (resistance $\\approx 0$)



Then:

$$P\_{ij} = \\frac{1}{X\_{ij}} (\\theta\_i - \\theta\_j)$$

where $X\_{ij}$ is line reactance.



The nodal balance becomes:

$$P\_i = P\_{Gi} - P\_{Li} = \\sum\_i \\frac{1}{X\_{ij}} (\\theta\_i - \\theta\_j)$$

which is linear system - much easier to solve.



$$

\\begin{aligned}

\\min\_{P\_G, \\theta} \& \\quad \\sum\_{g \\in \\text{generators}} C\_g(P\_{Gg}) \\\\ \\text{s.t.} \& \\quad P\_{Gi} - P\_{Li} = \\sum\_j \\tfrac{1}{X\_{ij}}(\\theta\_i - \\theta\_j), \\\\ \& \\quad P\_G^{\\min} \\le P\_G \\le P\_G^{\\max}, \\\\ \& \\quad |P\_{ij}| \\le P\_{ij}^{\\max}

\\end{aligned}

$$



DCOPF is much faster to solve because it is linear (or convex quadratic). It is widely used in day-to-day market operations but is less accurate because it ignores voltage/reactive effects.}



\\subsubsection{7. The IEEE 30-bus Test Case}



\\notes{It’s a \*\*benchmark power system\*\* model, originally published by the IEEE (Institute of Electrical and Electronics Engineers), that represents a \*small but realistic transmission grid\*. It is a simple approximation of a section of the American power grid as it was in 1961. Researchers and engineers use it to:

\- Test \*\*power flow algorithms\*\*.

\- Validate and compare \*\*ACOPF/DCOPF solvers\*\*.

\- Benchmark \*\*optimization, machine learning, or control methods\*\*.



\### Its Components

This benchmark system comprises:

\- \*\*30 buses (nodes)\*\*: These are connection points — either loads, generators, or junctions.

\- \*\*41 transmission lines/branches\*\*: They connect buses, each with reactance, resistance, and line limits.

\- \*\*6 generators\*\*: Located at specific buses (e.g., bus 1 is the slack/reference bus). They supply real and reactive power within limits.

\- \*\*Loads\*\*: Many buses represent demand, specified in MW (real power) and Mvar (reactive power).

\- \*\*Shunts\*\*: Some buses include shunt elements (like capacitors) to support voltage.



So it can be pictured as a \*\*graph\*\* with 30 nodes and 41 edges, but where each node has electrical variables (voltage, angle, load, generation).



\### Simulating the IEEE 30-bus Test Case on MATLAB

This benchmark system can be simulated on MATLAB using MATPOWER, an open-source MATLAB/Octave package for \*\*power system simulation and optimization\*\*. Think of it as the \*\*framework\*\* (like PyTorch or TensorFlow) that loads the dataset and runs baseline solvers.



It’s widely used by researchers and utilities for:

\- Solving \*\*power flow (PF)\*\* problems.

\- Running \*\*optimal power flow (OPF)\*\* (both AC and DC).

\- Benchmarking new algorithms.



Think of it as a “toolbox” where you load a test case (like IEEE 30-bus) and run solvers. Using MATPOWER, you can run PF, OPF (AC and DC) to solve the power flow equations



The dataset we will use in this practical is generated after running a simulation of the IEEE 30-bus test case in MATPOWER.}



\\subsubsection{8. Understanding and Using the Dataset}



\\notes{In this lab, we shall use a dataset generated by solving AC-OPF of the IEEE 30-bus test case using MATPOWER. Our goal is to compare the performances of two machine learning models trained on this dataset at solving the AC-OPF problem. The simulation results were initially saved in the MATLAB `.mat` format but the code for extracting the data into familiar formats has been provided.



Let's get into it.}



\\code{import sys

sys.path.append(".")



import numpy as np

from sklearn.linear\_model import LinearRegression



import matplotlib.pyplot as plt}



\\code{from fynesse.access import extract\_data

from fynesse.assess import print\_err, plot\_comparison\_bar

from fynesse.address import train\_lm, get\_predictions}



\\notes{First we need to load our data. At first, our data is stored in a dictionary with three keys - `train`, `val`, and `test`, which store the training, validation, and  test data we will use for our models.}



\\code{data = extract\_data(data\_path = "matpower\_format/case30", standardise\_outputs=False)

keys = \['train', 'val', 'test']}



\\notes{Each of these three dictionaries have four arrays that can be accesses using four keys - `X`, `Y`, `A`, `B`. These four arrays are the model inputs, model outputs, network adjacency matrices, and bus susceptances, respectively. For this lab, we shall mostly be interested in the model inputs and ouputs because we will train our models using them. We will also use the DCOPF data.}



\\code{data\[keys\[0]].keys()}



\\subsubsection{# Examining the Data}



\\notes{Before proceeding with any modelling, please take some time to understand the variables in the dataset by going through this \[README](README.md) file. In particular, focus on the `X` and `Y` arrays. Try to gain some intutions for the meaning of the dataset.}



\\subsubsection{## Task 1}



\\notes{Focusing on the train set, examine the inputs `X`. Notice the shape of the array.



What do you think the various dimensions of the array correspond to?



(\*\*Hint:\*\* Think back to the IEEE 30-bus test case).}



\\code{X\_train = data\[keys\[0]]\['X']

X\_train.shape}



\\notes{`X` train array has shape `(600, 30, 4)`.

\- Dimension 0 - the number of samples

\- Dimension 1 - the number of buses in the system

\- Dimension 2 - the number of features in the dataset i.e. $P\_d$, $Q\_d$, `mag\_Sd` and `ang\_Sd`.}



\\subsubsection{## Task 2}



\\notes{Do the same for `Y`.



\*\*Question\*\*: What do the dimensions correspond to?}



\\code{# TODO

\# Y\_train = ?}



\\subsubsection{## Task 2 Extended}



\\notes{Look at the test and validation sets as well}



\\code{# TODO}



\\subsubsection{# Some Basic Prediction Models}



\\notes{We will now use our data to see the performances of three basic solutions to the OPF problem:

\- \*\*Gridwise averaging approach\*\*: Computes an average for outputs across the whole grid, leading to a single output for the entire grid. This average can be used as a baseline predictor for voltage and phase at a bus.

\- \*\*Nodewise averaging approach\*\*: Computes an average for outputs per bus (node). So we begin with $n$ samples for each bus and aggregate those samples to end with $1$ for each bus. This average can be used as a baseline predictor for voltage and phase at a bus.

\- \*\*DC-OPF\*\*: The `dcopf` results from the simulation. It is a linearised simplification (and thus an estimate) of the ACOPF.



Our comparison metrics will be mean absolute error (MAE), mean squared error (MSE), and fraction of variance unexplained (FVU).}



\\subsubsection{# A. Gridwise Averaging}



\\notes{

To  average our outputs across the entire grid, we compute the mean of the array for each of the outputs (`Vm` and `Va`). For each output, the averaging yields a scalar result. Because we would like to use this result as a basline predictor, we will need to expand its dimensions to match its original shape for comparison.



Notice how we are expanding our predictor output using `np.resize()`. Why did we do that? To understand why, check the shapes of `ym`, `np.resize(ym, data\[key]\['Y']\[...,0].shape)`, and `data\[key]\['Y']\[...,0]`. Do you notice that the shapes of `data\[key]\['Y']\[...,0]` and `np.resize(ym, data\[key]\['Y']\[...,0].shape)` are the same?



We do the resizing because, for us to easily compare two arrays together using regression metrics like MSE, they should be of the same shape so that residuals can be computed using vectorised operations. This is very important. We will ensure we do this for all other approaches we study in this lab.}



\\code{# Gridwise Averaging Approach --> average over entire grid

ym, ya = data\[keys\[0]]\['Y']\[...,0].mean(), data\[keys\[0]]\['Y']\[...,1].mean()



gridwise = {}

for key in keys:

&nbsp;   Vm\_train = data\[key]\['Y']\[...,0]

&nbsp;   Va\_train = data\[key]\['Y']\[...,1]

&nbsp;   gridwise.update({key : (np.resize(ym, Vm\_train.shape), np.resize(ya, Va\_train.shape))})



\# err\_gw = print\_err(target=data, pred\_dict=gridwise)}



\\notes{We saved our performance metrics in a dictionary called `gridwise`. The structure of this dictionary is important because we shall use it to store the metrics for all the "models" we shall use for prediction in this lab. This structure is as follows:

```python

{

&nbsp;   "train": (Vm\_train\_pred, Va\_train\_pred),

&nbsp;   "val": (Vm\_val\_pred, Va\_val\_pred),

&nbsp;   "test": (Vm\_test\_pred, Va\_test\_pred)

}

```



where `Vm\_train\_pred.shape = data\[keys\[0]]\['Y']\[...,0].shape` and `Va\_train\_pred.shape = data\[keys\[0]]\['Y']\[...,1].shape`. The same applies for `val` and `test`. Pay attention to this structure because you will need it when calculating the performance metrics in the next step.



Let's now calculate the regression metrics for the train, validation, and test sets.}



\\code{err\_dict = {}

target = data.copy()

for key in gridwise.keys():

&nbsp;   complex\_target = data\[key]\['Y']\[:,:,0] \* np.exp(1j \* data\[key]\['Y']\[:,:,1])

&nbsp;   V\_pred = gridwise\[key]

&nbsp;   V\_target = target\[key]\['Y']

&nbsp;   # print(key, V\_pred\[0].shape, V\_target\[:,:,0].shape)



&nbsp;   if V\_pred\[0].shape == V\_target\[:,:,0].shape:

&nbsp;       mag\_err = V\_pred\[0] - V\_target\[:,:,0] # Vm

&nbsp;       ang\_err = V\_pred\[1] - V\_target\[:,:,1] # Va

&nbsp;       complex\_pred = gridwise\[key]\[0] \* np.exp(1j \* gridwise\[key]\[1])



&nbsp;   else:

&nbsp;       print("Shape mismatch! Broadcasting ...")

&nbsp;       mag\_err = gridwise\[key]\[0]\[0,:] - target\[key]\['Y']\[:,:,0] # Vm

&nbsp;       ang\_err = gridwise\[key]\[1]\[0:,] - target\[key]\['Y']\[:,:,1] # Va

&nbsp;       complex\_pred = gridwise\[key]\[0]\[0:,] \* np.exp(1j \* gridwise\[key]\[1]\[0,:])



&nbsp;   complex\_err =  complex\_pred - complex\_target



&nbsp;   print(f"\\n{key.capitalize()} set metrics:")

&nbsp;   print(f"Vm MAE: {np.abs(mag\_err).mean():.5e}")

&nbsp;   print(f"Vm MSE: {np.square(mag\_err).mean():.5e}")

&nbsp;   print(f"Vm FVU: {(np.square(mag\_err).mean() / V\_target\[:,:,0].var()):.5e}")



&nbsp;   print("")



&nbsp;   print(f"Va MAE: {np.abs(ang\_err).mean():.5e}")

&nbsp;   print(f"Va MSE: {np.square(ang\_err).mean():.5e}")

&nbsp;   print(f"Va FVU: {(np.square(ang\_err).mean() / V\_target\[:,:,0].var()):.5e}")}



\\subsubsection{## Task 3 - Function to Calculate Metrics}



\\notes{For reusability, create a function `print\_err` to display the metrics and save them for later use. Most of the code for this has already been provided. You should add this function to you Access Assess Address pipeline.}



\\code{def print\_err(target, pred\_dict):

&nbsp;   """

&nbsp;   Prints error metrics between target and predictions.

&nbsp;   Args:

&nbsp;       target (dict): Dictionary containing true values with keys 'train', 'val', 'test'.

&nbsp;                      Each key maps to another dict with keys 'X', 'Y', 'A', and 'B'.

&nbsp;       pred\_dict (dict): Dictionary containing predicted values with keys 'train', 'val', 'test'.

&nbsp;                         Each key maps to a tuple of (predicted\_magnitudes, predicted\_angles).



&nbsp;   Returns:

&nbsp;       err\_dict (dict): Dictionary containing error metrics for each dataset split.

&nbsp;   """

&nbsp;   err\_dict = {} # for saving the metrics

&nbsp;   for key in pred\_dict.keys():

&nbsp;       pass

&nbsp;       # TODO



&nbsp;       # 1. Calculate the error in predicted magnitudes and angles

&nbsp;       # 2. Also calculate the error in complex form for completeness

&nbsp;       # 3. Compute and print MAE, MSE, and FVU for each of these errors

&nbsp;       # 4. Save and return these metrics in a dictionary for later use



&nbsp;   # return err\_dict



&nbsp;   raise NotImplementedError("Function logic not yet implementd.")}



\\subsubsection{# B. Nodewise Averaging}



\\notes{

We average the outputs (`Vm` and `Va`) per bus/node. We begin with a `(n\_samples x n\_buses x n\_outputs)` array for the entire system and end up with a `(n\_buses x n\_outputs)` array i.e. a vectors of size n\_buses for each of the outputs.



Let's try to think about how should perform this  averaging. We know that our arrays have shape `(n\_samples, n\_buses, n\_outputs)`. This tells us that at each bus/node, we are measuring `n\_output` variables `n\_samples` times. Nodewise averaging means that for each of the variables, we average all the samples taken so that we end up with only one value at each node for each varible. For example, at bus/node 1, we have one value for var\_1 and one for var\_2. This is what we mean when we say we begin with a `(n\_samples x n\_buses x n\_outputs)` array and end up with a `(n\_buses x n\_outputs)` array. Think about this can be implemented in NumPy.



Afterwards, we will use the function we just created to compute the metrics of this baseline model.



\#### Task 4 - Implement Nodewise Averaging

Now you have all you need to implement nodewise averaging.}



\\code{# TODO

\# Nodewise Averaging Approach --> average per node

\# The code for computing ym and ya is very similar to the gridwise approach, but you need to make a small change. Think about what that change is.



err\_nw = None}



\\subsubsection{# C. DC-OPF}



\\notes{

We treat the DCOPF output of the simulation as a baseline model and compute the metrics. But first we need to access the DCOPF outputs from the simulation. We can do this by first accessing the array saved in the susceptance (`B`) key of `data\[key]` dictionary e.g., `data\['train]\['B']` or `data\['val']\['B']`. This gives an array of length `n\_samples` where each element is a dictionary with multiple keys, one of which is `V-dcopf` which we are interested in.



So we can read one sample of DCOPF using `data\['train']\['B']\[i]\['V-dcopf']` for some `i`. Each sample, as you might guess is of shape `(n\_buses, n\_outputs)`, which in our case is (30, 2). You can see how this completes the picture because `n\_samples` samples of shape `(n\_buses, n\_outputs)` makes an aggregate array of shape `(n\_samples, n\_buses, n\_outputs)`. Now all we will need to do is write some clever code for accessing the DCOPF of each sample and then stack them together in a single array. Of course we will need to this for each set of data i.e., train, test, and validate.



\#### Task 5 - Check Performance of DC-OPF

The code for preparing the data has been provided for you here so that you can focus on what you need to learn.}



\\code{dcopf = {}

for key in keys: # 'train', 'val', 'test'

&nbsp;   tmp = np.array(\[item\['V-dcopf'] for item in data\[key]\['B']]) # --> \[n\_samples, n\_buses, n\_outputs]

&nbsp;   ym = tmp\[..., 0]

&nbsp;   ya = np.pi \* (tmp\[..., 1]/180) # convert degrees to radians



&nbsp;   # TODO update the dcopf dictionary. Hint: look at how we did it for the gridwise and nodewise approaches.

&nbsp;   dcopf.update()

del tmp



err\_dc = None}



\\subsubsection{# D. Linear Model}



\\notes{

Now we turn our attention to a more sophisticated model - linear regression. Our goal is to build a model to predict `Vm` and `Va` at each bus using only two out of the four features - `Pd` and `Qd`. Our input is 3-dimensional with shape `(n\_samples, n\_buses, n\_features)`. We can merge the last two dimensions so that the new shape is `(n\_samples, n\_buses \* n\_features)` so that our input has `n\_buses \* n\_features` columns that we can use as features for our linear regression model.



But there is a catch. Some buses are inactive i.e., there `Pd` and `Qd` values are zero. We should build our model with data from only active buses. So we'll drop readings from inactive buses. The new number of columns will be some $n \\leq n\_{buses} \\times n\_{features}$



Something else. It's important to understand what the model we are building actually means in the context of our IEEE 30-bus power system. The outputs `Vm` and `Va` are measured at each bus. We want to predict these values at each bus too, and we are using the `Pd` and `Qd` measurements from all active buses in the grid to build our model. That means we will have one model to predict each output at each of the buses i.e., `n\_buses` models to predict `Vm` and another `n\_buses` to predict `Va`.



\#### Task 6 - Write a Function to Train Linear Regression Models

Write the function `train\_lm` to train and save these models.}



\\code{inp = data\[keys\[0]]\['X']\[:,:,:2] # --> (n\_samples, n\_buses, n\_features)

out = data\[keys\[0]]\['Y'] # --> (n\_samples, n\_buses, n\_outputs)



def train\_lm(inp, out, model=LinearRegression):

&nbsp;   """

&nbsp;   Trains linear regression models for each bus/node in the power system.



&nbsp;   Args:

&nbsp;       inp (np.ndarray): Input features of shape (n\_samples, n\_buses, n\_features).

&nbsp;       out (np.ndarray): Output targets of shape (n\_samples, n\_buses, n\_outputs).

&nbsp;       model (class): Linear regression model class from sklearn. Default is LinearRegression.



&nbsp;   Returns:

&nbsp;       mag\_models (list): List of trained models for voltage magnitudes (Vm) at each bus.

&nbsp;       ang\_models (list): List of trained models for voltage angles (Va) at each bus

&nbsp;   """



&nbsp;   model = LinearRegression



&nbsp;   node\_count = out.shape\[1]

&nbsp;   mag\_models, ang\_models = \[], \[]



&nbsp;   # TODO

&nbsp;   # 1. Find index of nodes with nonzero loads and use as input to model

&nbsp;   nonzero\_indx = np.abs(inp\[:,:,:2].mean(0)).sum(1) != 0 # boolean index of nonzero (active) load buses



&nbsp;   # 2. Reshape the input to shape (n\_samples, n\_features\*n\_nonzero\_buses). Use `nonzero\_indx` as a mask to filter active buses

&nbsp;   # 3. Train the models



&nbsp;   # return mag\_models, ang\_models



&nbsp;   raise NotImplementedError("Function logic not yet implementd.")



\# train\_lm(inp, out)}



\\notes{We've written a helper function for you to obtain the predictions from the linear models.}



\\code{def get\_predictions(models, inp):

&nbsp;   shape = inp.shape\[:2]

&nbsp;   ym, ya = np.zeros(shape), np.zeros(shape)

&nbsp;   nonzero\_indx = np.abs(inp\[:,:,:2].mean(0)).sum(1) != 0

&nbsp;   inp\_reshaped = inp\[:,nonzero\_indx,:2].reshape(-1, nonzero\_indx.sum()\*2) # --> (samples, n\_features\*n\_nonzero\_buses)



&nbsp;   for i in range(shape\[1]): # prediction for each bus yields array of shape \[n\_samples,]

&nbsp;       ym\[:,i] = models\[0]\[i].predict(inp\_reshaped)

&nbsp;       ya\[:,i] = models\[1]\[i].predict(inp\_reshaped)



&nbsp;   return (ym, ya)}



\\subsubsection{## Task 7 - Obtain Predictions of the Linear Model and Store Them}



\\notes{Using the helper function provide, obtain the linear model's predictions and store them in a dictionary as you did with the other models.}



\\code{# Linear Model

m\_mod, a\_mod = train\_lm(data\[keys\[0]]\['X'], data\[keys\[0]]\['Y'], LinearRegression)

lm = {}



\# TODO

\# store predictions in lm dictionary



err\_lm = print\_err(target=data, pred\_dict=lm)}



\\notes{The metrics of all our models have been saved in dictionaries. Now we need to visualise them. Try to think about the performance of the four models we have used so far - gridwise, averaging, nodewise averaging, DCOPF, and linear regression. Which do you think has the best performance and which one has the best performance? Think about how those models are built and make an educated guess about how they performed. Rank them in descending order of performance, say based on MSE.}



\\code{# TODO

\# Rank the models based on MSE (your guess). Also discuss why you think they will perform the way you think?}



\\notes{Now let's visualise the metrics. We begin with `MSE`, and then proceed to the rest.}



\\code{errors = \[err\_gw, err\_nw, err\_dc, err\_lm]

err\_key = "MSE"

methods=\['grid', 'node', 'dcopf', 'lm']



show\_mag, show\_ang, log, sel\_key = True, True, True, None

rows = len(errors\[0].keys()) if sel\_key is None else len(sel\_key)

cols = int(show\_mag) + int(show\_ang)



if err\_key == "MCEM":

&nbsp;   cols = 1

&nbsp;   show\_mag, show\_ang = False, False

if cols == 0:

&nbsp;   raise ValueError("No columns in the figure")



fig, axs = plt.subplots(rows, cols, sharex=True)

bar\_colors = \[

&nbsp;   'tab:blue',

&nbsp;   'tab:orange',

&nbsp;   'tab:green',

&nbsp;   'tab:red',

&nbsp;   'tab:purple',

&nbsp;   'tab:brown'

&nbsp;   'tab:pink',

&nbsp;   'tab:gray',

&nbsp;   'tab:olive'

&nbsp;   'tab:cyan',

] \* 5



sel\_key = list(errors\[0].keys()) if sel\_key is None else sel\_key



if rows == 1 and cols == 1:

&nbsp;   sel\_col = 'Vm' if show\_mag else 'Va'

&nbsp;   col\_key = sel\_col + ' ' + err\_key

&nbsp;   if err\_key == "MCEM":

&nbsp;       sel\_col = 'Mean Complex Err Mag'

&nbsp;       col\_key = err\_key

&nbsp;   counts = \[error\[sel\_key\[0]]\[col\_key] for error in errors]

&nbsp;   if log:

&nbsp;       axs.set\_yscale('log')

&nbsp;   axs.bar(methods, counts, color=bar\_colors\[:len(counts)])

&nbsp;   axs.set\_ylabel(err\_key)

&nbsp;   axs.set\_title(sel\_col)



elif rows > 1:

&nbsp;   for i, j in enumerate(sel\_key):

&nbsp;       if show\_mag and show\_ang:

&nbsp;           counts = \[error\[j]\['Vm ' + err\_key] for error in errors]

&nbsp;           if log:

&nbsp;               axs\[i, 0].set\_yscale('log')

&nbsp;               axs\[i, 1].set\_yscale('log')

&nbsp;           axs\[i, 0].bar(methods, counts, color=bar\_colors\[:len(counts)])

&nbsp;           axs\[i, 0].set\_ylabel(err\_key)

&nbsp;           if i == 0:

&nbsp;               axs\[i, 0].set\_title('Vm')



&nbsp;           counts = \[error\[j]\['Va ' + err\_key] for error in errors]

&nbsp;           axs\[i, 1].bar(methods, counts, color=bar\_colors\[:len(counts)])

&nbsp;           if i == 0:

&nbsp;               axs\[i, 1].set\_title('Va')



&nbsp;       else:

&nbsp;           sel\_col = 'Vm' if show\_mag else 'Va'

&nbsp;           col\_key = sel\_col+' '+err\_key

&nbsp;           if err\_key == 'MCEM':

&nbsp;               sel\_col = 'Mean Complex Err Mag.'

&nbsp;               col\_key = err\_key

&nbsp;           counts = \[error\[sel\_key\[0]]\[col\_key] for error in errors]

&nbsp;           if log:

&nbsp;               axs\[i].set\_yscale('log')

&nbsp;           axs\[i].bar(methods, counts, color=bar\_colors\[:len(counts)])

&nbsp;           axs\[i].set\_ylabel(err\_key)

&nbsp;           if i == 0:

&nbsp;               axs\[i].set\_title(sel\_col)}



\\notes{For reusability, create a function `plot\_comparison\_bar` that we will use afterwards for plotting the comparison between the various models for a particular metric. The code for this function is already provided in the previous code cell, but you will need to make minor modifications to make it reusable.}



\\code{def plot\_comparison\_bar(errors, err\_key, methods, sel\_key=None, \*, show\_mag=True, show\_ang=True, logy=True):

&nbsp;   """

&nbsp;   Plots a comparison bar chart for different error metrics across various methods.

&nbsp;   """

&nbsp;   rows = len(errors\[0].keys()) if sel\_key is None else len(sel\_key)

&nbsp;   cols = int(show\_mag)+int(show\_ang)



&nbsp;   # TODO

&nbsp;   # Complete the function logic here. You can refer to the code above for guidance.



&nbsp;   raise NotImplementedError("Function logic not yet implementd.")}



\\notes{Using the function you just created, compete the four models you've used so far in terms of:

1\. FVU}



\\code{plot\_comparison\_bar(errors=\[err\_gw, err\_nw, err\_dc, err\_lm], err\_key='FVU', methods=\['grid', 'node', 'dcopf', 'lm'])}



\\notes{2. MAE}



\\code{plot\_comparison\_bar(errors=\[err\_gw, err\_nw, err\_dc, err\_lm], err\_key='MAE', methods=\['grid', 'node', 'dcopf', 'lm'])}



\\notes{3. MCEM}



\\code{plot\_comparison\_bar(errors=\[err\_gw, err\_nw, err\_dc, err\_lm], err\_key='MCEM', methods=\['grid', 'node', 'dcopf', 'lm'])}



\\notes{As you can see, for all the metrics, the worst performance was by the gridwise averging and DCOPF. This was expected because these models are too simple and do not capture the complexity of the grid. One averages across the entire grid while the other linearises a non-linear non-convex optimisation problem. Nodewise averaging was better than those two, but still not really good enough. Although averaging by bus captures more complexity, it's still a simple averaging operation. Linear regression is the best model by far. Not at all suprising because we might expect that there is a linear relationship between power (`Pd` and `Qd`) and voltages (`Vm` and `Va`).}



\\subsubsection{# E. Neural Network}



\\notes{Now we move on to something complex - neural networks. NNs often succeed where simpler models fail because of their ability to learn the non-linear relationships between various variables in a dataset. In this case, we shall train a simple fully-connected multi-layer perceptron (MLP).



Try to think about how we should build the MLP.



How many input and output "neurons" should we have?



For the case of our dataset, do you expect the NN to do better than the linear model?}



\\code{# TODO

\# Size of input and output layers of the MLP

\# Performance of the MLP compared to the linear model}



\\code{import tqdm

import torch

import torch.nn as nn

import torch.optim as optim



from torch.utils.data import DataLoader, TensorDataset

from sklearn.preprocessing import StandardScaler



from fynesse.access import prep\_loaders}



\\subsubsection{## Task 8 - Define a class for an MLP}



\\notes{Your task is to build an MLP with a hidden layer of 1024 units. The number of units in the input and output layers is determined by the nature of your data. If you answered the previous questions about the MLP correctly, you should be good to go here.



The important thing to remember about building NNs in PyTorch is that your class should inherit from `nn.Module` and you must define two methods in your class - an `\_\_init\_\_` method where you define your players and a `forward` method where your forward pass operation is performed.



Once your class definition is fine, consider adding it to your Access Assess Address framework. Where in the framework do you think it should go?}



\\code{# MLP class definition

class MLP(nn.Module):

&nbsp;   def \_\_init\_\_(self, ):

&nbsp;       pass

&nbsp;       # TODO

&nbsp;       # Define the layers of the MLP here



&nbsp;   def forward(self, x):

&nbsp;       pass

&nbsp;       # TODO

&nbsp;       # Define the forward pass



&nbsp;       raise NotImplementedError("Function logic not yet implementd.")}



\\notes{In case you are new to PyTorch, we have defined a helper function `prep\_loaders` for you to load your dataset and convert them into tensors so that we can take advantage of PyTorch's automatic differentiation utility and also train our model faster on a GPU.}



\\code{from fynesse.access import prep\_loaders}



\\notes{Now we need to prepare our data using this function to make them ready for passing into the NN. It is always good practice to scale your data before using them to train any model.}



\\code{inp0, out0 = data\[keys\[0]]\['X'], data\[keys\[0]]\['Y']



num\_nodes = inp0.shape\[1]

num\_samples = inp0.shape\[0]



\# Normalize features

scaler\_inp = StandardScaler()

scaler\_out = StandardScaler()



\# Nonzero mask

bool\_nonzero\_indx = (inp0\[:,:,0] + inp0\[:,:,1]).mean(0) != 0



\# Reshape from 3D to 2D --> \[n\_samples, n\_buses\*n\_features]

inp\_shape = (num\_samples, int(2\*bool\_nonzero\_indx.sum()))



\# Select only 2 features (Pd \& Qd) and nonzero load nodes

sel\_inp0 = inp0\[:, bool\_nonzero\_indx, :2].reshape(inp\_shape)

sel\_out0 = out0.reshape((num\_samples, num\_nodes\*2))



\# scale the data

scaler\_inp.fit(sel\_inp0)

scaler\_out.fit(sel\_out0)



\# convert the data to tensors

loaders = prep\_loaders(data=data, keys=keys, scaler\_inp=scaler\_inp, scaler\_out=scaler\_out,)}



\\notes{Now it's time to train our NN using our scaled data. We will train our MLP in 200 epochs (feel free to experiment with fewer or more epochs). When training models in PyTorch, we need to provide the objective function (known as a criterion) and the algorithm for doing backward propagation (known as an optimiser). There are other quirks for training models with PyTorch, like disabling gradient calculation when running an inference on the model because we are not doing any training. There are many others, but there will suffice for now.



We will track the training and validation losses while the NN is training so that we can visualise them later.It is possible to visualise the progress of training live by using \[TensorBoard](https://docs.pytorch.org/tutorials/recipes/recipes/tensorboard\_with\_pytorch.html), but this is outside the scope of this practical. For now, we shall just save the losses during the training and then visualise afterwards.}



\\code{c\_in, c\_out = int(2\*bool\_nonzero\_indx.sum()), int(2\*num\_nodes)



\# initialise model

model = MLP(c\_in=c\_in, c\_hidden=1024, c\_out=c\_out, num\_layers=5, dp\_rate=0.1)



\# specify loss fn and initialise optimiser

criterion = nn.MSELoss()

optimizer = optim.Adam(model.parameters(), lr=1e-3)





num\_epochs = 200

train\_losses = \[]

val\_losses = \[]



for epoch in tqdm.trange(num\_epochs):

&nbsp;   model.train()

&nbsp;   running\_train\_loss = 0.0

&nbsp;   for batch\_x, batch\_y in loaders\[0]:

&nbsp;       optimizer.zero\_grad()

&nbsp;       outputs = model(batch\_x)

&nbsp;       loss = criterion(outputs, batch\_y)

&nbsp;       loss.backward()

&nbsp;       optimizer.step()

&nbsp;       running\_train\_loss += loss.item()



&nbsp;   # Validation

&nbsp;   model.eval()

&nbsp;   running\_val\_loss = 0.0

&nbsp;   with torch.no\_grad():

&nbsp;       for val\_x, val\_y in loaders\[1]:

&nbsp;           val\_outputs = model(val\_x)

&nbsp;           val\_loss = criterion(val\_outputs, val\_y)

&nbsp;           running\_val\_loss += val\_loss.item()



&nbsp;   avg\_train\_loss = running\_train\_loss / len(loaders\[0])

&nbsp;   avg\_val\_loss = running\_val\_loss / len(loaders\[1])



&nbsp;   train\_losses.append(avg\_train\_loss)

&nbsp;   val\_losses.append(avg\_val\_loss)





model.eval()

running\_test\_loss = 0.0

with torch.no\_grad():

&nbsp;   for test\_x, test\_y in loaders\[2]:

&nbsp;       test\_outputs = model(test\_x)

&nbsp;       test\_loss = criterion(test\_outputs, test\_y)

&nbsp;       running\_test\_loss += test\_loss.item()

&nbsp;   avg\_test\_loss = running\_test\_loss / len(loaders\[2])

&nbsp;   print(f"\\n Final Test MSE Loss: {avg\_test\_loss:.4f}")



\# Plot loss curves

\# Loss curve shows some signs of overfitting the small dataset

\# likely contributes to this but can be mitigated using regularisation

plt.plot(train\_losses, label='Train Loss')

plt.plot(val\_losses, label='Validation Loss')

plt.xlabel("Epoch")

plt.ylabel("MSE Loss")

plt.title("Training and Validation Loss")

plt.legend()

plt.grid(True)

plt.show()}



\\notes{We now need to run an inference on our trained model with the test data to obtain our predictions, and then proceed to obtain the metrics as we did with the other models for comparison. So we need to create a dictionary to store the metrics for the train, validation, and test data.



\#### Task 9 - Obtain the MLP Predictions of the Test Data and Get Performance Metrics

Recall:

&nbsp;- When running an inference on a trained model in PyTorch, what do you need to do?

\- You scaled your dataset before the training. What should do to the model predictions before computing the performance metrics?}



\\code{# TODO

\# what do you need to do when running an inference on a trained model in PyTorch?

\# what should do to the model predictions before computing the performance metrics?}



\\code{loaders = prep\_loaders(data=data, keys=keys, scaler\_inp=scaler\_inp, scaler\_out=scaler\_out, no\_shuffle=True)



mlp\_preds = {}

model.eval()



for (key, loader) in zip(keys, loaders):

&nbsp;   pass

&nbsp;   # TODO

&nbsp;   # 1. obtain model predictions

&nbsp;   # 2. you scaled your dataset before the training. What should do to the model predictions before computing the performance metrics?

&nbsp;   # 3. save the predictions in a dictionary for passing into the print\_err function



err\_mlp = None # print\_err(?)}



\\notes{Now plot a bar chart like the ones we've plotted before, but now including the NN's performance metrics. Compare the performance of all the models.



\- Comment on the performance of the MLP relative to that of DC-OPF and the linear model.

\- Is this performance what you expected? Why or why not?

\- What can you conclude from the results?}



\\code{plot\_comparison\_bar(errors=\[err\_gw, err\_nw, err\_dc, err\_lm, err\_mlp], err\_key='MCEM', methods=\['grid', 'node', 'dcopf', 'lm', 'mlp'])}



\\subsubsection{## End of Practical}



\\notes{

&nbsp;    \_\_\_\_\_\_\_  \_\_   \_\_  \_\_\_\_\_\_\_  \_\_    \_  \_\_\_   \_  \_\_\_\_\_\_\_  \_\_

&nbsp;   |       ||  | |  ||   \_   ||  |  | ||   | | ||       ||  |

&nbsp;   |\_     \_||  |\_|  ||  |\_|  ||   |\_| ||   |\_| ||  \_\_\_\_\_||  |

&nbsp;     |   |  |       ||       ||       ||      \_|| |\_\_\_\_\_ |  |

&nbsp;     |   |  |       ||       ||  \_    ||     |\_ |\_\_\_\_\_  ||\_\_|

&nbsp;     |   |  |   \_   ||   \_   || | |   ||    \_  | \_\_\_\_\_| | \_\_

&nbsp;     |\_\_\_|  |\_\_| |\_\_||\_\_| |\_\_||\_|  |\_\_||\_\_\_| |\_||\_\_\_\_\_\_\_||\_\_|}



\\subsubsection{Thanks!}



\\thanks

