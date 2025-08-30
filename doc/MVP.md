# MVP Демонстрація для AsciiArtify

Цей документ демонструє, як швидко розгорнути мінімальний продукт (MVP) AsciiArtify на Kubernetes за допомогою ArgoCD та автоматичної синхронізації з Git.

---

## 1️⃣ Відкрити GitHub Codespace

1. Перейдіть на репозиторій: [AsciiArtify](https://github.com/SlavkoVen/AsciiArtify)
2. Натисніть **Code → Open with Codespaces → New codespace**
3. Перевірте стан репозиторію

## 2️⃣ Створення локального Kubernetes кластера (Kind)

# Встановити kind
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.25.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Створити кластер
kind create cluster --name ascii-cluster

# Перевірити ноди
kubectl get nodes

## 3️⃣ Встановлення ArgoCD у кластер

# Створити namespace для ArgoCD
kubectl create namespace argocd

# Встановити ArgoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Перевірити поди
kubectl get pods -n argocd

## 4️⃣ Використання UI ArgoCD для створення додатку

# Проброс порту для доступу до UI:
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Відкрий у браузері Codespace: https://localhost:8080

# Логін як admin. Початковий пароль:
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

## Натисни New App у UI і заповни:

# - Application Name: asciiapp
# - Project: default
# - Repository URL: https://github.com/SlavkoVen/AsciiArtify.git
# - Revision: main
# - Path: k8s
# - Cluster: https://kubernetes.default.svc
# - Namespace: default

# - Увімкни Automatic Sync і натисни Create

## 5️⃣ Перевірка роботи MVP
# - Перевір поди у namespace default:
kubectl get pods -n default
# - Має з’явитися hello-deploy.

# - Перевір сервіси:
kubectl get svc -n default
# - Має з’явитися hello-svc.

# - Прокидування  порту до сервісу MVP:
kubectl port-forward svc/hello-svc 5000:80

## 6️⃣ Демонстрація автоматичної синхронізації
# - Зроби зміни у YAML файлі k8s/hello.yaml або додай новий Deployment.
