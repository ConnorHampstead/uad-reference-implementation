# Container Security Policy (v2.0)

> **Status:** 🔮 Future Standard | **Tool:** Trivy + Dockle

## Overview
This policy moves beyond CVEs and enforces **Container Best Practices** and **Least Privilege**.

## Configuration
In addition to v1.0 CVE checks, this policy enforces:

* **User Check:** Container must NOT run as `root` (User ID 0).
* **Secrets:** Scans image layers for accidentally baked-in credentials.
* **OS:** Must be based on `alpine` or `distroless` (no massive Debian/Ubuntu base images).
* **Severity:** `CRITICAL`, `HIGH`

## Compliance
To pass v2.0, your Dockerfile must include:
```dockerfile
# Example remediation
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser