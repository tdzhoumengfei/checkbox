# playwright-template
A Playwright (https://playwright.dev/) template for future automated tests projects

## Tech stack

This project uses the following technologies

- Javascript
- Node.JS (12+)
- Playwright
- Docker
- Bash

The project also makes use of/can be integrated with the following tools

- SIP Call Provider [https://github.com/Talkdesk/sip-call-provider/] [OPTIONAL]
- Twillio Toolkit [https://github.com/Talkdesk/twilio-toolkit] [OPTIONAL]
- Allure
- NGROK

## Template Structure
This template follows the described structure: 

Configuration file 
- playwright.config.json

KCI Pipeline file 
- kci-pipelines.yaml

Dockerfile
- Dockerfile

Docker Compose 
- docker-compose

Page Objects are stored in the pageObject folder 

Any auxiliary scripts should be inside the scripts folder

Any helpers used should be in the helpers folder 

## Setup

1. Clone the project: `git clone https://github.com/Talkdesk/playwright-template.git`
2. Install dependencies: `npm install`
3. Being the first time running, to save some time you can also install all playwright dependencies (ex. browsers)
` npx playwright install`
4. Make a copy of the `.env.template` file called `.env` and replace the variables values according to your Talkdesk account setup. E.g.: (for QA environment)

````script
AGENT_USERNAME=AGENTUSERNAME@talkdesk.com
AGENT_PASSWORD=AGENTPASSWORD
ACCOUNTNAME=ACCOUNTNAME
TD_ID_BASE_URL=https://ACCOUNTNAME.talkdeskqaid.com/login
````

5. In admin (Talkdesk Classic), make sure your account or agent has the config "Activate Talkdesk Workspace as the default login experience" enabled and that your agent has the default status "Available".  
6. You can run the tests locally with or without docker, just pick up one of the scripts below. 

## Available scripts

````npm
npm run test:local 
````

- In case you want to run all tests locally in headed mode (without Docker):

````script
npm run test:local:headed
````


- Run all tests locally with Docker:

````script
npm run test:docker:local
````

- In case you want to check linting errors:

````npm
npm run lint
````

- To fix any fixable linting errors:

````npm
npx run lintfix
````

## Debugging

When a test fails, the screenshot with the failing state and the video recording are saved in ./playwright-report. For pipeline executions, the failling screenshots are located inside the respective Allure report for that execution 

## Reporting 

For this project we are using Allure for reporting.
On Jenkins, the report will be displayed in the Blue Ocean view after the test execution. 
If you want to check the report locally, run the following command after the test execution: 

````npm
allure generate ./allure-results --clean && allure open ./allure-report
````

If you want/need to change the generated reports, just change them by modifying your config file (*playwright.config.js*)

## Inbounds: running sip-call-provider locally [optional] and/or twillio-toolkit

You can find configured in this project two options for getting an inbound call in the tests: 
- sip-call-provider
- twillio-toolkit

For each of them there is an spec file as example for usage: tests/specs/inbounds/sip-call-provider.spec and tests/specs/inbounds/twilio-toolkit.spec. In order to test it in CI, don't forget to remove the ````testIgnore```` in the playwright.config.js file as well as have your env vars saved in Meza [https://talkdesk.atlassian.net/wiki/spaces/MEZA/pages/1532166397/Meza+Handbook] TD platform. 

The guidence about both approaches:
- https://talkdesk.atlassian.net/wiki/spaces/AQA/pages/3351446013/Spike+-+Tools+for+inbound+calls
- https://talkdesk.atlassian.net/wiki/spaces/AQA/pages/3773890695/Using+twilio-toolkit+instead+of+call-sip-provider
- https://talkdesk.atlassian.net/wiki/spaces/AQA/pages/3494446475/Running+sip-call-provider+locally

These how-to article describe how to use the sip-call-provider locally while developing new automated tests in the convo-voice-tests project (and that need to handle inbound calls) or debugging an issue.
