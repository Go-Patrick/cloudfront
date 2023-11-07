# Cloudfront set up with Terraform
## Building static files from React.Js
First we need to have static files for deploying static host. Following those steps:
- If you have already have a React project that working fine locally, all you need to do is building its bunch of code into a static files and assets.
- After running build command, a folder of static files will be created. Folder names will be dist if you use Vite for building
```bash
npm run build
```
- Now you have enough resource to deploy your website, let's move to next step
## S3 set up
For static web hosting on AWS, first we need to create an S3 bucket that store assets for website

With Terraform, you have to config few things:
- Create a S3 bucket
- Set up ownership and public access for bucket

## Cloudfront set up
Now that your bucket have been set up correctly and allow access from cloudfront, we can set up Cloudfront for CDN:
- Set up origin that point into S3 Bucket
- CLoudfront can have improve performance by caching stuff
- Also config HTTP or HTTPS access into your website

## Upload your files into S3
- After having set up those S3 and Cloudfront, you can deploy your files into S3
- You can upload it manually or use s3 cli