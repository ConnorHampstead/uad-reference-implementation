# Unified Asset Delivery (UAD): Reference Implementation

This repository contains a reference implementation of the **Unified Asset Delivery (UAD)** standard.

It serves as a living proof-of-concept for the architectural pattern described in: [Stop Shipping Code: The Case for Unified Asset Delivery](https://www.linkedin.com/pulse/stop-shipping-code-case-unified-asset-delivery-uad-connor-hampstead-fwnce).

## Concept

In UAD, a deliverable application is treated as an **Asset**. An Asset is only valid if it contains 5 inseparable layers. If any layer is missing, the Asset is incomplete and cannot be shipped.

1.  **Application Logic** (The Code)
2.  **Execution Context** (The Infrastructure)
3.  **Delivery Logic** (The Pipeline)
4.  **Governance Model** (The Policy)
5.  **Knowledge Model** (The Documentation)

## How to Read This Repository
This is a Reference Implementation of the Unified Asset Delivery (UAD) methodology. It simulates a full Enterprise DevSecOps environment within a single repository for educational purposes.

The repository is divided into two distinct logical domains:

### The Supply Chain (Simulating the Platform Team)
📂 _supply_chain/: This folder represents the "Central Governance" repo.

Contains Pipeline Templates (GitHub Actions).

Contains Security Policies (Semgrep Rules, Trivy Configs).

Contains Infrastructure Modules (Terraform).

Note: In a real setup, this would be a separate, locked-down repository.

### The Asset (Simulating the Product Team)
📂 src/: The Application Code (Node.js).

📂 infra/: The Configuration. Notice it contains almost no logic—it simply consumes the modules provided by the Supply Chain.

📄 .github/workflows/ci.yaml: The Consumer Pipeline. It does not define steps; it simply calls the "Golden Path" track defined in the Supply Chain.

## Architecture

This repository is organized into two root directories: `_supply_chain` and `asset-repo`.

### 1. The Supply Chain (`_supply_chain`)
In a real-world scenario, these components would be pulled from an artifact store or a dedicated platform repository. For this demonstration, they exist here to simulate the external, immutable dependencies that the Asset consumes.

| Layer | Directory | Description |
| :--- | :--- | :--- |
| **2. Execution Context** | `infrastructure` | Reusable Terraform modules (e.g., `local-web-service`) provided as governed Assets by the Platform Team. |
| **3. Delivery Logic** | `pipelines` | Full "Golden Path" CI/CD pipelines (e.g., `build-node-container-v1`) callable by Assets. |
| **3. Delivery Logic** | `actions` | Granular build/security steps (e.g., `node-sast-gate`) composed into the pipelines above. |
| **4. Governance Model** | `governance` | Immutable policy definitions for SAST (`sast/node`) and Container Security (`container-security`). |
| **5. Knowledge Model** | `**/*.md` | Documentation embedded within every module, action, and policy version. |

### 2. The Asset (`asset-repo`)
This directory functions as the monorepo for the Product. It contains all 5 UAD layers. As with application code, **each commit to this directory represents a new Asset version**, even if only the governance policy or delivery logic configuration changes.

| Layer | Directory | UAD Role | Description |
| :--- | :--- | :--- | :--- |
| **1. Application Logic** | `/src` | **Producer** | The Node.js application source code. |
| **2. Execution Context** | `/infra` | **Consumer** | Terraform configuration that instantiates the immutable modules from the Supply Chain. |
| **3. Delivery Logic** | `.github` | **Consumer** | The `ci.yaml` interface. It does not define steps; it simply calls a specific version of the Golden Path pipeline. |
| **4. Governance Model** | *(Virtual)* | **Consumer** | The Asset declares adherence to a policy version (e.g., `sast_policy: v1.0`) in the CI configuration. |
| **5. Knowledge Model** | `/docs` | **Producer** | Architecture Decision Records (ADRs), Runbooks, and technical documentation versioned alongside the binary. |

---

## Usage Guide

To run this demonstration, you will simulate both the **Platform/Security Team** (providing the supply chain) and the **Product Team** (shipping the asset).

### Prerequisites
1.  **Docker Desktop** installed and running.
2.  A **GitHub Account**.

### Step 1: Fork & Configure
1.  **Fork this repository** to your own GitHub account.
2.  Clone your fork locally.
3.  **Update References:**
    * The pipeline files currently point to `ConnorHampstead/uad-reference-implementation`.
    * You must update these references to point to your fork so the Actions can find the reusable workflows.
    * Do a "Find and Replace" in your editor to change `ConnorHampstead` to `[Your-GitHub-Username]` in `.github/workflows/ci.yaml` and `_supply_chain/**/*.yaml`.

### Step 2: Establish the "Platform" (Versioning)
The pipelines rely on immutable Git Tags (e.g., `@v1`) to fetch the supply chain logic. You must initialize this tag in your fork.

```bash
# Initialize the v1 "Floating Tag" for the Supply Chain
git tag -f v1
git push origin v1 --force