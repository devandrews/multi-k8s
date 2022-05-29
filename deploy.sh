docker build -t devandrews/multi-client:latest -t devandrews/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t devandrews/multi-server:latest -t devandrews/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t devandrews/multi-worker:latest -t devandrews/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push devandrews/multi-client:latest
docker push devandrews/multi-server:latest
docker push devandrews/multi-worker:latest

docker push devandrews/multi-client:$SHA
docker push devandrews/multi-server:$SHA
docker push devandrews/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=devandrews/multi-client:$SHA
kubectl set image deployment/server-deployment server=devandrews/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=devandrews/multi-worker:$SHA