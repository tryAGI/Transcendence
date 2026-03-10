# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Transcendence is a .NET MAUI cross-platform application with an accompanying CLI tool. The MAUI app targets macOS (Mac Catalyst), Windows, iOS, Android, and Tizen. The CLI tool (`tcd`) automates local actions by providing tools for LLMs. The project is in an early stage of development with minimal application logic implemented so far.

## Build Commands

```bash
# Build entire solution
dotnet build Transcendence.slnx

# Build MAUI app (Mac Catalyst, on macOS)
dotnet build src/Transcendence/Transcendence.csproj

# Build CLI tool
dotnet build src/Transcendence.CLI/Transcendence.CLI.csproj

# Run CLI locally
dotnet run --project src/Transcendence.CLI/Transcendence.CLI.csproj -- do --help
```

Note: MAUI builds require platform-specific workloads. On macOS, only the `net8.0-maccatalyst` target is active. On Windows, only `net8.0-windows10.0.19041.0` is active.

## Architecture

### Project Structure

```
Transcendence/
├── Transcendence.slnx
├── privacy-policy.md              # App privacy policy
├── settings.xamlstyler             # XAML formatting settings
├── src/
│   ├── Transcendence/             # .NET MAUI application
│   │   ├── Transcendence.csproj   # MAUI project (net8.0-maccatalyst / net8.0-windows)
│   │   ├── MauiProgram.cs         # App builder: MAUI + Sentry + CommunityToolkit
│   │   ├── App.xaml.cs            # Application entry
│   │   ├── AppShell.xaml.cs       # Shell navigation
│   │   ├── MainPage.xaml.cs       # Main content page
│   │   ├── Platforms/             # Platform-specific entry points
│   │   │   ├── iOS/
│   │   │   ├── MacCatalyst/
│   │   │   ├── Android/
│   │   │   ├── Windows/
│   │   │   └── Tizen/
│   │   └── Resources/            # Icons, splash, fonts, images, raw assets
│   └── Transcendence.CLI/        # CLI tool
│       ├── Transcendence.CLI.csproj  # net8.0, PackAsTool, command: tcd
│       ├── Program.cs             # Entry point (System.CommandLine RootCommand)
│       ├── Helpers.cs             # Utility functions
│       └── Commands/
│           ├── DoCommand.cs       # Main action command
│           └── AuthCommand.cs     # Authentication command
└── .github/
    ├── workflows/
    │   ├── app-production.yml     # Production MAUI build/deploy
    │   ├── app-staging.yml        # Staging MAUI build/deploy
    │   ├── cli-staging.yml        # CLI staging
    │   ├── maui.yml               # MAUI CI
    │   └── dependabot.yml
    └── prepare_*.sh / *.ps1       # Platform-specific build preparation scripts
```

### MAUI App

- Uses `CommunityToolkit.Mvvm` for MVVM pattern (ObservableObject, RelayCommand, Ioc)
- Uses `CommunityToolkit.Maui` for UI extensions
- Sentry integration for crash reporting and performance monitoring (org: `h-xz`, project: `transcendence`)
- App ID: `com.tryagi.transcendence`

### CLI Tool

- `System.CommandLine`-based CLI packaged as .NET global tool (command name: `tcd`)
- Subcommands: `do` (main action), `auth` (authentication)
- Designed to automate local actions by providing tools for LLMs

## Key Conventions

- **Target framework**: `net8.0` (MAUI with platform-specific TFMs, CLI with plain net8.0)
- **Language**: C# with nullable reference types, implicit usings
- **MAUI version**: 8.0.60
- **MVVM**: CommunityToolkit.Mvvm pattern
- **Error tracking**: Sentry (debug symbols, source maps uploaded on non-Debug builds)
- **CLI packaging**: .NET global tool (`PackAsTool`, command name `tcd`)
- **CI/CD**: Multiple GitHub Actions workflows for staging/production, with platform-specific preparation scripts for Apple, Android, Windows, Mac Catalyst code signing
