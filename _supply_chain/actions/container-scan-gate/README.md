# Action: Container Security Gate

This is a **Composite Action** that acts as the enforcement mechanism for Container Security policies based in Trivy.

Unlike standard scans that happen *inside* a build, this action accepts a **Docker Tarball Artifact**. This ensures we scan the *exact* binary that was built in the previous step, maintaining the Chain of Custody.

## Inputs

| Input | Description | Required |
| :--- | :--- | :--- |
| `image-path` | Path to the `.tar` file containing the saved Docker image. | Yes |
| `governance-version` | The version tag of the policy to apply (e.g., `v1.0`). Maps to `_supply_chain/governance/container-security/`. | Yes |
| `container-ref` | The immutable SHA digest of the Trivy image to use. | Yes |

## Usage
*Intended to be called by a Track Pipeline, not directly by Developers.*

```yaml
- name: Container Gate
  uses: ./_supply_chain/actions/container-scan-gate
  with:
    image-path: "my-app.tar"
    governance-version: "v1.0"
    container-ref: "aquasec/trivy@sha256:..."