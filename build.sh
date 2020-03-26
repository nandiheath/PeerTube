docker build -t tvhk-peertube .
docker tag tvhk-peertube nandiheath/tvhk-peertube:latest
docker push nandiheath/tvhk-peertube:latest
