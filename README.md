# Google Cloud Setup and Tutorial


## BEFORE WE BEGIN ##
### BIG REMINDER: Make sure you stop your instances! ###

(We know you won't read until the very bottom once your assignment is running, so we are printing this at the top too since it is ***super important***)

Don't forget to ***stop your instance*** when you are done (by clicking on the stop button at the top of the page showing your instances), otherwise you will ***run out of credits*** and that will be very sad. :(

If you follow our instructions below correctly, you should be able to restart your instance and the downloaded software will still be available.

## Create and Configure Your Account ##

For the class project and assignments, we offer an option to use Google Compute Engine for developing and testing your
implementations. This tutorial lists the necessary steps of working on the assignments using Google Cloud. **We expect this tutorial to take about an hour. Don't get intimidated by the steps, we tried to make the tutorial detailed so that you are less likely to get stuck on a particular step. Please tag all questions related to Google Cloud with google_cloud on Piazza.**

This tutorial goes through how to set up your own Google Compute Engine (GCE) instance to work on the assignments. Each student will have $100 in credit throughout the quarter. When you sign up for the first time, you also receive $300 credits from Google by default. Please try to use the resources judiciously. But if $100 ends up not being enough, we will try to adjust this number as the quarter goes on.

First, if you don't have a Google Cloud account already, create one by going to the [Google Cloud homepage](https://cloud.google.com/?utm_source=google&utm_medium=cpc&utm_campaign=2015-q2-cloud-na-gcp-skws-freetrial-en&gclid=CP2e4PPpiNMCFU9bfgodGHsA1A "Title") and clicking on **Compute**. When you get to the next page, click on the blue **TRY IT FREE** button. If you are not logged into gmail, you will see a page that looks like the one below. Sign into your gmail account or create a new one if you do not already have an account.

![](.img/launching-screen.png)

Click the appropriate **yes** or **no** button for the first option, and check **yes** for the second option after you have read the required agreements. Press the blue **Agree and continue** button to continue to the next page to enter the requested information (your name, billing address and credit card information). Remember to select "**Individual**" as "Account Type":

![](.img/register-info.png)

Once you have entered the required information, press the blue **Start my free trial** button. You will be greeted by a page like this:

![](.img/welcome-screen.png)

Click the "Google Cloud Platform" (in red circle), and it will take you to the main dashboard:

![](.img/dashboard-screen.png)

To change the name of your project, click on [**Go to project settings**](console.cloud.google.com/iam-admin/settings/project) under the **Project info** section.

## Request an increase in GPU quota

Your account typically does not come with GPU quota. You have to explicitly request for it in the "IAM Admin" console. Follow the instructions:

* [General quota instructions](https://cloud.google.com/compute/quotas#requesting_additional_quota)

* [Step-by-step GPU-specific walk-through](https://stackoverflow.com/questions/45227064/how-to-request-gpu-quota-increase-in-google-cloud) (all answers in the link are useful)


**Please request the quota increase ASAP**, because they will take up to a week to process. If you don't have GPU quota, you will have to create a CPU-only VM first and create another GPU VM later, explained in the next section.


## Google Cloud VM Image

1. Go to [this gcloud marketplace](https://console.cloud.google.com/marketplace/config/click-to-deploy-images/tensorflow). You should see a configuration sheet with the title "New Deep Learning VM deployment".
2. Fill in `Deployment name` field with your preferred VM name.
3. In `Machine type` field, change `2 vCPUs` to `1 vCPU`. You can always add more CPUs later if necessary.
4. Change `Number of GPUs` to `None`. For our first assignment, you don't need GPUs. Since GPUs are very expensive, you can add them back when they become necessary later.
5. In `Frameworks` field, change `TensorFlow 1.13 (Intel optimized ...)` to `PyTorch 1.0 + fast.ai`. We will have instructions for you later if you want Tensorflow.
6. Check the box `Install NVIDIA GPU driver automatically on first startup?`.
7. Check the box `Enable access to JupyterLab via URL instead of SSH. (Beta)`.
8. Leave all other options as default.
9. Click the blue botton `Deploy` at the end of the page.

Your configuration sheet should look similar to below:

![](.img/vm-config.png)

### Configure networking

Wait until the deployment is finished. You should see a running VM with a green checkmark next to it on your [Compute Engine page](https://console.cloud.google.com/compute/).

We need to tweak a few more settings to enable remote access to Jupyter Notebook. You need to **stop the instance** first and then:

1. Click "edit" on your VM page.
2. Select "Allow HTTP traffic" and "Allow HTTPS traffic".
3. Scroll all the way down and click the blue button "save".
4. Go to [Firewall config page](https://console.cloud.google.com/networking/firewalls).
5. Click "CREATE FIREWALL RULE"
6. Give it an arbitrary name, such as `cs231n`.
7. In `Targets` field, select `All instances in the network`.
8. In `Source IP ranges`, enter `0.0.0.0/0`.
9. In `Protocols and ports` field, select "Specified protocols and ports". Then check `tcp` and enter `7000-9000`.
10. Click the blue button `Create`.
11. Restart your instance on the Compute Engine page.

Your configuration sheets should look similar to below:

![](.img/network.png)
![](.img/firewall.png)


### Access your newly created VM

Copy and paste the gcloud command from here. It should look like

```bash
gcloud compute --project "<YOUR_PROJECT_NAME>" ssh --zone "us-west1-b" "<YOUR_VM_NAME>"
```

![](.img/connect-to-vm.png)


## Run our setup script

Run the following commands in your home directory. You will be asked to set up a password for your Jupyter notebook.

```bash
git clone https://github.com/LinxiFan/gcloud-basic-setup.git
cd gcloud-basic-setup
chmod +x ./setup.sh
./setup.sh
```


