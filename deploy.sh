docker build -t somogyib75/multi-client:latest -t somogyib75/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t somogyib75/multi-server:latest -t somogyib75/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t somogyib75/multi-worker:latest -t somogyib75/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push somogyib75/multi-client:latest
docker push somogyib75/multi-server:latest
docker push somogyib75/multi-worker:latest

docker push somogyib75/multi-client:$SHA
docker push somogyib75/multi-server:$SHA
docker push somogyib75/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=somogyib75/multi-server:$SHA
kubectl set image deployments/client-deployment client=somogyib75/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=somogyib75/multi-worker:$SHA
