# 🐳 Ansible Docker-in-Docker Lab

Projekt demonstracyjny tworzący środowisko Ansible w kontenerze (`ansible-control`), który zarządza dwoma kontenerami (`node1`, `node2`) za pomocą SSH i playbooków. Całość w pełni zautomatyzowana z użyciem Docker Compose.

---
## 📁 Struktura katalogu
ansible-dind-project/
├── Dockerfile # Kontroler z Ansible i SSH
├── Dockerfile.node # Obraz nodów z SSH i Pythonem
├── docker-compose.yml # Definicja usług Dockerowych
├── setup.sh # Skrypt inicjalizacyjny (generuje klucz, kopiuje, odpala playbook)
├── hosts.ini # Plik inventory dla Ansible
├── files/
│ └── index.html # Strona serwowana przez Nginx
└── playbooks/
└── deploy_web.yml # Playbook Ansible instalujący Nginx i kopiujący stronę
---

## ▶️ Jak uruchomić

1. **Zbuduj i uruchom wszystkie kontenery:**

```bash
docker compose up --build
```
2. **Węzeł ansible-control automatycznie:**
- Wygeneruje klucz SSH

- Skopiuje go na node1 i node2

- Zweryfikuje połączenia (ansible all -m ping)

- Uruchomi playbook deploy_web.yml

## ✅ Sprawdzenie działania
**Wejdź do kontenera kontrolera:**
```bash
docker exec -it ansible-control bash
```
**Następnie sprawdź:**
1. Ping Ansible:
```bash
ansible all -m ping
```
2. **Działanie serwera WWW**:
```bash
curl http://node1
curl http://node2
```
## 🌐 Udostępnienie portów HTTP (opcjonalnie)
Aby zobaczyć stronę w przeglądarce, dodaj do docker-compose.yml w sekcjach node1 i node2:
```bash
ports:
  - "8081:80"  # dla node1
  - "8082:80"  # dla node2
```
# 📋 Wymagania
Docker + Docker Compose (v2 zalecany)

Linux / macOS / WSL2 / Docker Desktop na Windowsie