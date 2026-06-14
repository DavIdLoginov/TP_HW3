FROM node:20-alpine

WORKDIR /app

COPY package.json report.js ./

RUN npm install

CMD ["node", "report.js"]
