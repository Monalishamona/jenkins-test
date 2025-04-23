#!/usr/bin/env sh

npm run build

npm start &
sleep 1
echo $! > .pidfile

echo 'Now...'
echo 'Visit https://jenkins-test-rzsr.vercel.app/ to see your Node.js/React application in action.'
