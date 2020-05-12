docker build -t chongma/multi-client:latest -t chongma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chongma/multi-server:latest -t chongma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chongma/multi-worker:latest -t chongma/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push chongma/multi-client:latest
docker push chongma/multi-server:latest
docker push chongma/multi-worker:latest
docker push chongma/multi-client:$SHA
docker push chongma/multi-server:$SHA
docker push chongma/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chongma/multi-server:$SHA
kubectl set image deployments/client-deployment client=chongma/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chongma/multi-worker:$SHA