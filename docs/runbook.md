# Runbook: UAD Demo App (Node.js)

**Service Tier:** 3 (Internal Demo)
**Owner:** App Team A
**Slack Channel:** #app-team-a-alerts

## Overview
The UAD Demo App is a basic Node.js Express service acting as a reference implementation for our Golden Path. It runs on the `production-server` (Local Runner) via Docker.

## Architecture
* **Compute:** Docker Container (managed by Terraform).
* **Pipeline:** GitHub Actions (consuming `_supply_chain`).
* **Ingress:** Localhost Port 3000.

---

## Common Incidents & SOPs

### 🔴 Incident: Pipeline Failed at "Security Gate"
**Symptom:** The CI/CD pipeline turns red. The `package-artifact` job is skipped.
**Diagnosis:**
1.  Open the GitHub Actions logs.
2.  Click on the `security-check` job.
3.  Look for **"Semgrep Found Errors"**.
4.  Check if the error is `no-eval-with-input`.
**Remediation:**
* **Do not bypass the check.**
* The code contains a violation of Policy v1.0 (likely Remote Code Execution risk).
* Rewrite the code to avoid `eval()` or dangerous sinks.
* Push the fix to trigger a new build.

### 🔴 Incident: Deployment Failed (Port Conflict)
**Symptom:** The `deploy-to-prod` job fails during `terraform apply`.
**Error Log:** `Bind for 0.0.0.0:3000 failed: port is already allocated`.
**Remediation:**
1.  Access the runner terminal.
2.  Run `docker ps` to see what is hogging port 3000.
3.  If a stale container is stuck, run:
    ```bash
    docker stop <container_id>
    docker rm <container_id>
    ```
4.  Re-run the job in GitHub Actions.

### 🔴 Incident: App is Running but 404s
**Symptom:** `docker ps` shows the app is UP, but `curl localhost:3000` fails.
**Remediation:**
1.  Check container logs: `docker logs uad-demo-app`.
2.  Verify the app started correctly (Look for "App listening on port 3000").
3.  If the app crashed immediately, check if `package.json` "start" script matches the `index.js` location.

---

## Disaster Recovery
**Restoring Service:**
Since the infrastructure is ephemeral:
1.  Revert the last bad commit in Git.
2.  The Supply Chain will automatically rebuild the previous safe version.
3.  Terraform will detect the change in image hash and redeploy the safe container.