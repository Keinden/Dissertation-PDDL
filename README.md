# Attempt to incorperate FSM internal state to multi-agent planning problems for BSc Computer Science dissertation

This is my PDDL code and results I used for my dissertation to incorperate FSM states to agents in multi-agent automated planning domains. It was an attempt to create proactive planning where the planner must maximise the utility of the agent in a particular state before moving the agent to another role because it incurs a 2 action cost penalty.

## Result

It did not work as a whole since the maximisation of the agent would only be seen in optimal plans. For suboptimal plans, there is a likelihood that that the planner will have an agent enter a cycle where an agent enters and exits the state (which can be resolved with another predicate but worsens the state space search) which creates a very undesirable plan as it contains very useless and undesirable action sequences. Furthermore, the requirement to create states means you are adding 2(n-1) states where n is the number of states you are applying into your problem domain worsening the state space explosion problem and state space search problem.

## Domains used

There are 2 domains called Depot and Woodworking. Both domains are not the domains found in the competition. Instead the depot domain was extended to incorperate the delivery of containers in an effort to incorperate everything related to containers and emulate a realistic multi-agent domain. The woodworking domain is a woodworking shop environment that processes "raw" wood into small, medium and large wood pieces and then makes toys, bookshelves and tables finishing with paint. 

## File layout

In each directory with a domain name contains 2 directories called Classical and Temporal. Classical contains the originally modified domains and the new domain. Each of those directories contains two directories: Original and FSM. The "Original" directory contains the more classically programmed problem and domain definitions while the "FSM" directories contains the FSM incorperated concept domains extended from the "Original" domain and problems. Temporal will have the temporal versions of such domains again with the same 2 original and FSM domain and problem.

The Results directory contains the results of each run for classical, fsm and temporal domains. There are several excel worksheets that I used to compile all the data together. 

## If you want the code

Currently there is no license so the default copyright laws apply so feel free to download it to take a look but please do not modify or distribute the code. See [GitHub's licensing page](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/licensing-a-repository#choosing-the-right-license) for more information.