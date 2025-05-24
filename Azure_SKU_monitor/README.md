1. Capacity Not Available in the Region
Error Message: Operation could not be completed as it results in capacity being exceeded in the region.

Cause: The requested SKU (e.g., Standard_D16ds_v5) is not available in the target availability zone or region due to high demand or reservation.

Resolution:

Run a VM SKU availability monitor script before resizing (like the one you're using).

Try a different availability zone or even a different region.

Use az vm list-skus to check availability:

bash
Copy
Edit
az vm list-skus --location westeurope --output table
2. Quota Limit Reached
Error Message: Operation could not be completed because your quota of cores in region has been reached.

Cause: You’ve hit your regional vCPU quota.

Resolution:

View quota:

bash
Copy
Edit
az vm list-usage --location westeurope
Request a quota increase:

bash
Copy
Edit
az support ticket create --problem-class "Quota" --service "Compute" --title "Increase vCPU quota"
3. Permission Errors
Error Message: The client does not have authorization to perform action Microsoft.Compute/virtualMachines/write

Cause: The identity (User or Managed Identity) does not have the correct RBAC role to perform the resize operation or check SKU availability.

Resolution:

Assign appropriate role (e.g., Contributor, Virtual Machine Contributor):

bash
Copy
Edit
az role assignment create --assignee <principalId> --role "Contributor" --scope /subscriptions/<subId>
4. VM is in an Unsupported State
Error Message: Cannot resize a VM when it is in a deallocated state.

Cause: You are trying to resize when the VM is running or already deallocated incorrectly.

Resolution:

Properly deallocate before resizing:

bash
Copy
Edit
az vm deallocate --name <vm-name> --resource-group <rg>
5. Availability Set or Zone Incompatibility
Error Message: The VM SKU is not supported in the availability set or zone.

Cause: Some SKUs are zone-specific or not supported in availability sets.

Resolution:

Check if the new SKU supports availability zones or sets.

Consider redeploying the VM outside of the availability set.

6. Ephemeral OS Disk or Ultra Disk Restrictions
Cause: Some larger SKUs or older VMs use disks incompatible with new SKUs.

Resolution:

Validate disk compatibility using the Azure VM documentation.

Change disk type if needed.

✅ Best Practices for SKU Uplift
Step	Action
🔍 1	Run a SKU availability monitor for your target region and zone
📊 2	Check your quota with az vm list-usage
🛡️ 3	Ensure proper RBAC roles are assigned
🧘 4	Deallocate the VM before resizing
📚 5	Cross-check compatibility with availability sets/zones
🧪 6	Test the resize in a non-production environment

🛠️ Tools to Help
Azure CLI:

bash
Copy
Edit
az vm list-skus --location westeurope --size Standard_D16ds_v5
Azure Portal: Check SKU availability using the VM size selector.

Azure Resource Graph: Query SKU availability across all regions.

Monitoring Script: Automate SKU availability checks daily or weekly.