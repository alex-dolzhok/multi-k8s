docker build -t sanok005/multi-client:latest -t sanok005/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sanok005/multi-server:latest -t sanok005/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sanok005/multi-worker:latest -t sanok005/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sanok005/multi-client:latest
docker push sanok005/multi-server:latest
docker push sanok005/multi-worker:latest
docker push sanok005/multi-client:$SHA
docker push sanok005/multi-server:$SHA
docker push sanok005/multi-worker:$SHA
kubectl apply -f k8s

echo "kubernetes deployments:"
kubectl get deployments
kubectl set image deployments/server-deployment server=sanok005/multi-server:$SHA
kubectl set image deployments/client-deployment server=sanok005/multi-client:$SHA
kubectl set image deployments/worker-deployment server=sanok005/multi-worker:$SHA