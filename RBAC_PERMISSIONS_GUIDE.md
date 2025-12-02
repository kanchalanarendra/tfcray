# Azure RBAC Permissions for Role Assignments
## Why You Need User Access Administrator or Owner Role

---

## Why You Cannot Use Contributor Role

### Contributor Role - What It Does ✅
- Create/modify/delete resources (VMs, databases, storage accounts, etc.)
- Read most Azure resources
- Perform operational tasks

### Contributor Role - What It CANNOT Do ❌
- **Create or modify role assignments** ← This is the problem
- Change RBAC permissions
- Elevate other principals' access levels

**Key Principle:** Azure separates **resource management** from **access management** intentionally.

---

## Why This Separation Exists (Security Reason)

If Contributor could assign roles, a malicious actor could:

1. Get Contributor role
2. Use Terraform/CLI to assign themselves Owner role
3. Now has full subscription access
4. Delete resources, steal data, etc.

**By design:** Only Owner or User Access Administrator can manage who gets what permissions.

---

## Roles That CAN Assign Roles

### Option 1: User Access Administrator (Recommended)
- **Can:** Create/modify/delete role assignments
- **Cannot:** Create/modify/delete resources
- **Best for:** Service principals that only manage RBAC

### Option 2: Owner (Full Permissions)
- **Can:** Do everything (create resources + manage access)
- **Best for:** When you need both operational and RBAC permissions

---

## Why Your Service Principal Needs One of These

Your Terraform code does:
```hcl
resource "azurerm_role_assignment" "fsdu_storage_access" {
  scope              = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id       = azurerm_user_assigned_identity.fsdu_mid["data"].principal_id
}
```

This operation:
- **Creates a new role assignment** in Azure
- Requires `Microsoft.Authorization/roleAssignments/write` permission
- Only Owner or User Access Administrator have this permission
- Contributor role does NOT have this permission

---

## What Happens If You Give User Access Administrator

Your service principal will be able to:
✅ Create role assignments (for managed identities, users, groups)
✅ Modify existing role assignments
✅ Delete role assignments
✅ Run Terraform with role assignment resources

Your service principal will NOT be able to:
❌ Create/delete resources (storage, VMs, databases, etc.)
❌ Modify resource settings
❌ Access data in resources

---

## What Happens If You Give Owner

Your service principal will be able to:
✅ Do everything User Access Administrator can do
✅ Create/modify/delete resources
✅ Access data in resources
✅ Full subscription/resource group control

**Risk:** Too much power in one service principal

---

## Visual Comparison

| Action | Contributor | User Access Admin | Owner |
|--------|------------|-------------------|-------|
| Create storage account | ✅ | ❌ | ✅ |
| Delete VM | ✅ | ❌ | ✅ |
| Assign Storage role | ❌ | ✅ | ✅ |
| Create role assignment | ❌ | ✅ | ✅ |
| Modify role assignment | ❌ | ✅ | ✅ |

---

## Solution for Your Project

**Step 1:** Request this from your Azure admin:
```
Please grant "User Access Administrator" role to:
- Service Principal: ca68a18e-5364-446c-8f12-b1011ccd14c4
- Scope: Subscription 3bc8f069-65c7-4d08-b8de-534c20e56c38
```

**Step 2:** Once granted, run:
```powershell
terraform apply -var-file="environments/dev/dev.tfvars" -auto-approve
```

**Done!** Role assignments will be created automatically.

---

## Alternative: Manual Role Assignment (No Permission Upgrade Needed)

If you don't want to grant permissions to your service principal, an admin can manually assign roles:

```powershell
# Admin runs these commands (requires Owner role)

az role assignment create `
  --assignee "d22963dd-6525-45de-8068-dfb5fddd1014" `
  --role "Storage Blob Data Contributor" `
  --scope "/subscriptions/3bc8f069-65c7-4d08-b8de-534c20e56c38/resourceGroups/rg-fsdu-storage-dev/providers/Microsoft.Storage/storageAccounts/storgaefsdudev"

az role assignment create `
  --assignee "d22963dd-6525-45de-8068-dfb5fddd1014" `
  --role "Cosmos DB Account Reader Role" `
  --scope "/subscriptions/3bc8f069-65c7-4d08-b8de-534c20e56c38/resourceGroups/rg-fsdu-storage-dev/providers/Microsoft.DocumentDB/databaseAccounts/cosmos-fsdu-dev"
```

Then comment out these lines in `Modules/managedidentity/main.tf`:
```hcl
# resource "azurerm_role_assignment" "fsdu_storage_access" { ... }
# resource "azurerm_role_assignment" "fsdu_cosmos_access" { ... }
```

---

## Summary

| Need | Role | Why |
|------|------|-----|
| Terraform to create role assignments | User Access Administrator or Owner | Only these roles have `Microsoft.Authorization/roleAssignments/write` |
| Contributor is NOT enough | - | Designed to only manage resources, not access control |
| Keep service principal minimal | User Access Administrator | Grants only RBAC permissions, not resource access |
| Maximum flexibility | Owner | Can manage both resources and access, but too much power |
