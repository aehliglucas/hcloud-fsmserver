## hcloud FSMServer
### About
This small collection of Terraform and Ansible artifacts is developed to provide an easy way of setting up FlightStripManager-Server instances in Hetzner Cloud for virtual air traffic controlling.
The FlightStripManager client can be found [here](https://hawk-softworks.de/fsm).

Please note that I am not associated to Hawk Softworks, the developers of FlightStripManager, in any way.
My only goal was to have an easy-to-deploy and easy-to-destroy solution for managing traffic in a synchronized and realistic way on IVAO or VATSIM.

### Installation & Usage
Installing the deployment files for FSMServer is pretty straight forward.

#### Step 1: Packages and Prerequisites
In order to run the deployment, you will need a working installation of Python (>= version 3.10), as well as Ansible (>= version 2.15) and Terraform (>= version 1.9).

To install all of them at once under Debian, you can run the following two commands:
```bash
sudo apt update && sudo apt install python3.10 terraform -y
sudo python3.10 -m pip install ansible
```


#### Step 2: Configuration
This project makes use of a dotenv file for configuration.
In order to set it up, clone the GitHub repository and rename the ".env-example" file to ".env".

The .env file contains a few values, which are briefly explained in the following table:
| Variable Name  | Usage  |
| :------------ | :------------ |
| FSMS_INSTANCES  | The number of FSMServer instances that should be created. The deployment will be scaled automatically based on this value. If the number of instances is 3 or lower, Terraform will create a CX22 vServer with 2 vCPUs and 4GB of RAM. If it is higher than 3, it will create a CX32 vServer with 4 vCPUs and 8GB of RAM. |
| HCLOUD_TOKEN  | Hetzner Cloud API token to be used for the deployment. It can be created from within your Hetzner Cloud Project. The process is described [here](https://docs.hetzner.com/cloud/api/getting-started/generating-api-token/).  |
| HCLOUD_DATACENTER | The desired datacenter where the vServer should be created in. Possible values are: nbg1-dc3 for Nuremberg, fsn1-dc14 for Falkenstein, hel1-dc2 for Helsinki, ash-dc1 for Ashburn and hil-dc1 for Hillsboro |
| SSH_KEYS_TO_INJECT  | Names or IDs of SSH keys that should be rolled out to the server. As soon as the key pair is generated, add the public key to your Hetzner Cloud Project and give it a name. Remember the path of the corresponding private key file for later and add the name you assigned to your public key to this list. |
| FSMS_PORT  | Start of the port range that should be used for FSMServer. Increments by 1 with each instance, if the instance number is higher than 1. The default port for FSMServer is 13000.  |
| ANSIBLE_SSH_KEY  | The path to the private key file that should be used by Ansible to connect to the server. Please beware that the corresponding public key is added to the Hetzner Cloud Project and exists in the SSH_KEYS_TO_INJECT list.  |


#### Step 3: Running the deployment
Once you have finished configuring the deployment, you can run it by simply executing the apply.sh script. If you want to destory the deployment again, you can use the destroy.sh script.
