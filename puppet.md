## PUPPET 
---

Puppet Master controls hosts via the Puppet Agent

Puppet agent begins a Puppet run by sending a *catalog request* to the Puppet Master.
- catalog request contains info abou the agent system via *Facter*

Puppet Master then uses the *catalog request* info along with Puppet code to compule a catalog that tells the agent exactly how the system should be configured.

Puppet Master keeps a copy of the Puppet codebase which is made up of resource declarations and other features. Master then parses this codebase to create a catalog which is the final list of system resources that define the desired state for an agent node.

Puppet Master then sends the catalog back to the Puppet Agent. Agent then uses its providers check if 

Communication between Puppter Master and Agents happen over SSL. Any agent that is contacting the Puppet Master must authenticate with a signed certifcate. On the first Puppet Agent run (first contact with Master), the agent submits a certificate signing request (CSR).

Trigger a Puppet run on an agent system:   

    puppet agent -t

- first run this will trigger the CSR

```
Info: Creating a new SSL key for agent.puppet.vm
Info: Downloaded certificate for ca from learning.puppetlabs.vm
Info: csr_attributes file loading from /etc/puppetlabs/puppet/csr_attributes.yaml
Info: Creating a new SSL certificate request for agent.puppet.vm
Info: Certificate Request fingerprint (SHA256): 16:6A:EC:E6:8F:C9:4D:59:09:F7:35:25:44:33:46:FA:90:C9:01:B2:94:27:54:7C:80:6A:9E:92:69:F9:86:F3
Exiting; no certificate found and waitforcert is disabled
[~]
```

Sign the cert on the Puppet Master:

    puppetserver ca list

    puppetserver ca sign --certname agent.puppet.vm

Trigger a run again to download and apply the catalog from the Puppet Master

