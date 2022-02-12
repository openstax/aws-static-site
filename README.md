# AWS Static Site

This repo lets you host a very low-cost static web site on Amazon Web Services.

## Features

* Free AWS-managed SSL certificate included
* Uses redundant S3 buckets in two regions so that your web site stays live when there is a single AWS region failure.
* Content delivered to users over CloudFront, AWS's fast content delivery network
  * Their permanent free tier provides 1TB of data out and 10M requests
  * Data transfer from S3 to CloudFront is free
* Docker is the only required install on your computer

## Getting Started

1. Clone this repo as a template.  We generally recommend making your repo private since it contains some AWS identifiers.
2. Remove the LICENSE.txt as your site probably won't be MIT licensed.
2. (Optional) Change `aws_static_site` in `docker/build` and `docker/run` to some other container name that you want (you can skip this if you don't have multiple of these sites).
3. Change the values in `deploy/config.yml`
3. (Optional) Run `docker/run deploy/build_cfn` to inspect the generated CloudFormation files in `deploy/build`
3. Set your AWS credentials into the standard environment variables.
3. Run `docker/run deploy/deploy_cfn` to deploy the infrastructure for the site. This will run `deploy/build_cfn` for you in case you didn't do it above.  Note: running `docker/run deploy/info` will show you information about your deployment.
4. Make sure that the output messages say your AWS stacks were created successfully.  You can also go into CloudFormation in the AWS console and look for 3 stacks in us-east-1 and 1 stack in us-east-2.  These stacks start with `static-site` followed by the name you configured in `deploy/config.yml`
4. Put your web site in the `site` folder
5. Run `docker/run deploy/deploy_site`
6. Open the domain you configured in `deploy/config.yml` and you should see your site.

## Updating your Site

Any time you make updates to your site, set your AWS credentials in your environment and then run `docker/run deploy/deploy_site` to make those changes live.

## VS Code

This repo also comes configured with a [VS Code devcontainer](https://code.visualstudio.com/docs/remote/containers) to get you going quickly on your work.  After you install the VS Code Remote Development extension pack, you can open this repo in VS Code and click "Open in Container" in the prompt.  This will set up VS Code with some nice utilities and give you colored prompt in your VS Code terminal running inside the Docker container.
