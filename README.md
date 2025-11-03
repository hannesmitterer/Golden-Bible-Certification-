# Golden-Bible-Certification-Fiduciary Stewardship

# Golden Bible Certification (Euystacio Fiduciario)

Golden Bible Certification is a lightweight governance and certification framework that defines the Anti‑Hoarding model and the certification standards for custodial and fiduciary stewardship.

This repository contains the initial governance documents, certification criteria, and a configuration file for the sustenance threshold.

Contributing
- Read the governance and certification documents first.
- Open issues for proposed changes.
- Changes to governance should be proposed as pull requests and explicitly reference the sustenance threshold where relevant.

Purpose
- Provide transparent rules and minimal configuration to operate the Golden Bible Certification program.

## Metrics API

The repository includes a minimal Flask API that serves financial metrics and wallet information at `/api/v1/metrics`.

### Quick Start

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run the API server:
```bash
python app.py
```

3. Test the metrics endpoint:
```bash
curl http://localhost:5000/api/v1/metrics
```

The API reads wallet addresses and configuration from `configuration/financial_endpoints.yaml` and returns real-time metrics including:
- Platform and governance fund information
- Digital bonds offering details (wallet: `0x6c10692145718353070cc6cb5c21adf2073ffa1f`)
- Impact metrics and governance status

### Configuration

Set the `FIN_CONFIG_PATH` environment variable to use a different configuration file:
```bash
export FIN_CONFIG_PATH=/path/to/custom/config.yaml
python app.py
```
