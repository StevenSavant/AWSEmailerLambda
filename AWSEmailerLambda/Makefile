SHELL = /bin/bash
PACKAGE = AWSEmailer
S3BucketName = awsstarfire-lambda-code

banner:
	@echo "Starting build for $(PACKAGE)"

clean-up-pycache:
	@echo "Cleaning up Python cache files"
	find ./ -type f -name '*.py[co]' -delete
	find ./ -type d -name '__pycache__' -delete

create-package:
	@echo "Creating lambda package $(PACKAGE)"
	mkdir -p ./lambda-dist/$(PACKAGE)
	cp *.py ./lambda-dist/$(PACKAGE)
	cp *.html ./lambda-dist/$(PACKAGE)

compress-package:
	@echo "Compressing package $(PACKAGE)"
	cd lambda-dist/$(PACKAGE) && zip -q -r $(PACKAGE).zip *

# This needs to run last as to override any requirements from local reqs, utils, or data
install-psycopg2:
	@echo "Installing psycopg2"
	cd lambda-dist/$(PACKAGE) \
	    && git clone https://github.com/jkehler/awslambda-psycopg2.git .psycopg2 \
	    && cp -r .psycopg2/psycopg2-3.7/ psycopg2 \
	    && rm -rf .psycopg2

updload-to-s3:
	echo "Uploading to S3 Bucket: ${S3BucketName}"
	cd lambda-dist/${PACKAGE} \
		&& aws s3 cp ${PACKAGE}.zip s3://${S3BucketName}

emailer: banner clean-up-pycache create-package install-psycopg2 compress-package updload-to-s3

clean:
	rm -rf ./lambda-*/

.PHONY: lambda clean