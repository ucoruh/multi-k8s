docker build -t ucoruh/multi-client:latest -t ucoruh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ucoruh/multi-server:latest -t ucoruh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ucoruh/multi-worker:latest -t ucoruh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ucoruh/multi-client:latest
docker push ucoruh/multi-server:latest
docker push ucoruh/multi-worker:latest

docker push ucoruh/multi-client:$SHA
docker push ucoruh/multi-server:$SHA
docker push ucoruh/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ucoruh/multi-server:$SHA
kubectl set image deployments/client-deployment server=ucoruh/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ucoruh/multi-worker:$SHA

