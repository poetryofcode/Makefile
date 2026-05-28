build-back: ## Build the back docker image
	docker build -t todo-back back 
# back is because we making image from back folder where Dockerfile is located 

build-front: ## Build the front docker image (needs .env.development.front)
	. ./.env.development.front && docker build --build-arg "VITE_API_URL=$$VITE_API_URL" -t todo-front front
#. means source we ascend our environment variable into a shell in order to make it accessible by docker
# $$ means is a placeholder
# $ means is variable and could not find and will paste emptiness in that variable
# argument is key=value pair, therefore key is what will be used in Dockerfile and value is we taking from shell.
# in our regular local development Vite would automatically take variable from .env but docker separates development; docker does not see your local files unles you pass it to docker.
# we adding url for backend in order to browser to send requests for backend

network: ## Create the user-defined network
	docker network create todo-net
#by default containers can not talk to each other; therefore we creating network that all 3 containers can talk to each other though their names.

network-rm: ## Remove the user-defined network
	docker network rm todo-net
# if something crashed and we need to redo all over again

up-db: ## Start the db container (needs .env.development.db)
	docker run -d --name todo-db-container --network todo-net -p 15432:5432 --env-file .env.development.db postgres:16-alpine
# once we downloaded image its created container and inside passing variables to create data base.
# --network todo-net -> this is enough to connect to network

up-back: ## Start the back container (needs .env.development.back)
	docker run -d --name todo-back-container --network todo-net -p 13000:3000 --env-file .env.development.back todo-back
# todo-back -> we starting our own backend image

up-front: ## Start the front container
	docker run -d --name todo-front-container -p 18080:80 todo-front

down-db: ## Stop and remove the db container
	docker rm -f todo-db-container
# -f -> allow us to stop & remove running container; without it we need to run first docker stop name; docker rm name;

down-back: ## Stop and remove the back container
	docker rm -f todo-back-container

down-front: ## Stop and remove the front container
	docker rm -f todo-front-container

e2e-install: ## Install front npm deps and the playwright browser (run once)
	cd front && npm install && npx playwright install --with-deps chromium
# only installing all necessary for testing
# playwright - is manual testing it creates browser chromium with --with-deps all necesary settings and start testing like clicking on the bottons that been programmed by developer in front/e2e/list.spec.ts
# e2e - end to end testing of whole app including db


e2e: ## Open the Playwright UI runner against the running containers (needs all three containers up + e2e-install)
	set -a && . ./.env.development.e2e && cd front && npm run e2e
# starting testing
# npm run e2e here located in package.json e2e: Playwright test; it is just coinsidence with the same name as make command
