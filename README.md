# dwp-tasks
The Analysis of the Case Study Presented

Project Case Study

## Design a Cloud Architecture to host a 3-Tier Application

DWP has adopted a cloud-first strategy. You are tasked with designing a cloud architecture to host a 3-tier application (Presentation, Application, Data) that we are developing. The solution should be scalable, available and secure.
 
Produce a single architecture diagram illustrating how you would implement this in AWS or Azure. Your diagram should consider:

•         The components and services for each tier

•         Strategies for high availability and scalability

•         Security considerations and access control

•         Any additional services/tools for monitoring, logging & management

•         Your submission will be used as a discussion topic at your interview. 


## My Solution (17th December 2025)


📘 AWS Three‑Tier Architecture: Unified Documentation

1. Overview

A three‑tier architecture on AWS consists of:

• Web Tier (Presentation Layer): Entry point for users, handling DNS, CDN, and load balancing.
• Application Tier (Logic Layer): Business logic hosted on EC2 Auto Scaling Groups or containers.
• Database Tier (Data Layer): Managed relational database (Aurora/RDS) with Multi‑AZ resilience.


This document integrates availability, security, observability, and compliance components into a single framework.


2. Entry Point & Traffic Management

• Amazon Route 53• DNS resolution, health checks, failover.
• Latency‑based, weighted, and geolocation routing.

• Amazon CloudFront• Global CDN for caching static/dynamic content.
• Reduces latency, integrates with WAF and Shield.
• Protects origins by hiding direct exposure.

• Application Load Balancer (ALB)• Layer 7 load balancing across AZs.
• SSL/TLS termination.
• Path‑based and host‑based routing.
• Integrates with Auto Scaling Groups.


3. Compute & Scaling

• EC2 Auto Scaling Groups (ASGs)• Elastic scaling across AZs.
• Health checks and automatic replacement.
• Stateless design recommended; sessions externalized.

• NAT Gateway• Secure outbound internet for private subnets.
• Deploy one per AZ for high availability.
• Ensures app/DB tiers can fetch updates without exposure.


4. Database Layer

• Aurora Multi‑AZ Cluster• Synchronous replication across AZs.
• Automatic failover (~30 seconds).
• Reader endpoints for scaling reads.
• Strong consistency for writes.

• Aurora Global Database (Optional)• Asynchronous cross‑region replication.
• Disaster recovery and global read scaling.


5. Security Layers

• **AWS Shield**• DDoS protection (Shield Standard free, Shield Advanced enhanced).

• AWS WAF• Application‑layer firewall.
• Protects against SQL injection, XSS, bots.
• Rate‑based rules and custom filtering.

• Amazon GuardDuty• Threat detection using ML and threat intelligence.
• Identifies anomalous traffic, compromised instances, IAM misuse.

• VPC Flow Logs• Captures IP traffic metadata for forensic analysis.
• Validates subnet traffic patterns.

• AWS Config• Records and evaluates resource configurations.
• Ensures compliance (e.g., ALBs with HTTPS, Aurora encryption).

• AWS CloudTrail• Logs all API calls and resource changes.
• Provides audit trails for compliance and forensics.

• AWS Security Hub• Centralized dashboard for security findings.
• Maps to compliance frameworks (CIS, PCI DSS, GDPR).

• AWS Key Management Service (KMS)• Manages encryption keys.
• Encrypts S3, EBS, RDS, Aurora, and application secrets.

6. Observability & Monitoring

• Amazon CloudWatch• Metrics, logs, alarms, dashboards.
• Monitors ALB latency, EC2 health, Aurora performance.
• Triggers scaling actions.

• AWS X‑Ray• Distributed tracing across web, app, and DB tiers.
• Identifies bottlenecks and errors.
• Provides service maps for dependency visualization.


7. Integrated Architecture Flow

1. User Request: Enters via Route 53 → CloudFront → ALB.
2. Web Tier: ALB distributes traffic to EC2 ASGs across AZs.
3. Application Tier: Processes logic, scales elastically, uses NAT Gateway for outbound internet.
4. Database Tier: Aurora Multi‑AZ cluster handles reads/writes with automatic failover.
5. Security: Shield + WAF protect entry points; GuardDuty, Flow Logs, Config, CloudTrail, Security Hub, and KMS enforce compliance and encryption.
6. Observability: CloudWatch monitors metrics/logs; X‑Ray traces requests end‑to‑end.



8. Best Practices

• Deploy all critical components across at least two AZs.
• Use Aurora Multi‑AZ for resilience; extend to Aurora Global Database for DR.
• Externalize state/session data to DynamoDB or ElastiCache.
• Automate deployments with IaC (CloudFormation/Terraform).
• Regularly test failover and DR scenarios.
• Apply least privilege IAM policies.
• Monitor costs for NAT Gateway, Shield Advanced, and data transfer.


9. Conclusion

This unified three‑tier AWS architecture integrates:

• Availability: Route 53, CloudFront, ALBs, ASGs, Aurora Multi‑AZ.
• Security: Shield, WAF, GuardDuty, Flow Logs, Config, CloudTrail, Security Hub, KMS.
• Observability: CloudWatch, X‑Ray.


Together, these components deliver a resilient, secure, compliant, and highly available environment for modern applications.

 
