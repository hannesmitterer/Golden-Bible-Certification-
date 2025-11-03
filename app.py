#!/usr/bin/env python3
import os
from datetime import datetime

import yaml
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

CONFIG_PATH = os.environ.get('FIN_CONFIG_PATH', 'configuration/financial_endpoints.yaml')


def load_financial_config() -> dict:
    try:
        with open(CONFIG_PATH, 'r', encoding='utf-8') as file:
            config = yaml.safe_load(file) or {}
            return config.get('financial_endpoints', {})
    except FileNotFoundError:
        app.logger.error(f"Configuration file not found at {CONFIG_PATH}")
        return {}
    except Exception as exc:
        app.logger.exception("Failed to load configuration: %s", exc)
        return {}


def get_realtime_metrics(cfg: dict) -> dict:
    platform_wallet = cfg.get('platform_funding', {})
    governance_wallet = cfg.get('governance_audit', {})
    bond_offer = cfg.get('digital_bonds_offer', {})

    financial_data = {
        "platform_fund": {
            "name": platform_wallet.get('name'),
            "address": platform_wallet.get('wallet_address'),
            "total_raised_usd": 155000.00,
            "target_usd": 500000.00
        },
        "governance_fund": {
            "name": governance_wallet.get('name'),
            "address": governance_wallet.get('wallet_address'),
            "total_raised_usd": 25000.00,
            "target_usd": 100000.00
        }
    }

    impact_data = {
        "conflicts_monitored": 12450,
        "detection_accuracy_percent": 98.7,
        "active_users": 5200
    }

    governance_data = {
        "status": "Escalation Level 2 - Evidence Not Provided",
        "last_audit_date": "2025-10-02",
        "next_deadline": "2026-04-01"
    }

    investment_data = {
        "offer_details": {
            "name": bond_offer.get('name'),
            "status": bond_offer.get('status'),
            "symbol": bond_offer.get('token_symbol'),
            "apy": bond_offer.get('interest_rate_apy'),
            "maturity": bond_offer.get('maturity_years'),
            "min_investment": bond_offer.get('min_investment_usd'),
            "address": bond_offer.get('wallet_address'),
            "contract_address": bond_offer.get('contract_address')
        },
        "funds_raised_bond": 250000.00,
        "limit_reached_percent": 25.0
    }

    return {
        "timestamp_utc": datetime.utcnow().isoformat(timespec="seconds") + "Z",
        "financial": financial_data,
        "impact": impact_data,
        "governance": governance_data,
        "investment": investment_data
    }


@app.get('/api/v1/metrics')
def get_metrics():
    cfg = load_financial_config()
    metrics = get_realtime_metrics(cfg)
    return jsonify(metrics)


if __name__ == '__main__':
    port = int(os.environ.get('PORT', '5000'))
    app.run(debug=True, host='0.0.0.0', port=port)
