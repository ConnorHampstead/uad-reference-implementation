# Node.js SAST Policy (v2.0)

> **Status:** 🚧 Beta / High Security | **Enforcement:** Blocking for New Assets

## Overview
This is the **Hardened Security Policy** for Node.js. It includes all rules from v1.0 but adds strict checks for Asynchronous logic and Regular Expression Denial of Service (ReDoS).

**Note, for the sake of demonstration in UAD it does NOT contain all of the rules from v1.0, but removes eval() so that the policy version 2.0 allows the code to get through the gate.**

**Target Audience:** Fintech services, PII processors, and all new projects starting after Jan 2024.

## Ruleset Changes (vs v1.0)

| Rule ID | Severity | Description |
| :--- | :--- | :--- |
| `no-sync-functions` | **ERROR** | Usage of `fs.readFileSync` is banned in HTTP handlers to prevent event loop blocking. |

## Migration
To upgrade your Asset from v1.0 to v2.0:
1.  Update your `ci.yaml` to reference `sast-policy-version: "v2.0"`.
2.  Run the pipeline.
3.  Refactor synchronous I/O to use `fs.promises`.