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
  **password:** xxxx  
- Add Prometheus as a data source:  
  `http://prometheus:9090`
- Import dashboards:
  - Node Exporter Full (ID: **1860**)
  - Prometheus 2.0 Stats (ID: **3662**)
  - Kubernetes / Docker dashboards if needed


# **How to Start the Stack**
From inside the `monitoring/` directory:


docker compose up -d


# Next Step Enhnancements


# **3. Add Slack / Teams / Email Alerting (Alertmanager)**

Below are templates for all three. You can enable one or multiple depending on what you need.


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

Replace the webhook URL with your Slack Incoming Webhook.


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

