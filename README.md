# terraform_kitchen_ec2
Content of this repo is guideline on HOW to create an **ec2 instance** with **Terraform** and then to test it with **Kitchen**.

**Note that all this is tested on Ubuntu OS**

## Repo content
- `main.tf` - Terraform configuration file
- `.kitchen.yml` - Kitchen configuration file
- `Gemfile` -  Specify the the ruby version, and all gems needed for Kitchen test
- `test/integration/default/controls/operating_system_spec.rb` - ruby file which contain our kitchen test.
- `test/integration/default/inspec.yml` - contain the test system's name - `default`
- `<file>.env` - **ATTENTION! This file is not uploaded because contain sensitive information!** Contain AWS information needed to terraform in order to create the ec2 image. Please create your own file (the name, before extention, is not really matters) in the following format:
  ```
  export AWS_ACCESS_KEY_ID=<AWS_Access_Key_ID>
  export AWS_SECRET_ACCESS_KEY=<AWS_secret_key>
  export AWS_DEFAULT_REGION=<your_region>
  ```
- `testing.tfvars` - **ATTENTION! This file is not uploaded because contain sensitive information!** Kitchen is going to use the variables in this file while creating the testing enironment. Please create your own file in the following format:
  ```
  access_key = "<AWS_Access_Key_ID>"
  secret_key = "<AWS_secret_key>"
  key_name = "<keypair_name>.pem"
  region = "<your_region>"
  ```
## Requierments
- You need to have Terraform tool installed
- You need to have functional AWS Account
Please follow the instructions below in order to run this project.

## Installing **Terraform**
- Download required package from [here](https://www.terraform.io/downloads.html)
- Change to directory where package is download. For example: `cd $HOME/Downloads/` 
- Type on your terminal: `unzip <Downloaded_TF_Package>`
- Type on your terminal: `sudo mv terraform /usr/local/bin/`
- Check whether Terraform is available with:  `terraform --version` command

## Make **AWS Account** functional
- If you do not have AWS account click [here](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) in order to create one.
- Set [MFA](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#multi-factor-authentication)
- Set [Access Key ID and Secret Access Key ](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys)
- Set [Key Pair](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#key-pairs)

## Prepare your PC environment for this **Terraform project**
- Download the repo **berchev/terraform_ec2_kitchen**: `git clone https://github.com/berchev/terraform_ec2_kitchen.git`
- Change to berchev/terraform_ec2_kitchen: `berchev/terraform_ec2_kitchen`
- Create a file which ends on **.env** (check **Repo content** section)
- Type in your terminal `. <file>.env` or `source <file>.env`, in order to export AWS data as env variables   
- Edit `main.tf` according to your needs:
  - Choose `ami` from your region. Note that the `ami` specified in the main.tf file could not be available in your region
  - Replace `key_name` value with name of your **key pair**

- Type in your terminal `terraform init` in order to be downloaded required providers
- Type in your terminal `terraform plan` in order to see the changes which terraform is going to be made
- Type in your terminal `terraform apply` execute changes bases on our code(main.tf)

## Terraform results
After successful execution of `terraform apply` command we will have output similar to this one:
```
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

server_name = ec2_server
```

## Remove all created with Terraform
- Type in your terminal `terraform destroy` in order to delete created terraform project

## Prepare your environment for **kitchen**
- Type: `sudo apt-get install rbenv ruby-dev ruby-bundler`
- add to your ~/.bash_profile: 
```
eval "$(rbenv init -)"
true
export PATH="$HOME/.rbenv/bin:$PATH"
```
- do `. ~/.bash_profile` in order to apply the changes made in .bash_profile 

- Change to the directory with `Gemfile` and type: `undle install --path vendor/bundle` in order to install all needed gems for the test

## Test your code with **kitchen**
- Edit **ssh_key** field with `~/path/to/your/private/aws/key.pem` in `.kitchen.yml` file
- Create `testing.tfvars` file according to the instructions in **Repo content** section
- Type: `bundle exec kitchen list` to list the environment
- Type: `bundle exec kitchen converge` to build environment with kitchen
- Type: `bundle exec kitchen verify` to test the created kitchen environment
- Type: `bundle exec kitchen destroy` in order to destroy the created kitchen environment
- Type: `bundle exec kitchen test` in order to do steps from 3 to 5 in one command

## Kitchen results
```
Target:  local://

  ✔  operating_system: the operating system
     ✔  the operating system is Ubuntu

  ubuntu
     ✔  should eq "ubuntu"
  18.04
     ✔  should eq "18.04"

Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 3 successful, 0 failures, 0 skipped
       Finished verifying <default-ubuntu> (0m0.23s).

```

## TO DO
