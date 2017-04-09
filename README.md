# cloud-account-setup

Contains code to setup an AWS account for automation.

## Prequesite

Prior to running the code in this repository, some bootstrapping of an AWS
account is required.  The bootstrapping consists of the following tasks:

* Creating an IAM User that can be used by the automation
* Creating an Access Key for the above IAM User

For detailed instructions on creating the IAM User, refer the [AWS IAM
documentation](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console).
For the type of access, select **Programmatic access**.

For the permissions of the IAM User, select **Attach existing policies to user
directly**, and select the **AdministratorAccess** policy.
