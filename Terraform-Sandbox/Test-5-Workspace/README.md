# Test-5-Workspace - Managing Environments with Workspaces

## Problem Solved
**Reusable modules** for different teams and environments without infrastructure conflicts.

## Scenario
**XYZ Team Approach for Different Environments:**

### The Challenge
- **Dev Environment:** Team tests with specific instance types in `main.tf` and `tfvars`
- **Staging/Prod:** Different teams need different configurations
- **Problem:** Terraform tries to override state file, destroying test environment to create dev environment
- **Expected Behavior:** Create separate infrastructure for dev, test, staging environments

## Solution: Terraform Workspaces

### Workspace Benefits
- Separate state files for each environment
- Same Terraform code, different configurations
- No infrastructure conflicts between environments

### Usage Commands
```bash
# Create and switch to different environments
terraform workspace new dev
terraform workspace new staging  
terraform workspace new prod

# Apply with specific variable files
terraform apply -var-file=dev.tfvars
terraform apply -var-file=stage.tfvars
terraform apply -var-file=prod.tfvars

# List workspaces
terraform workspace list

# Switch workspace
terraform workspace select dev
```

### File Structure
- `main.tf` - Common infrastructure code
- `variables.tf` - Variable declarations
- `dev.tfvars` - Development environment values
- `stage.tfvars` - Staging environment values
- `prod.tfvars` - Production environment values

### State File Management
- Each workspace maintains separate state file
- Located in `terraform.tfstate.d/workspace_name/`
- Prevents environment conflicts and accidental overwrites