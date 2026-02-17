FROM node:25

WORKDIR /safehands-app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8000

CMD ["npm", "run", "dev"]