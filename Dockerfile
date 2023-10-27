#node runtime
FROM node:18 as builder

#Working directory
WORKDIR /app

#copy package.json and package-lock.json to the container
COPY package*.json ./

#install dependencies in the container
RUN npm install

#copy the rest of the application to the container
COPY . .

#Build the Application
RUN npm run build

##### Running the application

#node runtime
FROM node:18

WORKDIR /app

#copy dependencies and the built files from build stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./

EXPOSE 3000

CMD ["npm", "start"]