**A complete, production‑ready monitoring stack** with:

- **Prometheus**
- **Node Exporter**
- **Grafana**
- **Alertmanager**
- **Persistent storage**
- **A shared monitoring network**
- **A clean directory structure**
- **Fully working Prometheus + Alertmanager configs**
- **Dashboards ready to import in Grafana**


# **Grafana Setup**
Once the stack is running:

- Visit **http://localhost:3000**
- Login:  
  **user:** admin  
  **password:** admin  
- Add Prometheus as a data source:  
  `http://prometheus:9090`
- Import dashboards:
  - Node Exporter Full (ID: **1860**)
  - Prometheus 2.0 Stats (ID: **3662**)
  - Kubernetes / Docker dashboards if needed

---

# **How to Start the Stack**
From inside the `monitoring/` directory:

```
docker compose up -d
```

---

# **If you want, I can also build:**
- A version with **Blackbox Exporter** for HTTP/TCP/ICMP checks  
- A version with **Loki + Promtail** for logs  
- A version with **Thanos** for long‑term metrics storage  
- A version with **Alertmanager Slack/Teams/Email** integrations  
- A version tailored for **Kubernetes monitoring**  

Just tell me which direction you want to take this stack and I’ll expand it.

# Enhnancements

Perfect — let’s extend your monitoring stack with **(3) Slack/Teams/Email alerting** and **(5) automatic Grafana dashboard provisioning**.  
I’ll give you clean, production‑ready configurations you can drop straight into your existing directory structure.

---

# **3. Add Slack / Teams / Email Alerting (Alertmanager)**

Below are templates for all three. You can enable one or multiple depending on what you need.

---

## **A. Slack Alerting (recommended)**
Update your `alertmanager/alertmanager.yml`:

```yaml
global:
  resolve_timeout: 5m

route:
  receiver: "slack_notifications"

receivers:
  - name: "slack_notifications"
    slack_configs:
      - api_url: "https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK"
        channel: "#alerts"
        send_resolved: true
        title: "🔥 Alert: {{ .CommonLabels.alertname }}"
        text: >
          *Severity:* {{ .CommonLabels.severity }}
          *Instance:* {{ .CommonLabels.instance }}
          *Description:* {{ .CommonAnnotations.description }}
```

Replace the webhook URL with your Slack Incoming Webhook.

---

## **B. Microsoft Teams Alerting**
Teams uses a webhook + JSON payload.

```yaml
global:
  resolve_timeout: 5m

route:
  receiver: "teams_notifications"

receivers:
  - name: "teams_notifications"
    webhook_configs:
      - url: "https://outlook.office.com/webhook/YOUR_TEAMS_WEBHOOK"
        send_resolved: true
```

Teams will receive alerts as cards.

---

## **C. Email Alerting**
You can use Gmail, Outlook, SES, etc.

```yaml
global:
  smtp_smarthost: "smtp.gmail.com:587"
  smtp_from: "your-email@gmail.com"
  smtp_auth_username: "your-email@gmail.com"
  smtp_auth_password: "YOUR_APP_PASSWORD"

route:
  receiver: "email_notifications"

receivers:
  - name: "email_notifications"
    email_configs:
      - to: "recipient@example.com"
        send_resolved: true
```

⚠️ Gmail requires an **App Password**, not your normal password.

---

# **5. Automatic Grafana Dashboard Provisioning**

Grafana supports provisioning dashboards and data sources automatically at startup.  
Let’s add:

- A provisioning directory  
- A Prometheus data source  
- Auto‑loaded dashboards (Node Exporter, Prometheus, Docker Host, etc.)

---

# **Directory Structure Update**

Add:

```
monitoring/
│
├── grafana/
│   ├── provisioning/
│   │   ├── dashboards/
│   │   │   └── dashboards.yml
│   │   └── datasources/
│   │       └── datasource.yml
│   └── dashboards/
│       ├── node_exporter.json
│       ├── prometheus_stats.json
│       └── docker_host.json
```

You can download JSON files directly from Grafana.com (IDs: 1860, 3662, 1229).

---

# **Update docker-compose.yml for Grafana provisioning**

Modify your Grafana service:

```yaml
grafana:
  image: grafana/grafana:latest
  container_name: grafana
  ports:
    - "3000:3000"
  volumes:
    - grafana_data:/var/lib/grafana
    - ./grafana/provisioning:/etc/grafana/provisioning
    - ./grafana/dashboards:/var/lib/grafana/dashboards
  environment:
    - GF_SECURITY_ADMIN_PASSWORD=admin
  networks:
    - monitoring
```

---

# **datasource.yml (auto‑provision Prometheus)**

```yaml
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://prometheus:9090
    isDefault: true
```

---

# **dashboards.yml (auto‑load dashboards)**

```yaml
apiVersion: 1

providers:
  - name: "default"
    orgId: 1
    folder: ""
    type: file
    disableDeletion: false
    editable: true
    options:
      path: /var/lib/grafana/dashboards
```

---

# **How it works**
- Grafana loads the Prometheus data source automatically  
- Grafana loads all dashboards in `/grafana/dashboards/` automatically  
- No manual setup required  
- Dashboards appear instantly on first login  

---

