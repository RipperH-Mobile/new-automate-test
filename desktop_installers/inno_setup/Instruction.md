# How to build an installer using Inno-Setup

## Requirements

- Inno Setup Compiler - [Download](http://www.jrsoftware.org/isdl.php)
- Setup execute path for innosetup compiler (iscc.exe)

## Preparing innosetup script

1. Download the innosetup and install it.
2. Setup the path for innosetup compiler (iscc.exe) in the environment variable.
   1. Find the directory of the Inno Setup, should be in the Program Files. Ex. `C:\Program Files (x86)\Inno Setup 6`
   2. Copy the path of the directory.
   3. Go to the environment variable settings.
   4. Add the path to the system variable `Path`.
   5. Restart the command prompt.

## Building the installer

1. Run build windows flutter app using the following command:
   ```
   flutter build windows --release
   ```
2. Copy the following files:
   1. msvcp140.dll
   2. msvcp140_1.dll
   3. msvcp140_2.dll
   4. vcruntime140.dll
   5. vcruntime140_1.dll
   **from** `C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\VC\Redist\MSVC\14.34.31931\x64\Microsoft.VC143.CRT\`
   **to** `.\build\windows\x64\runner\Release\`
1. Create a new file with the extension `.iss` (Ex. `installer.iss`) with the Inno Setup script or use the existing one from the project (`.\desktop_installers\inno_setup\uchat-messenger-inno-setup.iss`).
2. Open command prompt or PowerShell.
3. Navigate to the project directory.
4. Run the following command to build the installer:
   ```
   iscc.exe .\desktop_installers\inno_setup\uchat-messenger-inno-setup.iss
   ```
5. The installer will be generated in the `.\desktop_installers\installer` directory.
