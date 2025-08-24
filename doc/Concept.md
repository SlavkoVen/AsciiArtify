# Concept: Локальні Kubernetes інструменти для стартапу AsciiArtify

## Вступ

Для локальної розробки Kubernetes стартап AsciiArtify розглядає три основні інструменти: **minikube**, **kind** та **k3d**.  
Мета — підготувати Proof of Concept (PoC) для перевірки роботи Kubernetes-кластерів та розгортання застосунків.

---

## Характеристики інструментів

| Інструмент | Підтримувані ОС | Архітектури | Режим роботи | Автоматизація | Додаткові функції |
|------------|----------------|------------|--------------|---------------|------------------|
| minikube   | Windows, macOS, Linux | x86_64, ARM | VM або контейнер | Так (CLI) | Dashboard, addon-менеджер, підтримка Helm |
| kind       | Windows, macOS, Linux | x86_64, ARM | Docker контейнери | Так (CLI + YAML) | Мультикластерні кластери, швидке створення |
| k3d        | Windows, macOS, Linux | x86_64, ARM | Docker контейнери з RKE | Так (CLI) | Легкий кластер, швидкий старт, інтеграція з Helm та Rancher |

---

## Переваги та недоліки

| Інструмент | Переваги | Недоліки |
|------------|----------|----------|
| minikube   | Простий старт, стабільний, офіційна документація | Повільне створення кластеру, обмежене масштабування, потребує VM або драйвер контейнерів |
| kind       | Швидке створення, легка інтеграція з CI, мультикластерність | Залежність від Docker, обмежена підтримка моніторингу, іноді мережеві нюанси |
| k3d        | Дуже швидкий, легкий, інтеграція з Rancher, підтримка Helm | Новий інструмент, менша документація, можлива нестабільність при великих навантаженнях |

**Ризики ліцензування Docker:**  
- Docker Desktop має обмеження для комерційного використання.  
- Можлива альтернатива: **Podman** для створення контейнерів без ліцензійних обмежень.  

---

## Демонстрація (Hello World)

**Розгортання Hello World за допомогою k3d:**

### 1️⃣ Створення Deployment та Service
```bash
cat > k8s/hello.yaml <<'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-deploy
  labels: { app: hello }
spec:
  replicas: 1
  selector:
    matchLabels: { app: hello }
  template:
    metadata:
      labels: { app: hello }
    spec:
      containers:
        - name: hello
          image: nginxdemos/hello:plain-text
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: hello-svc
spec:
  selector:
    app: hello
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
YAML

# Створення кластера
k3d cluster create hello-cluster

# Переключення контексту kubectl
kubectl config use-context k3d-hello-cluster

# Розгортання застосунку
kubectl apply -f k8s/hello.yaml

# Перевірка статусу
kubectl get pods
kubectl get svc

# Тестування локально
kubectl port-forward svc/hello-svc 8080:80
curl http://127.0.0.1:8080

# Після виконання повинні бачити шось таке:  
@SlavkoVen ➜ /workspaces/AsciiArtify (main) $ curl http://127.0.0.1:8080
Server address: 127.0.0.1:80
Server name: hello-deploy-98d568dc5-dxz5z
Date: 24/Aug/2025:11:11:59 +0000
URI: /
Request ID: fb175923e6fe08630815a8e557b09bb1

![Hello World Deployment](https://github.com/SlavkoVen/AsciiArtify/blob/main/doc/images/hello.png)



