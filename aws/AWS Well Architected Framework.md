# Well Architected Framework notes

tools to help learn and apply AWS best pratices:
- AWS Well-Architected Framework Tool (AWS WA Tool)
- AWS Well-Architected Labs

Based on **five pillars**
1. Operational Excelllence
2. Security
3. Reliability
4. Performance Effiiciency
5. Cost Optimization

**Operational Excellence** - Ability to run and monitor systems to deliver business value and to continually improve supporting processes and procedures.
- Has it's own whitepaper.

**Design Principles** - 
Six design principles for operational excellence in the cloud:
1. Perform operations as code
   - You can define your entire workload as (applications, infrastructure) as code and update it with code. You can implement your operations procedures as code and automate their execution by triggering them in response to events. By performing operations as code you limit human error and enable consistent responses to events.
2. Annotate documentation
   - In the cloud you can automate the creation of annotated documentation after every build (or automatically annotate hand-crafted documentation). Annotated documentation can be used by people and systems. 
3. Make frequent, small reversible changes
    - Design workloads to allow components to be updated regularly. Make changes in small increments that can be reversed if they fail (without affecting customers when possible)
4. Refine operations procedures frequently
    - As you use operations procedurs and evolve your workload, look for opportunities to to improve and evolve your procedurs appropriately

**Security** - Ability to protect information, systems, and assets while delivering business value through risk assessments and mitigation strategies

**Reliability** - Ability of a system to recover form infrastructure of service disruptuons, dynamically acquire computing resources to meet demand, and mitiage disruption such as misconfigurations or transient network issues

**Performance Efficiency** - Ability to use computing resources efficiently to meet system requirements, and to maintain that efficiency as demand changes and technologies evole

**Cost Optimization** - Ability to run systems to deliver business value at the lowest price point

----

#### Terms used in the Well-Architected Framework

- **component** - code, configuration, and AWS Resources that together deliver against a requirment. Often the unit of technical ownership and is decoupled from other components
- **workload** - a set of components that together deliver business value. Usually the level of detail that business and technology leaders communicate about
- **milestones** - mark key changes in your architecture as it evolves throughout the product lifecycle (design, testing, go live, and in production)
- **architecture** - how components work together in a workload. How components communicate and interact is often the focus of architecture diagrams
- **technology portfolio** - collection of workloads that are required for the business to operate

When architecting workloads you may have to make trade-offs between the pillars based upon your business context. 

---

#### On Architecture

On-prem environments usually have a team for technology architecture composed of roles such as Technical Architect (infra), Solutions Architect (software), Data Architect, Networking Architect, and Security Architect.

AWS prefers to distribute capabilities into teams rather than having a centralized team with that capability. 

To ensure that these teams are meeting internal standards AWS has come up with **pratices** (ways of doing things, process, standards, and accepted norms) that focus on enabling each team to have that capability and **mechanisms** that carry out automated checks to ensure standards are being met.


This distributed approach establishes a culture across all roles that **works back** from the customer. 
- Working backward is a fundamental part of our innovation process. We start with the customer and what they want, and let that define and guide our efforts. 

AWS expects every team to have the capability to create architectures and to follow best practices. 

---
#### General Design Principles

The Well-Architected Framework identifies a set of general design principles to facilitate good design in the cloud. They are:
- Stop guessing your capacity needs
  - With cloud computing, you can use as much or as little capacity as you need, and scale up or down automatically.
- Test systems at production scale
  - In the cloud, you can create a production-scale test environment on demand, complete your testing, and then decommission the resources. Since you only pay for the test environment when it's running, you can simulate your live environment for a fraction of the cost of testing on-prem
- Automate to make architectural experimentation easier
  - Automation allows you to create and replicate your systems at low cost and avoid the expense of manual effort. You can track changes to your automation, audit the impact, and revert to previous parameters when necessary
- Allow for evolutionary architectures
  - In the cloud, the capability to automate and test on demand lowers the risk of impact from design changes. This allows systems to evolve over time so that businesses can take advantage of innovations as a standard practice
- Drive architectures using data
  - In the cloud you can collect data on how your achitectural choices affect the behavior of your workload. This data lets you make fact-based decisions on how to improve your workload. Since your cloud infrastructure is code, you can use that data to inform your architecture choices and improvements over time
- Improve thrugh game days
  - Test how your architecture and processes perform by regularly scheduling game days to simulate events in production. (game days are days with full and varying demand?)



----
Things to further research
- TOGAF
- Zachman Framework
  