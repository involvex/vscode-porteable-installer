---
post_title: "Copilot guidance for vscode-porteable-installer"
author1: "Copilot CLI"
post_slug: "vscode-porteable-instructions"
microsoft_alias: "copilot"
featured_image: ""
categories: ["documentation"]
tags: ["installer", "powershell", "documentation"]
ai_note: "yes"
summary: "Explain how to keep the installer documentation current and how to guide users through downloading and extracting VS Code."
post_date: "2026-03-02"
---

# Copilot guidance for vscode-porteable-installer

## Project goals
- Deliver a one-step installer that downloads the latest `win32-x64-archive` from Microsoft and extracts it with 7-Zip.
- Keep the README documentation thorough so operators can run the script via `curl`, PowerShell, or simple Node/CMD wrappers and understand what to do when things fail.
- Ensure Copilot responses keep the fix lightweight: no new binaries, no self-contained downloads, and no Windows Subsystem for Linux.

## Key files
- `installer.ps1`: entry-point script that creates `vscode-porteable`, downloads `vscode-porteable.zip`, extracts it via `7z`, and prompts the user about deleting the archive.
- `package.json`: exposes `run-install` and includes metadata (name, funding) – keep this synchronized with instructions in the README.
- `Readme.md`: the main document outlining requirements, usage, troubleshooting, and troubleshooting, so keep it the single source of truth for users.
- `.copilot/instructions/vscode-porteable.instructions.md`: this file guides any Copilot agent that works on the repo.

## Documentation expectations
- When asked to document or improve this repo, focus on clarifying how to run the installer (curl or PowerShell), what dependencies are necessary (PowerShell + 7-Zip), and how to clean up after extraction.
- Mention the download URL explicitly (`https://update.code.visualstudio.com/latest/win32-x64-archive/stable`) so maintainers can verify future changes.
- Provide PowerShell or `curl` snippets that follow redirects (`curl -L` or `Invoke-WebRequest`); highlight the interactive prompt at the end about deleting the zip.

## Behavior guide
- Favor minimal, precise changes rather than wide-reaching refactors.
- Keep Windows tooling in mind: avoid assuming Unix tools like `bash` or `tar`.
- When suggesting fixes, include explicit commands (with flags) and mention any prerequisites (sudo, PATH, etc.) if new tools are needed.
- Cite VS Code versioning where relevant and remind users to verify that 7-Zip is installed on PATH before they run the script.

## Testing & validation
- There is no automated test suite. Validate changes manually by reading the README and confirming the commands make sense, and mention that the installer simply runs `powershell -F installer.ps1`.
