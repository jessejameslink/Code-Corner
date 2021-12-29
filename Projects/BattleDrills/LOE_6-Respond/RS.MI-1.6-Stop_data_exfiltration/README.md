## Task

RS.MI-1.6: Stop data exfiltration
## Conditions

1) Given a network with sensitive data
2) Harden host nodes against data exfiltration
## Standards

1. Disable USB ports a. In the Windows environment, there are two places to prevent the use of USB ports b. Disable the installation of USB storage devices on the computer i. Start Windows Explorer, and then locate the %SystemRoot%\Inf folder. ii. Right-click the Usbstor.pnf file, and then click Properties. iii. Click the Security tab. iv. In the Group or user names list, add the user or group that you want to set Deny permissions for. v. In the Permissions for UserName or GroupName list, click to select the Deny check box next to Full Control. Note * Also add the System account to the Deny list. vi. In the Group or user names list, select the SYSTEM account. vii. In the Permissions for UserName or GroupName list, click to select the Deny check box next to Full Control, and then click OK. viii. Right-click the Usbstor.inf file, and then click Properties. ix. Click the Security tab. x. In the Group or user names list, add the user or group that you want to set Deny permissions for. xi. In the Permissions for UserName or GroupName list, click to select the Deny check box next to Full Control. xii. In the Group or user names list, select the SYSTEM account. xiii. In the Permissions for UserName or GroupName list, click to select the Deny check box next to Full Control, and then click OK. c. Disable the use of USB devices through the registry i. Click Start, and then click Run. ii. In the Open box, type regedit, and then click OK. iii. Locate and then click the following registry key: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsbStor iv. In the details pane, double-click Start. v. In the Value data box, type 4, click Hexadecimal (if it is not already selected), and then click OK. vi. Exit Registry Editor. 2. Disable CD/DVD drive burning a. In the Windows environment, there are two places to prevent the use of CD/DVD devices for burning b. Implement a Group Policy i. Open the “all users”, “specific users or groups”, or “all users except administrators” Local Group Policy Editor for how you want this policy applied.

ii. In the left pane navigate through the tree to: User Configuration > Administrative Templates > Windows Components > Windows Explorer (Windows 7) or File Explorer (Windows 8 and newer) iii. In the right pane, double click/tap on Remove CD Burning features to edit it iv. Select the dot to enable this feature v. Click OK vi. Close the Local Group Policy Editor c. Disable through Registry i. Open Regedit ii. Navigate to HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer iii. Modify/create the dword “NoCDBurning” and set it to 00000001 iv. Exit Regedit 3. Employee training a. Develop a training that covers the following i. How to identify sensitive material ii. Define the risk of releasing sensitive material iii. Describe known sensitive material b. Distribute the training material

## End State

The host nodes on the network cannot burn information to CD/DVD drives nor can they utilize thumb drives.
## Notes

The methods described in this document help prevent data exfiltration on a host machine by a user. There are other methods that are network-centric but turns complicated quickly. Some considerations for a network-centric implementation include: FTP ports, SFTP ports, SCP ports, Email attachments, access to cloud storage, etc… This can become quite the rabbit hole and requires deep understanding and strong requirements gathering before implementation.
## Manual Steps


## Running Script


## Dependencies


## Other available tools


## References

https://support.microsoft.com/en-us/help/823732/how-can-i-prevent-users-from-connecting-to-a-usb-storage-device
https://www.sevenforums.com/tutorials/5942-burning-cd-dvd-enable-disable.html
## Revision History

Verion 1.0 BPC, 31 APR 2017