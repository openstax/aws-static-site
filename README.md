## AWS Static Site

1. Clone this repo as a template.  We generally recommend making your repo private since it contains some AWS identifiers.
2. Remove the LICENSE.txt as your site probably won't be MIT licensed.
2. Change `aws_static_site` in `docker/build` and `docker/run` to some other container name that you want; this is optional unless you have multiple of these sites.
3. Change the values in ./deploy/config.yml
3. (Optional) Run `docker/run deploy/build_cfn` to inspect the generated CloudFormation files in `deploy/build`
3. Set your AWS credentials into the standard environment variables.
3. Run `docker/run deploy/deploy_cfn` to deploy the infrastructure for the site.
4. Put your web site in the `site` folder
4. Run `docker/run s3_website cfg create`.  This creates an `s3_website.yml` file.
5. Modify the contents of this file:
  1. Comment out the `s3_id` and `s3_secret` lines -- just use environment variables for these
  2. Set the name of your bucket under `s3_bucket` (use the primary bucket name, run `docker/run deploy/info` to get it)
  3. Uncomment the `site:` line and set to `site: site` (which is the folder containing the site)
  4. Change the `max_age` settings to something large
  5. Change the `s3_endpoint` to `us-east-1`
  6. Change the `cloudfront_distribution_id` to your distribution ID (again use `docker/run deploy/info`)
6. Run `docker/run s3_website cfg apply`
7. Push the site with `s3_website push`
