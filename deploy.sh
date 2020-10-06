docker build -t snirshechter/fibonacci-client:latest -t snirshechter/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t snirshechter/fibonacci-server:latest -t snirshechter/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t snirshechter/fibonacci-worker:latest -t snirshechter/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

docker push snirshechter/fibonacci-client:latest
docker push snirshechter/fibonacci-server:latest
docker push snirshechter/fibonacci-worker:latest
docker push snirshechter/fibonacci-client:$SHA
docker push snirshechter/fibonacci-server:$SHA
docker push snirshechter/fibonacci-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=snirshechter/fibonacci-server:$SHA
kubectl set image deployments/client-deployment client=snirshechter/fibonacci-client:$SHA
kubectl set image deployments/worker-deployment worker=snirshechter/fibonacci-worker:$SHA