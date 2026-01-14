# Container Security Policy (v1.0)

> **Status:** ✅ Active | **Tool:** Trivy

## Overview
This policy defines the acceptable risk threshold for Docker images deployed to our environment. It focuses on **Known Vulnerabilities (CVEs)**.

## Configuration
The Trivy configuration (`trivy-config.yaml`) enforces:

* **Exit Code:** 1 (Fail Pipeline) on violation.
* **Severity:** `CRITICAL`
* **Ignore Unfixed:** Yes (We do not block on vulnerabilities that have no vendor patch).

## Compliance
An Asset complies with v1.0 if:
1.  It contains **0 Critical** CVEs (with available fixes).
2.  It contains **0 High** CVEs (with available fixes).