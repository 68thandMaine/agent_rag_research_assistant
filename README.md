# RAG Research Agent

This project is optimized for viewing, editing, and running within a VSCode-like environment. For the best experience, please ensure that you have [Deno](https://deno.land) installed.

## Prerequisites

### Database Setup

This project requires PostgreSQL with pgVector extension. The easiest way to set this up is using Docker:

**Quick Setup:**
```bash
# Run the automated setup script
./scripts/setup-database.sh
```

**Manual Setup:**
```bash
# Start PostgreSQL with pgVector
docker-compose up -d

# Create a .env file with your configuration
cp .env.example .env  # Then edit with your OpenAI API key
```

For detailed database setup instructions, see [Database Setup Guide](docs/DATABASE_SETUP.md).

### Deno Installation

1. **Check if Deno is installed:**

   Open your terminal and run:
   ```bash
   deno -v
   ```

2. **Install Deno (if not already installed):**

   **For macOS/Linux:**
   ```bash
   curl -fsSL https://deno.land/install.sh | sh
   ```

   **For Windows (PowerShell):**
   ```powershell
   irm https://deno.land/install.ps1 | iex
   ```

   After installation, verify the installation by running:
   ```bash
   deno --version
   ```

3. For more installation details, refer to the [Deno Installation Guide](https://docs.deno.com/runtime/#install-deno).

### VSCode Configuration for Deno and IPYNB Files

1. **Enable Deno in VSCode:**
   - Install the "Deno" extension from the VSCode marketplace.
   - Open the Command Palette (Cmd/Ctrl + Shift + P) and select "Preferences: Open Workspace Settings".
   - Search for "Deno" and enable the option `Deno: Enable`.

2. **Enable Support for .ipynb Files:**
   - Install the "Jupyter" extension from the VSCode marketplace.
   - This extension enables VSCode to open and render `.ipynb` files.
   - Reload VSCode after installation if needed.

## Requirements

- **Docker & Docker Compose:** For PostgreSQL with pgVector
- **OpenAI API Key:** Required for embeddings
- **Deno Runtime:** Version 1.x or higher.
- **VSCode:** Latest version recommended.
- **VSCode Extensions:**
  - Deno
  - Jupyter

## Project Overview

This project leverages Deno for a secure and efficient runtime environment while providing an optimal development experience in VSCode. It includes various modules and tools designed to work seamlessly with Deno and supports advanced file types, including Jupyter Notebook (`.ipynb`) files.
