# puppeteer-docker

```sh
docker build -t puppeteer-docker .

docker run -i --cap-add=SYS_ADMIN --name puppeteer-docker-container puppeteer-docker

# 作成したPDFの確認
# コンテナからローカルにコピー
docker cp puppeteer-docker-container:/usr/local/app/test.png . && docker cp puppeteer-docker-container:/usr/local/app/test.pdf .
```
