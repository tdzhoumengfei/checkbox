FROM mcr.microsoft.com/playwright:focal
ARG BUNDLE_GITHUB__COM
RUN git config --global url."https://$BUNDLE_GITHUB__COM@github.com/Talkdesk/".insteadOf "https://github.com/Talkdesk/"
COPY package.json ./ 
RUN npm install
RUN apt-get install xvfb
COPY ./ ./
RUN npx playwright install
