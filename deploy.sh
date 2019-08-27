docker build -t mwiesbau/complex-client:latest -t mwiesbau/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t mwiesbau/complex-server:latest -t mwiesbau/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t mwiesbau/complex-worker:latest -t mwiesbau/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mwiesbau/complex-client:latest
docker push mwiesbau/complex-client:$SHA
docker push mwiesbau/complex-server:latest
docker push mwiesbau/complex-server:$SHA
docker push mwiesbau/comples-worker:latest
docker push mwiesbau/comples-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mwiesbau/complex-server:$SHA
kubectl set image deployments/client-deployment server=mwiesbau/complex-client:$SHA
kubectl set image deployments/worker-deployment server=mwiesbau/complex-worker:$SHA