# AsciiArtify PoC

**AsciiArtify** — "Уявний" стартап, який розробляє продукт для перетворення зображень у ASCII-art за допомогою Machine Learning.  

Цей репозиторій містить **Proof of Concept (PoC)** для локального розгортання Kubernetes-кластерів та демонстрації простого сервісу *"Hello World"* із використанням **ArgoCD** для GitOps-підходу.

---

## 📂 Структура репозиторію

- `k8s/hello.yaml` — Deployment та Service для демонстраційного Hello World.
- `doc/Concept.md` — Concept документ із порівнянням **minikube**, **kind** та **k3d**, включно з командами для демо.
- `doc/MVP.md` — опис MVP: інтеграція ArgoCD, розгортання Hello World, перевірка доступності.
- `doc/images/hello.png` — скріншот результату розгортання Hello World.

---

## 🚀 Використання

### 1. Клонувати репозиторій:
git clone https://github.com/SlavkoVen/AsciiArtify.git
cd AsciiArtify

### 2. Розгорнути маніфести Kubernetes:
kubectl apply -f k8s/hello.yaml
kubectl rollout status deployment hello-deploy

###3. Перевірити роботу сервісу:
kubectl port-forward svc/hello-svc 5000:80
curl http://127.0.0.1:5000


### 📸 Результат доступний у файлі doc/images/hello.png.

🔄 GitOps з ArgoCD

У ArgoCD створюється Application, яке вказує на цей репозиторій та папку k8s/.

ArgoCD автоматично синхронізує зміни з GitHub у Kubernetes-кластер.

Будь-яка зміна у k8s/hello.yaml призведе до оновлення деплойменту.

### ✅ Результат

- Kubernetes-кластер піднятий локально.

- Hello World сервіс розгорнутий.

- Доступ до нього можна отримати через port-forward.

- Інтеграція з ArgoCD підтверджує працездатність GitOps-підходу.