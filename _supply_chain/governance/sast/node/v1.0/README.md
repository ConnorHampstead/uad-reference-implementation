# Node.js SAST Policy (v1.0)

> **Status:** ✅ Active (Legacy Compatible) | **Enforcement:** Blocking

## Overview
This is the **Baseline Security Policy** for all Node.js assets. It focuses on preventing catastrophic vulnerabilities such as Remote Code Execution (RCE) and hardcoded credential leaks.

All assets currently in production must comply with this version at a minimum.

## Ruleset
This policy enforces the following Semgrep rules:

| Rule ID | Severity | Description |
| :--- | :--- | :--- |
| `no-eval-with-input` | **ERROR** | usage of `eval()` with variable input is strictly forbidden. |

## Remediation
If your build fails due to this policy:
1.  **Do not request an exemption.** These are critical security flaws.
2.  Replace `eval()` with `JSON.parse()` or appropriate logic.
3.  Move secrets to GitHub Secrets/Vault.