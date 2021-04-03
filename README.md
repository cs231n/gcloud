# Google Cloud Setup and Tutorial

(Last Update on April 3, 2021)


# Table of contents

1. [Overview](#overview)
2. [Create and Configure Your Account](#create-and-configure-your-account)
    1. [Sign Up GCP for the First Time](#sign-up-gcp-for-the-first-time)
    2. [Configure Your Project](#configure-your-project)
3. [Claim CS231N GCP credits](#claim-cs231n-gcp-credits)
4. [Request an Increase in GPU Quota](#request-an-increase-in-gpu-quota)  
    1. [Why don't I See Any GPU-related Quota](#why-dont-i-see-any-gpu-related-quota)
5. [Set Up Google Cloud VM Image](#set-up-google-cloud-vm-image)
    1. [Customize VM Hardware](#customize-vm-hardware)
    2. [Configure Networking](#configure-networking)
6. [Access Your Newly created VM](#access-your-newly-created-vm)
    1. [Install gcloud command-line Tools](#install-gcloud-command-line-tools)
    2. [Verification](#verification)
7. [Remote Server Development](#remote-server-development)
    1. [Using Jupyter Notebook with Google Compute Engine](#using-jupyter-notebook-with-google-compute-engine)
    2. [Transferring Files From Your Instance To Your Computer](#transferring-files-from-your-instance-to-your-computer)
    3. [Other Tips](#other-tips)
    

## Overview 

For your class project, we recommend setting up a GPU instance on GCP (Google Cloud Platform).

### BIG REMINDER: Make sure you stop your instances! 

(We know you won't read until the very bottom once your assignment is running, so we are printing this at the top too since it is ***super important***)

Don't forget to ***stop your instance*** when you are done (by clicking on the stop button at the top of the page showing your instances), otherwise you will ***run out of credits*** and that will be very sad. :(

If you follow our instructions below correctly, you should be able to restart your instance and the downloaded software will still be available.

### Colab vs GCP 

While [Colab](https://research.google.com/colaboratory/faq.html) is good for assignments, and  is still a helpful and free tool for experimentation for your project, you will likely need a dedicated GPU instance when you start training on large datasets and collaborating as a team:
- Colab will disconnect after 12 hours or ~30 min of idling (and you will lose your unsaved data). A GCP VM instance will not disconnect untill you stop it (or run out of credits).  
- A GCP VM instance's disk space allows you to deal with larger datasets. In Colab's case, you will have to save all your data and models to Google Drive.
- Colab does not innately support real-time collaboration.
- You can choose your GPU models and can set >1 GPUs for distributed training on GCP.

## Create and Configure Your Account

**You should use your personal GMail account for GCP, i.e. NOT SUID@stanford.edu, because Stanford University managed email accounts do not support creating a new project.** 

For the class project, we offer students **$50 GCP coupons** for each student to use Google Compute Engine for developing and testing your
implementations. When you first sign up on GCP, you will have $300 free credits.

If your credits ends up not being enough, contact course staff on Piazza. We will also send out forms for extra GCP credit request form later in the quarter.
 
This tutorial lists the necessary steps of working on the projects using Google Cloud. **We expect this tutorial to take up to an hour. Don't get intimidated by the steps, we tried to make the tutorial detailed so that you are less likely to get stuck on a particular step. Please tag all questions related to Google Cloud with google_cloud on Piazza.**

### Sign Up GCP for the First Time

You should receive $300 credits from Google when you first sign up with **Personal GMail** and **also UPGRADE it into a full account**. 
Please try to use the resources judiciously. 

1. Create Google Cloud account by going to the [Google Cloud homepage](https://cloud.google.com/?utm_source=google&utm_medium=cpc&utm_campaign=2015-q2-cloud-na-gcp-skws-freetrial-en&gclid=CP2e4PPpiNMCFU9bfgodGHsA1A "Title"). Click on the blue **Get Started for free** button. Sign into your Gmail account. Here is an illustrative example.
![](.img/launching-screen.png)

2. Choose **Account type** to be **Individual**. You will then fill in your name, address and credit card information.
![](.img/register-info.png)

3. Click the "Google Cloud Platform" (in red circle), and it will take you to the main project dashboard:
![](.img/welcome-screen.png)

### Configure Your Project 

1. On the main project dashboard, you can change the name of your project by clicking **Go to project settings**. 
![](.img/dashboard-screen.png)

2. To add project collaborators, click **ADD PEOPLE TO THIS PROJECT**. Add their email and make their role owners. 
![](/.img/add-people.png)

3. **Upgrade your account** in order to use GPUs following this [instruction](https://cloud.google.com/free/docs/gcp-free-tier#how-to-upgrade). Otherwise [Google Cloud Free Tier](https://cloud.google.com/free/docs/gcp-free-tier#how-to-upgrade) does not come with GPU support or quota.
![](/.img/upgrade-1.png)
![](/.img/upgrade-2.png)

## Claim CS231N GCP credits 

NOTE: You should have created and logged in your GCP account registered with your personal gmail account by now. 

1. We will release the $50 GCP credits Google form on Piazza. After your complete the form, you will see a link to Google Cloud Education Grants page. **It requires your Stanford email to receive the credits**. (These credits can be **applied to your GCP account registered with Personal GMail**. )
![](/.img/get-coupon.png)

2. After submission, you should receive a email from GCP with a link to confirm your email address. Click the link to verify your Stanford email.
![](/.img/email-confirmation.png)

3. You will soon receive another email from GCP with a link that applys the $50 credits to your account. After that the website will jump to your [Billing](https://console.cloud.google.com/billing) page where you should see your have linked to CS231N billing account with $50 free credits. 
![](/.img/accept-credits.png)
![](/.img/billing-page.png)

4. Switching billing accounts from Free Tier credits to CS231N credits
Google Cloud does not support combining credits. You will need to switch billing account if you want to use 2 sources of gcloud credits. 

i.e. You can use up the $300 free credits first. Then switch to the CS231N billing account referring to this [GCloud documentation](https://cloud.google.com/billing/docs/how-to/modify-project#change_the_billing_account_for_a_project).

## Request an Increase in GPU Quota

Your account typically does not come with GPU quota. You have to explicitly request for it under **IAM Admin** > **Quotas**. 

**Please request the quota increase ASAP**, because they will take up between couple minutes to a week to process!  If you don't have GPU quota, you will have to create a CPU-only VM first and create another GPU VM later, explained in the next section.

You will need to change your quota for **GPU (all regions)**.

1. Select **Limit name** from the dropdown. Then select **GPUs (all regions)** from the next prompted dropdown. Click the checkbox for **Global** in the menu to the right, and click into **ALL QUOTAS**.
![](.img/gpu-all-regions-1.png)


2. Select the checkbox to the left of the first item in the table, and click **EDIT QUOTAS**. Set the **New limit** to 1, and make the **Request description** "Stanford CS 231N class project".
![](.img/gpu-all-regions-2.png)

3. Wait until GCP sends you a second email (first email is just to notify they receive the request) that looks like this. It could take couple minutes to couple days for them to approve.
![](.img/gpu-quota-approved.png) 

### Why don't I See Any GPU-related Quota

1. First, make sure you upgrade your free tier account to a full account following these [instructions](https://cloud.google.com/free/docs/gcp-free-tier#how-to-upgrade).

2. If you just registered a Google Cloud account, GCP can be slow on setting up its Compute Engine API services (this is the service that provides GPU access, so the GPU quota won't show up before it is ready). 

One way I found that can make Compute Engine API setup faster is by visiting the [VM instance page](https://console.cloud.google.com/compute/) by clicking  **Compute Engine** > **VM instances**

If you see that Compute Engine is not ready yet, wait for couple minutes until you see something like this screenshot below. The GPU-related Quota should now show up in  **IAM Admin** > **Quotas**. 
![](.img/vm-instance-ready.png)

3. For region-specific GPUs: Check that you have a default zone and region set under **Compute Engine** > **Settings** > **Region** / **Zone**. Some zones do not have certain GPU resources. Check [pricing and spec for GCP GPUs](https://cloud.google.com/compute/gpus-pricing) to find the availability of GPU resources. 


More instructions at [General quota instructions](https://cloud.google.com/compute/quotas#requesting_additional_quota) and [Step-by-step GPU-specific walk-through](https://stackoverflow.com/questions/45227064/how-to-request-gpu-quota-increase-in-google-cloud) (all answers in the link are useful)


## Set Up Google Cloud VM Image

### Customize VM Hardware 

1. Go to [this gcloud marketplace](https://console.cloud.google.com/marketplace/config/click-to-deploy-images/tensorflow). You may (or may not) be taken to a page where you have to click on "Launch", and then you should see a configuration sheet with the title "New Deep Learning VM deployment".
2. Fill in `Deployment name` field with your preferred VM name.
3. In `Machine type` box, click `Customize`.
4. Choose your desired number of CPUs and memory (if you are unsure, keep the default). 
5. For `GPU type`, `NVIDIA Tesla K80` is typically enough. `P100` and `V100` are way more expensive (check the price on the right), but also faster and has larger memory. Check [pricing and spec for GCP GPUs](https://cloud.google.com/compute/gpus-pricing). 
    **GPU drivers and CUDA will be automatically installed _only if_ you select at least 1 GPU**.
6. In `Frameworks` field, choose the most recent version of TensorFlow or PyTorch, depending on which framework you plan to use.
7. Check the box `Install NVIDIA GPU driver automatically on first startup?`.
8. Check the box `Enable access to JupyterLab via URL instead of SSH. (Beta)`.
9. Leave all other options as default.
10. Click the blue botton `Deploy` at the end of the page. It will **automatically start your instance**, so if you don't need to use it now, **stop it immediately**.


Your configuration sheet should look similar to below image. Follow exactly the same configuration for the ones with red boxes. For configurations with orange boxes, you can adjust it based on your project need as discussed below. 

Pay attention to the monthly price, make sure you claim only necessary HW resources, so that you can use your GCP instance for longer. 
**Once you run out of credits, the VM instance will be shut down automatically and you might lose unsaved data and models.** If you are almost running out of credits, contact the course staff.
![](.img/vm-config.png)

#### Change Configuration on Already Created VM Instances
1. You can always change number of CPUs, number of GPUs, CPU memory, and GPU type **after your VM has been created**. 

2. Just stop your instance, go to your VM instance's details at **Compute Engine** > **VM instances** > [click on instance name]. 

3. Click "edit" on your VM's page to modify the settings. Finally click "Save".

### Configure Networking

Wait until the deployment is finished. You should see a running VM with a green checkmark next to it on your [Compute Engine page](https://console.cloud.google.com/compute/).

We need to tweak a few more settings to enable remote access to Jupyter Notebook.

1. You must stop the instance first.
2. Go to your VM instance's details at **Compute Engine** > **VM instances** > [click on instance name]. Click "edit" on your VM's page.
3. Select "Allow HTTP traffic" and "Allow HTTPS traffic".
4. Scroll all the way down and click the blue button "save".
5. Go to [Firewall config page](https://console.cloud.google.com/networking/firewalls).
6. Click "CREATE FIREWALL RULE"
7. Give it an arbitrary name, such as `cs231n`.
8. In `Targets` field, select `All instances in the network`.
9. In `Source IP ranges`, enter `0.0.0.0/0`.
10. In `Protocols and ports` field, select "Specified protocols and ports". Then check `tcp` and enter `7000-9000`.
11. Click the blue button `Create`.
12. Restart your instance on the Compute Engine page.

Your configuration sheets should look similar to below:

<img src=".img/network.png" width="70%">

Firewall Rules:

<img src=".img/firewall.png" width="70%">


#### Getting a Static IP Address
If you want to have a static IP for ease of access, you can change the External IP address of your Google Cloud Engine instance to be static (see screenshot below).

![](.img/external-ip.png)

To Do this, click on the 3 line icon next to the **Google Cloud Platform** button on the top left corner of your screen, go to **VPC network** > **External IP addresses** (see screenshot below).

![](.img/networking-external-ip.png)

To have a static IP address, change **Type** from **Ephemeral** to **Static**. Enter your prefered name for your static IP, ours is `cs231n-ip` (see screenshot below). And click on Reserve. 

**NOTE:** At the end of CS 231N when you don't need your instance anymore, **release the static IP address because Google charges a small fee for unused static IPs** (according to [this page](https://jeffdelaney.me/blog/running-jupyter-notebook-google-cloud-platform/)).

![](.img/networking-external-ip-naming.png)

Take note of your Static IP address (circled on the screenshot below). We use 35.185.240.182 for this tutorial.

![](.img/networking-external-ip-address.png)


## Access Your Newly Created VM 

Now that you have created your virtual GCE, you want to be able to connect to it from your computer. The rest of this tutorial goes over how to do that using the command line. 

### Install gcloud command-line Tools
To access [gcloud commands](https://cloud.google.com/sdk/gcloud/reference) in your local terminal, install [Google Cloud SDK](https://cloud.google.com/sdk/docs) that is appropriate for your platform and follow their instructions. 

If `gcloud` command is not in your system path after installation, you can also reference it by its full path `/<DIRECTORY-WHERE-GOOGLE-CLOUD-IS-INSTALLED>/bin/gcloud`. See [this page](https://cloud.google.com/compute/docs/instances/connecting-to-instance "Title") for more detailed instructions.

To ssh into your VM, go to your VM instance details page by clicking on its name. Start the VM instance first. Once it has a green check mark on, click on the drop-down arrow and select `View gcloud command` instead to retrieve the terminal command. It should look like

```bash
gcloud compute --project "<YOUR_PROJECT_ID>" ssh --zone "us-west1-b" "<YOUR_VM_NAME>"
```

![](.img/connect-to-vm.png)


### Verification

If you have GPU enabled, you should be able to:

* run `nvidia-smi` and see the list of attached GPUs and their usage statistics. Run `watch nvidia-smi` to monitor your GPU usage in real time.
* inside the `gcloud/` folder, run `python verify_gpu.py`. If your GPU is attached and CUDA is correctly installed, you shouldn't see any error.
* If you want to use TensorFlow, run `python test_tf.py`. The script will show you the installed TensorFlow version and then run a sample MNIST training. You should see around 97% accuracy at the end.  


## Remote Server Development

### Using Jupyter Notebook with Google Compute Engine 
If you wish, you can use Jupyter Notebook to experiment in your projects. Below, we discuss how to run Jupyter Notebook from your GCE instance and connect to it with your local browser.

After you SSH into the VM for the first time, you need to run a few commands in your home directory. You will be asked to set up a password for your Jupyter Notebook.
```bash
git clone https://github.com/cs231n/gcloud.git
cd gcloud/
chmod +x ./setup.sh
./setup.sh
```

Now you can run Jupyter Notebook from the folder with your assignment files.

```
jupyter notebook
```

The default port is `8888`, specified in `~/.jupyter/jupyter_notebook_config.py`.

You can connect to your Jupyter session from your personal laptop. Check the external ip address of your instance, say it is `35.185.240.182`. Open any browser and visit `35.185.240.182:8888`. The login password is the one you set with the setup script above.


### Transferring Files From Your Instance To Your Computer

For instance, to transfer `file.zip` from GCE instance to your local laptop. There is an [easy command](https://cloud.google.com/sdk/gcloud/reference/compute/scp) for this purpose:

```
gcloud compute scp <user>@<instance-name>:/path/to/file.zip /local/path
```

For example, to download files from our instance to the current folder:

```
gcloud compute scp tonystark@cs231n:/home/shared/file.zip .
```

The transfer works in both directions. To upload a file to your instance:

```
gcloud compute scp /my/local/file tonystark@cs231n:/home/shared/
```

If you would like to transfer an entire folder, you will need to add a resursive flag: 
```
gcloud compute scp --recursive /my/local/folder tonystark@cs231n:/home/shared/
```

### Other Tips
You can use [Tmux](https://linuxize.com/post/getting-started-with-tmux/) to keep the training sessions running when you close your laptop. Also, if your collaborators log into the same account on the VM instance, they will see the same tmux session screen in real time. 

You can develop your code on remote server directly if you are comfortable with vim or emac.

You can develop locally on your favorite editor, push to your branch on Github, and pull on remote server to run.
(git commit frequently is also one of [good Github practices](https://www.datree.io/resources/github-best-practices))

Besides `gcloud compute scp`, another tool you can check out is [rsync](https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization/) which can synchronize files and folders between your local machine and remote server. 


## BIG REMINDER: Make sure you stop your instances! ##

Don't forget to stop your instance when you are done (by clicking on the stop button at the top of the page showing your instances). You can restart your instance and the downloaded software will still be available.

We have seen students who left their instances running for many days and ran out of credits. You will be charged per hour when your instance is running. This includes code development time. We encourage you to read up on Google Cloud, regularly keep track of your credits and not solely rely on our tutorials.
