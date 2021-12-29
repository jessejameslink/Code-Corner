#Setup SSH


https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent

Open Terminal.
Paste the text below, substituting in your GitHub email address.
>$ ssh-keygen -t ed25519 -C "your_email@example.com"

This creates a new ssh key, using the provided email as a label.
> Generating public/private ed25519 key pair.
When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.
> Enter a file in which to save the key (/Users/you/.ssh/id_ed25519): [Press enter]
At the prompt, type a secure passphrase. For more information, see "Working with SSH key passphrases".
> Enter passphrase (empty for no passphrase): [Type a passphrase]
> Enter same passphrase again: [Type passphrase again]

### Adding your SSH Key to the SSH-Agent

Start the ssh-agent in the background.
>$ eval "$(ssh-agent -s)"
> Agent pid 59566

If you're using macOS Sierra 10.12.2 or later, you will need to modify your ~/.ssh/config file to automatically load keys into the ssh-agent and store passphrases in your keychain.
First, check to see if your ~/.ssh/config file exists in the default location.

>$ open ~/.ssh/config

> The file /Users/you/.ssh/config does not exist.
If the file doesn't exist, create the file.

>$ touch ~/.ssh/config

Open your ~/.ssh/config file, then modify the file, replacing ~/.ssh/id_ed25519 if you are not using the default location and name for your id_ed25519 key.

>Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519

Note: If you chose not to add a passphrase to your key, you should omit the UseKeychain line.
Add your SSH private key to the ssh-agent and store your passphrase in the keychain. If you created your key with a different name, or if you are adding an existing key that has a different name, replace id_ed25519 in the command with the name of your private key file.

>$ ssh-add -K ~/.ssh/id_ed25519

### Test Connection to Repo
>$ ssh -T git@github.com
># Attempts to ssh to GitHub
