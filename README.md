## AWS Static Site

1. Clone this repo as a template.  We generally recommend making your repo private since it contains some AWS identifiers.
2. Remove the LICENSE.txt as your site probably won't be MIT licensed.
2. (Optional) Change `aws_static_site` in `docker/build` and `docker/run` to some other container name that you want (you can skip this if you don't have multiple of these sites).
3. Change the values in `deploy/config.yml`
3. (Optional) Run `docker/run deploy/build_cfn` to inspect the generated CloudFormation files in `deploy/build`
3. Set your AWS credentials into the standard environment variables.
3. Run `docker/run deploy/deploy_cfn` to deploy the infrastructure for the site. This will run `deploy/build_cfn` for you in case you didn't do it above.
4. Make sure that the output messages say your AWS stacks were created successfully.  You can also go into CloudFormation in the AWS console and look for 3 stacks in us-east-1 and 1 stack in us-east-2.  These stacks start with `static-site` followed by the name you configured in `deploy/config.yml`
4. Put your web site in the `site` folder
5. Run `docker/run deploy/deploy_site`
6. Open the domain you configured in `deploy/config.yml` and you should see your site.

Note: running `docker/run deploy/info` will show you information about your site.

## VS Code

You can also develop using VS Code and its devcontainer functionality.
