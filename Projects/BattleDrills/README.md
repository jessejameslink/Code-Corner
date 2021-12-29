- [How To Contribute](#how-to-contribute)
- [Concept](#concept)
- [Battle Drills](#battle-drills)
- [Script Style Guide](#script-style-guide)
  * [1. Bash](#1-bash)
  * [2. Powershell](#2-powershell)
  * [3. Python](#3-python)
- [Git Workflow](#git-workflow)
    + [1. clone the repo](#1-clone-the-repo)
    + [2. create a local branch](#2-create-a-local-branch)
    + [3. complete battle drill documenations.](#3-complete-battle-drill-documenations)
    + [4. add your changes](#4-add-your-changes)
    + [5. commit your changes.](#5-commit-your-changes)
    + [6. push your local branch to remote.](#6-push-your-local-branch-to-remote)
    + [7. create a pull request](#7-create-a-pull-request)

# How To Contribute
- Pick an issue that has a label. i.e. `5-Points`. Each issue needs to be reviewed then pointed. If issues are not labelled with `x-points`, it's not ready for contribution earning.
- Review the endstate requirements for resolving the issue
- Make required changes to clear the requirements. Follow the Git Workflow of this README file.
- Create a pull request.
- Get the pull request approved.
- Then, you've earn the points for the issue.

## Point Equivalency
Each point represents an hour of work.
For example, an issue with 5 points is estimated to be 5 hours worth of work to complete.

## Point-RMP Conversion
- Every 5 point is equal to 1 RMP.
- RMPs are paid in 5 points increment.
- Pay will be processed at least once a week.

# Concept 	
![Battle Drill Concept](https://github.com/cybersurfers/Battle-Drills/blob/master/battle-drill-concept.png)

# Battle Drills
- [ID.TO-3.3: IDENTIFY_TO_3_3_Active_Host_and_Service_Enumeration](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-3.3-IDENTIFY_TO_3_3_Active_Host_and_Service_Enumeration)
- [ID.TO-3.4: IDENTIFY_TO_3_4_Create_Active_IP_List](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-3.4-IDENTIFY_TO_3_4_Create_Active_IP_List)
- [ID.TO-3.5: IDENTIFY_TO_3_5_Active_IP_List_on_Key_Ports](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-3.5-IDENTIFY_TO_3_5_Active_IP_List_on_Key_Ports)
- [ID.TO-3.6: IDENTIFY_TO_3_6_Scan_ICS_Equipment_Ports](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-3.6-IDENTIFY_TO_3_6_Scan_ICS_Equipment_Ports)
- [ID.TO-3.7: IDENTIFY_TO_3_7_All_Port_Scan](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-3.7-IDENTIFY_TO_3_7_All_Port_Scan)
- [ID.TO-3.9: IDENTIFY_TO_3_9_List_all_AD_Domain_Accounts](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-3.9-IDENTIFY_TO_3_9_List_all_AD_Domain_Accounts)
- [ID.TO-3.11: IDENTIFY_TO_3_11_Create_firewall_rule_list](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-3.11-IDENTIFY_TO_3_11_Create_firewall_rule_list)
- [ID.TO-4.2: IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors)
- [ID.TO-4.3: IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS)
- [ID.GV-3.1: IDENTIFY_GV_3_1_Establish_network_access_accounts](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.GV-3.1-IDENTIFY_GV_3_1_Establish_network_access_accounts)
- [ID.GV-3.2: IDENTIFY_GV_3_2_Establish_Mission_log](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.GV-3.2-IDENTIFY_GV_3_2_Establish_Mission_log)
- [ID.AM-1.1: IDENTIFY_AM_1_1_Perform_Vulnerability_scan_of_network](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-1.1-IDENTIFY_AM_1_1_Perform_Vulnerability_scan_of_network)
- [ID.AM-1.2: IDENTIFY_AM_1_2_DNS_Host_Name_Mapping](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-1.2-IDENTIFY_AM_1_2_DNS_Host_Name_Mapping)
- [ID.AM-2.1: IDENTIFY_AM_2_1_Review_Organizational_User_Policies](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-2.1-IDENTIFY_AM_2_1_Review_Organizational_User_Policies)
- [ID.AM-2.2: IDENTIFY_AM_2_2_Gather_AD_Structure_Information](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-2.2-IDENTIFY_AM_2_2_Gather_AD_Structure_Information)
- [ID.AM-2.3: IDENTIFY_AM_2_3_Scan_Device_For_Default_Admin_Password](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-2.3-IDENTIFY_AM_2_3_Scan_Device_For_Default_Admin_Password)
- [ID.AM-3.1: IDENTIFY_AM_3_1_Determine_Installed_Software](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-3.1-IDENTIFY_AM_3_1_Determine_Installed_Software)
- [ID.AM-4.1: IDENTIFY_AM_4_1_Perform_STIG_Scan](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-4.1-IDENTIFY_AM_4_1_Perform_STIG_Scan)
- [ID.AM-4.2: IDENTIFY_AM_4_2_Perform_Patch_Compliance_Scan](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-4.2-IDENTIFY_AM_4_2_Perform_Patch_Compliance_Scan)
- [ID.AM-4.3: IDENTIFY_AM_4_3_Perform_SCAP_Configuration_Scan](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-4.3-IDENTIFY_AM_4_3_Perform_SCAP_Configuration_Scan)
- [ID.AM-4.6: IDENTIFY_AM_4_6_AD_Configuration_Scan_with_Powershell](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.AM-4.6-IDENTIFY_AM_4_6_AD_Configuration_Scan_with_Powershell)
- [ID.RA-1.1: IDENTIFY_RA_1_1_Conduct_Vulnerability_Scan_of_Network_Hosts](https://github.com/cybersurfers/Battle-Drills/tree/master/LOE_3-Identify/ID.RA-1.1-IDENTIFY_RA_1_1_Conduct_Vulnerability_Scan_of_Network_Hosts)

# References

Battle Drills are based on the NIST Framework for Improving Critical Infrastructure Cybersecurity.

https://nvlpubs.nist.gov/nistpubs/CSWP/NIST.CSWP.04162018.pdf

# Script Style Guide
Name the script the following way.
```bash
# {Battle Drill ID}-WhatScriptDoes.(sh/ps1)
ID.AM-2.2-GatherADStructureInformation.ps1
```

## 1. Bash
Use Camel Case for Variable and Function Names:

```bash
# variable: varCaseFirstLetterofEachWord
# function: funcCaseFirstLetterofEachWord

myVariable="My Variable"

function myFunction {
  # do something...
}
```

## 2. Powershell
Use Pascal Case for Variable. Function Names should be Verb-Action combination:
```powershell
# variable: VarCaseFirstLetterofEachWord
# function: FuncCaseFirstLetterofEachWord

$MyVariable = "My Variable"

function MyFunction {
  # do something...
}
```

## 3. Python
Follow PEP 8 Guide Line: https://www.python.org/dev/peps/pep-0008/

# Git Workflow
### 1. clone the repo

Once your account has MFA enforced you will need to use an API key.  Make sure you store your API key in a safe place, I would suggest your password manager.
[Generate API Key](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line)


```bash
# copy url of this git repo and replace APIKEY with yours generated above
$ git clone https://APIKEY@github.com/cybersurfers/Battle-Drills.git
```

once you clone, at this point, you should only have local copy of `master` branch.
you can check all local branches using

```bash
$ git branch
(output should look)
* master
```

### 2. create a local branch
create a local branch with name that is related to changes that are being made.
```bash
$ git checkout -b $YOUR_LOCAL_BRANCH_NAME

# if you're working on battle drill ID.TO.3.3, you can do something like.

$ git checkout -b id-to-3-3
```

You can check all local branches again.
```bash
$ git branch
(output should look)
  master
* id-to-3-3
```

you can also jump back and forth different branch using
```bash
$ git checkout $(branch_name)
```

This allows avoiding making changes directly on master which is usually the official branch
where we only want to keep changes that are validated and reviewed.

### 3. complete battle drill documenations.
- complete README.md: you can get the template and the example from ./template
- add any scripts if you have one under $(your_battle_drill_folder)/scripts
- make sure to include detailed steps for running the script.

### 4. add your changes
any changes to an existing files or a new file will show with red text when you run
```bash
$ git status
```

before commiting, files you want to commit need to be added.
```bash
# adding everything: this has to run at the top level folder that contains any changes that are made.
$ git add .

# or add one at a time: if you want to commit some but leave others.
$ git add $(file_name)
```

if you run the `git status` again, added files should show up green in color.

### 5. commit your changes.
committing will open whatever editor that is set as `core.editor` under
```bash
$ git config --list
```

this is so that you can write a commit message. make sure that
you're comfortable with editor the git is about to open.

once you've confirmed that all files that need to be committed are added,
commit the changes.

```bash
$ git commit
```

make sure to write a meaningful commit message that gives context to what changes are made.
the first line becomes the header,
and add a space and write the body.

for adding directories for JUN2020IDT, message would look something like:
```bash
Adding directories for battle drill tasks JUN2020 IDT

Directories include:
ID.AM-2.1: IDENTIFY_AM_2_1_Review_Organizational_User_Policies
ID.AM-2.2: IDENTIFY_AM_2_2_Gather_AD_Structure_Information
ID.AM-2.3: IDENTIFY_AM_2_3_Scan_Device_For_Default_Admin_Password
ID.AM-4.1: IDENTIFY_AM_4_1_Perform_STIG_Scan
ID.AM-4.2: IDENTIFY_AM_4_2_Perform_Patch_Compliance_Scan
ID.AM-4.3: IDENTIFY_AM_4_3_Perform_SCAP_Configuration_Scan
ID.AM-4.6: IDENTIFY_AM_4_6_AD_Configuration_Scan_with_Powershell
ID.RA-1.1: IDENTIFY_RA_1_1_Conduct_Vulnerability_Scan_of_Network_Hosts
ID.TO-3.9: IDENTIFY_TO_3_9_List_all_AD_Domain_Accounts
ID.TO-3.3: IDENTIFY_TO_3_3_Active_Host_and_Service_Enumeration
ID.TO-3.4: IDENTIFY_TO_3_4_Create_Active_IP_List
ID.TO-3.5: IDENTIFY_TO_3_5_Active_IP_List_on_Key_Ports
ID.TO-3.7: IDENTIFY_TO_3_7_All_Port_Scan
ID.GV-3.1: IDENTIFY_GV_3_1_Establish_network_access_accounts
ID.AM-1.2: IDENTIFY_AM_1_2_DNS_Host_Name_Mapping
ID.AM-3.1: IDENTIFY_AM_3_1_Determine_Installed_Software
ID.GV-3.2: IDENTIFY_GV_3_2_Establish_Mission_log
ID.AM-1.1: IDENTIFY_AM_1_1_Perform_Vulnerability_scan_of_network
ID.TO-3.11: IDENTIFY_TO_3_11_Create_firewall_rule_list
ID.TO-3.6: IDENTIFY_TO_3_6_Scan_ICS_Equipment_Ports
ID.TO-4.2: IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors
ID.TO-4.3: IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
```

When you save and exit our of the editor, commit is complete.

### 6. push your local branch to remote.
the branch you've created in step 2 is only available locally.
remote is the central version of repo where everybody can access.
in order to make the branch available at remote, the branch needs to be pushed.

run this while you are at your branch:
this means when `git branch` has `*` next to the branch you want to push.
```bash
$ git push
```

When you push the local branch for the first time,
`git` will complain because the remote branch does not exist yet for the local branch.
in git, the paired remote branch of the local branch is called the upstream.

```
fatal: The current branch id-to-3-3 has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin id-to-3-3
```

Run the command the git suggests.
```bash
$ git push --set-upstream origin id-to-3-3
```

Setting the upstream is required only once for the very first time,
and if you need to push any other changes to your branch afterward,
you can simply do

```bash
$ git push
```
### 7. create a pull request
Now, the branch with your change is available remote.
when you go to git repo: https://github.com/cybersurfers/Battle-Drills,
you can create a pull request.

git should show a banner in the main repo as a short cut asking
if you want to make a pull request out of the recent push.

Or, you can click on `create a pull request` button.
choose `master` on the left, and `your branch` on the right.

k
