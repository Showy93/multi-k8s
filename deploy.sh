docker build -t showy93/multi-client:latest -t showy93/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t showy93/multi-server:latest -t showy93/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t showy93/multi-worker:latest -t showy93/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push showy93/multi-client:latest
docker push showy93/multi-server:latest
docker push showy93/multi-worker:latest
docker push showy93/multi-client:$SHA
docker push showy93/multi-server:$SHA
docker push showy93/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=showy93/multi-server:$SHA
kubectl set image deployments/client-deployment client=showy93/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=showy93/multi-worker:$SHA
