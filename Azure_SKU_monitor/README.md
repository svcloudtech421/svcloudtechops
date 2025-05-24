# Azure VM SKU Capacity Monitoring

This repository provides a practical script and guide to monitor VM SKU availability in Azure, especially useful for planning VM SKU uplift or scale operations. The script leverages Azure SDK for Python and Managed Identity authentication.

---

## 🚀 Purpose

Azure VM SKUs (Virtual Machine Sizes) may not be available in all regions, availability zones, or due to capacity limits. Before performing SKU uplift (resizing a VM), it's critical to:
- Check availability of the desired SKU
- Prevent downtime or deployment failures
- Automate alerts if SKU is not available

This tool helps you proactively monitor SKU capacity and avoid runtime issues.

---

## 📁 Contents
- `vm_sku_capacity_monitor.py` — Python script to monitor SKU capacity
- `requirements.txt` — Required Python libraries
- `README.md` — This file

---

## 🧰 Prerequisites
- Python 3.6 or later
- Azure subscription
- Azure CLI configured
- Managed Identity enabled (if running from a VM)
- Required roles: `Reader` or `Contributor` on the subscription

---

## 📦 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/<your-org>/azure-vm-sku-monitor.git
   cd azure-vm-sku-monitor
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

---

## 🏃 Usage

### Run Script
```bash
python3 vm_sku_capacity_monitor.py --region <region> --sku <sku-name> --subscription-id <subscription-id>
```

Example:
```bash
python3 vm_sku_capacity_monitor.py --region westeurope --sku Standard_D16ds_v5 --subscription-id 6530f7de-a552-4135-9564-bbd59b7ccf8d
```

### Arguments
- `--region` (required): Azure region (e.g., `westeurope`, `eastus2`)
- `--sku` (required): VM size to monitor (e.g., `Standard_D16ds_v5`)
- `--subscription-id` (optional): Azure subscription ID (auto-detected with Managed Identity if not provided)

---

## ⚠️ Common Issues During SKU Uplift

### 1. Capacity Not Available in Region
- **Error**: `Capacity being exceeded in region`
- **Fix**:
  - Run this monitor script before resizing
  - Switch zone/region if possible

### 2. Quota Limit Reached
- **Error**: `Quota of cores in region has been reached`
- **Fix**:
  - Check with `az vm list-usage --location <region>`
  - Request quota increase via Azure Support

### 3. Permissions
- **Error**: `AuthorizationFailed: Microsoft.Compute/skus/read`
- **Fix**:
  - Assign required RBAC role (e.g., Contributor)

### 4. VM State Issues
- **Error**: `Cannot resize a VM when it is in a deallocated state`
- **Fix**:
  - Deallocate VM properly before resizing

### 5. Availability Set/Zone Compatibility
- **Error**: `SKU not supported in availability set`
- **Fix**:
  - Check if SKU supports zones
  - Consider redeploying

### 6. Disk Incompatibility
- **Error**: Related to Ultra/ephemeral disks
- **Fix**:
  - Check disk compatibility for target SKU

---

## ✅ Best Practices
| Step | Action |
|------|--------|
| 🔍 1 | Run SKU monitoring before resize |
| 📊 2 | Check quota in target region |
| 🛡️ 3 | Ensure correct RBAC roles |
| 🧘 4 | Deallocate VM before resizing |
| 📚 5 | Check availability sets/zones compatibility |
| 🧪 6 | Pilot test before production rollout |

---

## 📌 Resources
- [Azure VM Sizes](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes)
- [Azure CLI - VM SKUs](https://learn.microsoft.com/en-us/cli/azure/vm/)
- [Azure Quota Increase](https://learn.microsoft.com/en-us/azure/quotas/)
- [Original Blog Post](https://techcommunity.microsoft.com/blog/startupsatmicrosoftblog/a-practical-guide-to-azure-vm-sku-capacity-monitoring/4415773)

---

## 🧾 License
MIT License

---

## 🙋 Support
Please raise issues or submit PRs for improvements.

---

> Created by the Azure Cloud Engineering Team
