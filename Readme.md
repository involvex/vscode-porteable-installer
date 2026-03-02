# vscode-porteable-installer

This tiny CLI bootstraps a portable copy of Visual Studio Code on Windows by downloading the stable archive from Microsoft, extracting it with 7-Zip, and leaving the portable files ready to use.

## Features

- Downloads the latest stable VS Code `win32-x64-archive` release automatically.
- Works from plain PowerShell, from `curl`-powered bootstrapers, or from simple Node/CMD wrappers.
- Keeps the downloaded `vscode-porteable.zip` so you can reuse it, and prompts you before deleting it.

## Requirements

- **Operating system:** Windows 10 or newer with PowerShell (Core or Desktop).
- **PowerShell execution policy:** Any policy that allows running scripts you trust (you can use `powershell -ExecutionPolicy Bypass -File installer.ps1` if needed).
- **7-Zip:** Installed and available on `PATH` as `7z`. The installer uses `7z x` to unpack the archive.
- **Internet access:** Required to hit `https://update.code.visualstudio.com`.

## Quick start

1. Clone or download this repository.
2. Run `npm install` if you want to use the `package.json` scripts (not required).
3. Launch PowerShell or open a Command Prompt; you can now run the installer via any of the commands below.

### Run directly from PowerShell / `curl`

```powershell
curl -o installer.ps1 https://raw.githubusercontent.com/involvex/vscode-porteable-installer/main/installer.ps1
powershell -ExecutionPolicy Bypass -File installer.ps1
```

`curl` on Windows uses the system `curl.exe`, so it follows redirects automatically. The installer creates a `vscode-porteable` folder, downloads the zip, extracts it with `7z x`, and then asks whether to delete the archive.

### Alternative download (explicit redirect)

If you prefer to skip the curl step, use PowerShell to download the archive with `Invoke-WebRequest` and then run the bundled script:

```powershell
Invoke-WebRequest `
  -Uri 'https://update.code.visualstudio.com/latest/win32-x64-archive/stable' `
  -OutFile 'vscode-porteable.zip'
Expand-Archive -Path vscode-porteable.zip -DestinationPath vscode-porteable
```

Then run the installer script manually to keep the prompt/cleanup flow.

### Node / CMD wrapper

Create a small `install.js` if you want to orchestrate the download through Node:

```js
import { execSync } from 'node:child_process';
execSync('powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri \\'https://update.code.visualstudio.com/latest/win32-x64-archive/stable\\' -OutFile \\'vscode-porteable.zip\\'"', { stdio: 'inherit' });
execSync('7z x -y vscode-porteable.zip', { stdio: 'inherit' });
```

Or a `cmd` helper:

```cmd
powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://update.code.visualstudio.com/latest/win32-x64-archive/stable' -OutFile 'vscode-porteable.zip'"
7z x -y vscode-porteable.zip
```

Then rerun `powershell -File installer.ps1` if you want the interactive cleanup prompt.

## What the installer does

1. Creates (or reuses) the `vscode-porteable` directory next to the script.
2. Downloads the latest VS Code `win32-x64-archive` zip.
3. Uses `7z x -y` to extract the contents in place.
4. Shows the prompt “Do you want to delete the downloaded zip archive?” so you can keep the archive as a cache or remove it.
5. Reports success once the extraction completes successfully.

## Troubleshooting

### The downloaded zip is only a few hundred bytes

- Ensure the download URL is exactly `https://update.code.visualstudio.com/latest/win32-x64-archive/stable`.
- When using `curl`, specify `-L` to follow redirects: `curl -L -o vscode-porteable.zip ...`.
- Check for captive portals or proxies that serve HTML instead of the binary; re-run in a clean network if necessary.
- If the download is interrupted, delete the partial `vscode-porteable.zip` and retry.

### 7-Zip fails with `Is not archive`

- Confirm that `7z` is in your `PATH`; run `7z` to verify the executable responds.
- Delete the corrupt `vscode-porteable.zip` and rerun the installer so it fetches the archive again.
- Use the `7z t` command to test an archive before extraction (`7z t vscode-porteable.zip`).

### The script exits before prompting

- Run `powershell -ExecutionPolicy Bypass -File installer.ps1` so PowerShell does not block script execution.
- If you run from CMD, use `powershell -NoProfile -ExecutionPolicy Bypass -Command ".\\installer.ps1"`.

## Development

- `npm run run-install` simply executes `powershell -F installer.ps1`.
- Update `installer.ps1` if Microsoft changes the archive URL or adds new artifacts.
- Keep the README aligned with the commands people use in README and README instructions.

## Contribution & Support

- Open issues on GitHub if the download URL changes or the extraction fails.
- Star the repository if the installer saves you time.
- Sponsorship and donations are linked in the installer script for those who want to support the work.

## License

[MIT](LICENSE) – see the file for details.
