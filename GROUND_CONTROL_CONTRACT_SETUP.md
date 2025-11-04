# Ground Control - Contract Address Setup Instructions

## Objective
Configure the KarmaBond.sol contract address in the unified wallet configuration after successful deployment to Polygon Mainnet.

---

## Prerequisites

Before proceeding with these instructions, ensure:

1. ✅ KarmaBond.sol contract has been **successfully deployed** to Polygon Mainnet (Chain ID: 137)
2. ✅ You have obtained the **Contract Address** from the deployment transaction
3. ✅ Contract deployment has been **verified** on Polygon scan (optional but recommended)
4. ✅ You have write access to the repository configuration files

---

## Step 1: Obtain Contract Address

After deploying the KarmaBond.sol contract to Polygon, you will receive a transaction receipt containing the contract address.

**Expected format:**
```
Contract Address: 0x[40 hexadecimal characters]
Example: 0x1234567890abcdef1234567890abcdef12345678
```

**Verification:**
- Contract address must be exactly 42 characters (including `0x` prefix)
- Contains only hexadecimal characters (0-9, a-f, A-F)
- Deployed on Polygon Mainnet (Chain ID: 137)

---

## Step 2: Update Configuration File

### File to Modify:
```
invest_config.yaml
```

### Location in File:
Navigate to line 37 where the contract_address placeholder is located:

```yaml
offer_details:
  start_date: "2025-12-01T00:00:00Z"
  target_amount: 5000000 # 5 Milioni di unità dell'Asset di Raccolta
  current_status: "Awaiting Final Chain Confirmation"
  contract_address: "" # Placeholder per contratto KarmaBond.sol
```

### Modification Required:
Replace the empty string with your deployed contract address:

**BEFORE:**
```yaml
contract_address: "" # Placeholder per contratto KarmaBond.sol
```

**AFTER:**
```yaml
contract_address: "0xYourActualContractAddressHere" # KarmaBond.sol deployed on Polygon
```

### Example:
```yaml
offer_details:
  start_date: "2025-12-01T00:00:00Z"
  target_amount: 5000000
  current_status: "Active - Contract Deployed"
  contract_address: "0x1234567890abcdef1234567890abcdef12345678" # KarmaBond.sol deployed on Polygon
```

---

## Step 3: Update Status (Optional but Recommended)

Since the contract is now deployed, update the `current_status` field to reflect the new state:

**Change:**
```yaml
current_status: "Awaiting Final Chain Confirmation"
```

**To:**
```yaml
current_status: "Active - Contract Deployed"
```

or

```yaml
current_status: "Live on Polygon"
```

---

## Step 4: Validate Configuration

Before committing changes, validate the YAML syntax:

### Option A: Using Python
```bash
python3 -c "import yaml; yaml.safe_load(open('invest_config.yaml'))"
```

### Option B: Using yq (if installed)
```bash
yq eval '.' invest_config.yaml
```

**Expected Result:** No errors should be displayed.

---

## Step 5: Verify Integration

Test that the Flask API correctly reads the new contract address:

```bash
python3 -c "
import yaml
config = yaml.safe_load(open('invest_config.yaml'))
contract_addr = config['investment']['offer_details']['contract_address']
print(f'Contract Address: {contract_addr}')
print(f'Valid format: {len(contract_addr) == 42 and contract_addr.startswith(\"0x\")}')
"
```

**Expected Output:**
```
Contract Address: 0x1234567890abcdef1234567890abcdef12345678
Valid format: True
```

---

## Step 6: Commit Changes

Once validated, commit the changes to the repository:

```bash
git add invest_config.yaml
git commit -m "Configure KarmaBond.sol contract address on Polygon"
git push origin <your-branch-name>
```

---

## Step 7: Update Additional Configuration (If Needed)

If using `configuration/financial_endpoints.yaml`, also update the contract address there:

### File Location:
```
configuration/financial_endpoints.yaml
```

### Section to Update:
```yaml
digital_bonds_offer:
  name: "Peace Platform Digital Bond Series A"
  status: "Active - Contract Deployed"
  token_symbol: "PEACEBOND"
  total_offering_limit: 5000000.00
  interest_rate_apy: 5.0
  maturity_years: 3
  wallet_address: "0x6c10692145718353070cc6cb5c21adf2073ffa1f"
  chain_network: "Polygon Mainnet"
  chain_id: 137
  stablecoin_asset: "USDC"
  min_investment_usd: 1000.00
  contract_address: "0xYourActualContractAddressHere"  # <-- Update this
  offer_start_date: "2025-12-01T00:00:00Z"
```

---

## Post-Configuration Checklist

After completing the contract address setup:

- [ ] Contract address updated in `invest_config.yaml`
- [ ] Status updated to reflect deployment
- [ ] YAML syntax validated
- [ ] Flask API integration tested
- [ ] Changes committed to repository
- [ ] Contract address updated in `configuration/financial_endpoints.yaml` (if applicable)
- [ ] On-chain monitoring configured (Phase 2)
- [ ] Contract verified on Polygonscan
- [ ] Telemetry endpoints configured to track contract events

---

## Troubleshooting

### Issue: YAML Syntax Error
**Solution:** Ensure the contract address is properly quoted and there are no trailing spaces.

### Issue: Invalid Contract Address Format
**Solution:** Verify the address is 42 characters (0x + 40 hex chars) and obtained from the actual deployment transaction.

### Issue: Flask API Not Reading New Address
**Solution:** Restart the Flask application to reload the configuration file.

---

## Reference Information

**Configuration Context:**
- **Unified Wallet:** `0x6c10692145718353070cc6cb5c21adf2073ffa1f`
- **Chain:** Polygon Mainnet (Chain ID: 137)
- **Asset:** USDC (6 decimals)
- **Offer Start:** 2025-12-01T00:00:00Z
- **Target:** 5,000,000 USDC

**Related Files:**
- `invest_config.yaml` - Primary investment configuration
- `configuration/financial_endpoints.yaml` - API endpoint configuration
- `app.py` - Flask API that reads these configurations

---

## Next Steps After Configuration

1. **Phase 2: Telemetry Configuration**
   - Configure monitoring for contract events
   - Set up alerts for contract interactions
   - Integrate with Alchemy webhooks

2. **Testing**
   - Verify contract can receive USDC
   - Test bond issuance functions
   - Validate governance controls

3. **Documentation**
   - Update README with contract address
   - Document contract ABI location
   - Create user guide for bond purchases

---

**Document Version:** 1.0  
**Last Updated:** 2025-11-04  
**Prepared for:** Ground Control / GGI / Seedbringer / Council
