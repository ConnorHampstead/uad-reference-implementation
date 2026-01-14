# Action: Node.js Security Gate

This is a **Composite Action** that acts as the enforcement mechanism for SAST policies using Semgrep.

It performs a "Hermetic Scan" by:
1.  Fetching the immutable ruleset (Policy Layer) based on the requested version.
2.  Spinning up a pinned, isolated Semgrep container.
3.  Mounting the source code read-only.
4.  Executing the scan.

## Inputs

| Input | Description | Required |
| :--- | :--- | :--- |
| `governance-version` | The version tag of the policy to apply (e.g., `v1.0`). Maps to `_supply_chain/governance/sast/node/`. | Yes |
| `container-ref` | The immutable SHA digest of the Semgrep image to use. | Yes |

## Usage
*Intended to be called by a Track Pipeline, not directly by Developers.*

```yaml
- name: SAST Gate
  uses: ./_supply_chain/actions/node-sast-gate
  with:
    governance-version: "v1.0"
    container-ref: "returntocorp/semgrep@sha256:..."