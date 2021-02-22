docker build -t epg/multi-client:latest -t multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t epg/multi-server:latest -t multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t epg/multi-worker:latest -t multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push epg/multi-client:latest
docker push epg/multi-server:latest
docker push epg/multi-worker:latest

docker push epg/multi-client:$SHA
docker push epg/multi-server:$SHA
docker push epg/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=epg/multi-client:$SHA
kubectl set image deployments/server-deployment server=epg/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=epg/multi-worker:$SHA