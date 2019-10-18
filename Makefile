credentials:
	@echo "credentials app.terraform.io {" >> ${HOME}/.terraformrc
	@echo '  token = "${TFCLOUD_SERVICE_KEY}"' >> ${HOME}/.terraformrc
	@echo '}' >> ${HOME}/.terraformrc
	@echo ${GCLOUD_SERVICE_KEY} > ${HOME}/key.json

unit:
	go test ./test/unit/... -v

code-retrieve:
	open 'https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/chromoting%20https://www.googleapis.com/auth/googletalk%20https://www.googleapis.com/auth/userinfo.email&redirect_uri=https://talkgadget.google.com/talkgadget/blank&response_type=code&client_id=440925447803-avn2sj1kc099s0r7v62je5s339mu0am1.apps.googleusercontent.com&access_type=offline'

desktop-build:
	terraform apply

pages:
	(cd docs && npm run generate)

tfcloud-vars:
	bash pushvars.sh