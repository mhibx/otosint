# OtoSINT

![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Platform](https://img.shields.io/badge/Platform-Linux-E95420?logo=linux)
![Language](https://img.shields.io/badge/Language-Bash-4EAA25?logo=gnu-bash)
![Status](https://img.shields.io/badge/Status-Active-success)

OtoSINT is a lightweight Bash-based tool for automating passive reconnaissance during security assessments.

The project combines several open-source intelligence tools into a single workflow, collects subdomain information from multiple sources, and processes the results into a clean, deduplicated list.

The main goal of OtoSINT is to make repetitive reconnaissance tasks easier to run while keeping the workflow simple and transparent.

---

## Overview

During the reconnaissance phase of a security assessment, information is often collected from multiple sources and then manually combined and cleaned.

OtoSINT automates this process by running several passive enumeration tools, collecting their results, and normalizing the output.

The current workflow focuses specifically on passive subdomain discovery.

~~~text
Target Domain
     │
     ▼
Dependency Validation
     │
     ▼
Initialize Project Structure
     │
     ├──────────────┬──────────────┐
     ▼              ▼              ▼
Subfinder      Assetfinder       crt.sh
     │              │              │
     └──────────────┼──────────────┘
                    ▼
             Merge Raw Results
                    │
                    ▼
          Normalize & Deduplicate
                    │
                    ▼
               unique.txt
~~~

---

## Features

- Passive subdomain enumeration
- Multi-source data collection
- Automatic dependency checking
- Result normalization
- Result deduplication
- Organized per-target output
- Lightweight Bash implementation

---

## Tools Used

| Tool | Purpose |
|------|---------|
| Subfinder | Passive subdomain enumeration |
| Assetfinder | Asset discovery |
| crt.sh | Certificate Transparency enumeration |
| curl | Retrieve Certificate Transparency data |
| jq | Parse JSON responses |

OtoSINT does not replace these tools. Instead, it provides a simple automation layer that combines their output into a single workflow.

---

## Project Structure

~~~text
otosint/
├── recon.sh
├── lib/
│   ├── enum.sh
│   └── utils.sh
├── output/
└── README.md
~~~

### Main Components

**`recon.sh`**

The main entry point for running the reconnaissance workflow.

**`lib/enum.sh`**

Contains the enumeration functions used to collect results from the supported sources.

**`lib/utils.sh`**

Contains utility functions used by the main workflow.

**`output/`**

Stores the results generated for each target.

---

## Installation

Clone the repository:

~~~bash
git clone https://github.com/mhibx/otosint.git

cd otosint
~~~

Install the required dependencies.

### Ubuntu

~~~bash
sudo apt install curl jq
~~~

Install Subfinder:

~~~bash
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
~~~

Install Assetfinder:

~~~bash
go install github.com/tomnomnom/assetfinder@latest
~~~

Make sure all required tools are available in your `PATH` before running OtoSINT.

---

## Usage

Make the script executable:

~~~bash
chmod +x recon.sh
~~~

Run the reconnaissance workflow against an authorized target:

~~~bash
./recon.sh example.com
~~~

---

## Output

Each target receives its own output directory.

~~~text
output/
└── example.com/
    ├── raw.txt
    └── unique.txt
~~~

### `raw.txt`

Contains the raw subdomain results collected from the different enumeration sources.

### `unique.txt`

Contains the normalized and deduplicated results after post-processing.

This separation makes it possible to retain the original collected data while also having a cleaner dataset for subsequent reconnaissance steps.

---

## Example Workflow

~~~text
Target
example.com
    │
    ▼
Running Subfinder
    │
    ▼
Running Assetfinder
    │
    ▼
Querying crt.sh
    │
    ▼
Merging Results
    │
    ▼
Cleaning & Deduplicating
    │
    ▼
unique.txt
~~~

---

## Screenshots

### Script Execution

![Script Execution](screenshots/execution.png)

### Enumeration Results

![Enumeration Results](screenshots/output.png)

---

## Skills Demonstrated

- Bash Scripting
- Linux
- OSINT
- Passive Reconnaissance
- Reconnaissance Automation
- Process Automation
- Data Processing
- JSON Parsing
- Shell Scripting
- Open-Source Tool Integration

---

## Current Scope

OtoSINT currently focuses on passive subdomain enumeration.

The current version does not perform:

- DNS validation
- HTTP probing
- Port scanning
- Screenshot collection
- Vulnerability scanning

Keeping these activities outside the current scope helps maintain a clear separation between passive information gathering and subsequent active reconnaissance or vulnerability assessment.

---

## Future Improvements

Potential extensions include:

- DNS resolution with `dnsx`
- HTTP probing with `httpx`
- Port scanning with `naabu`
- Historical URL collection with `gau`
- Web crawling with `katana`
- Vulnerability detection with Nuclei
- JSON output
- HTML report generation

These features are intentionally not part of the current workflow and would be considered for future iterations.

---

## Disclaimer

OtoSINT is intended for educational purposes and authorized security assessments only.

Only perform reconnaissance against systems and domains for which you have appropriate authorization.
