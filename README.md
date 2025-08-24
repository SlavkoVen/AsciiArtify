# AsciiArtify PoC

AsciiArtify — стартап, який розробляє продукт для перетворення зображень у ASCII-art за допомогою Machine Learning.  

Цей репозиторій містить PoC для локального розгортання Kubernetes-кластерів та демонстрацію простого сервісу "Hello World".

## Структура репозиторію
- `k8s/hello.yaml` — Deployment та Service для демонстраційного Hello World.
- `doc/Concept.md` — Concept документ із порівнянням minikube, kind та k3d, включно з командами демо.
- `doc/images/hello.png` — скріншот результату розгортання Hello World.

## Використання
1. Клонувати репозиторій:
   git clone https://github.com/SlavkoVen/AsciiArtify.git
   cd AsciiArtify

## Застосувати Kubernetes YAML:
- kubectl apply -f k8s/hello.yaml
- kubectl rollout status deployment hello-deploy

## Перевірити роботу сервісу:
- kubectl port-forward svc/hello-svc 8080:80
- curl http://127.0.0.1:8080

