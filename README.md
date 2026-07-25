# OtoSINT

A lightweight Bash-based OSINT automation tool for passive reconnaissance.

OtoSINT simplifies the reconnaissance phase of a security assessment by combining multiple open-source intelligence (OSINT) tools into a single automated workflow. The script performs passive subdomain enumeration, aggregates results from multiple sources, normalizes the output, and generates a clean list of unique subdomains.

---

## Features

- Passive subdomain enumeration
- Multi-source data collection
- Automatic dependency checking
- Result normalization and deduplication
- Organized project output
- Lightweight Bash implementation

---

## Workflow

```text
             Target Domain
                   │
                   ▼
         Dependency Validation
                   │
                   ▼
        Initialize Project Structure
                   │
                   ▼
        ┌──────────┼──────────┐
        │          │          │
        ▼          ▼          ▼
   Subfinder   Assetfinder   crt.sh
        │          │          │
        └──────────┼──────────┘
                   ▼
          Merge Raw Results
                   │
                   ▼
      Normalize & Remove Duplicates
                   │
                   ▼
             unique.txt
```

---

## Project Structure

```text
otosint/
├── recon.sh
├── lib
│   ├── enum.sh
│   └── utils.sh
├── output/
└── README.md
```

---

## Tools Used

| Tool | Purpose |
|------|---------|
| Subfinder | Passive subdomain enumeration |
| Assetfinder | Asset discovery |
| crt.sh | Certificate Transparency enumeration |
| curl | Retrieve Certificate Transparency data |
| jq | Parse JSON responses |

---

## Installation

Clone the repository.

```bash
git clone https://github.com/mhibx/otosint.git

cd otosint
```

Install the required dependencies before running the script.

Example (Ubuntu):

```bash
sudo apt install curl jq

go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

go install github.com/tomnomnom/assetfinder@latest
```

Ensure all required tools are available in your PATH.

---

## Usage

Run the reconnaissance script with a target domain.

```bash
chmod +x recon.sh

./recon.sh example.com
```

---

## Output

Each execution creates a dedicated output directory.

```text
output/
└── example.com/
    ├── raw.txt
    └── unique.txt
```

### raw.txt

Contains all discovered subdomains collected from every enumeration source.

### unique.txt

Contains normalized, deduplicated subdomains after post-processing.

---

## Example Workflow

```text
Target

example.com

↓

Running Subfinder

↓

Running Assetfinder

↓

Querying crt.sh

↓

Cleaning Results

↓

unique.txt generated
```

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
- Reconnaissance Automation
- Process Automation
- Data Processing
- JSON Parsing
- Shell Scripting
- Open Source Tool Integration

---

## Current Limitations

Current version focuses on passive reconnaissance only.

It does not currently include:

- DNS validation
- HTTP probing
- Port scanning
- Screenshot collection
- Vulnerability scanning

---

## Future Improvements

Planned enhancements include:

- DNS resolution (dnsx)
- HTTP probing (httpx)
- Port scanning (naabu)
- Historical URL collection (gau)
- Web crawling (katana)
- Nuclei integration
- JSON export
- HTML report generation

---

## Disclaimer

This project is intended for educational purposes and authorized security assessments only.

Always obtain proper authorization before performing reconnaissance against any target.
