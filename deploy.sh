docker build -t mpac60/multi-client-learning:latest -t mpac60/multi-client-learning:$SHA -f ./client/Dockerfile ./client
docker build -t mpac60/multi-worker-learning:latest -t mpac60/multi-worker-learning:$SHA -f ./worker/Dockerfile ./worker
docker build -t mpac60/multi-server-learning:latest -t mpac60/multi-server-learning:$SHA -f ./server/Dockerfile ./server

docker push mpac60/multi-client-learning:latest
docker push mpac60/multi-worker-learning:latest
docker push mpac60/multi-server-learning:latest

docker push mpac60/multi-client-learning:$SHA
docker push mpac60/multi-worker-learning:$SHA
docker push mpac60/multi-server-learning:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mpac60/multi-server-learning:$SHA
kubectl set image deployments/client-deployment client=mpac60/multi-client-learning:$SHA
kubectl set image deployments/worker-deployment worker=mpac60/multi-worker-learning:$SHA