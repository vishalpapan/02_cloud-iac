# Test-4-Provisioner - Infrastructure Provisioning with Application Deployment

## Objective
Create AWS infrastructure and deploy a Python Flask application automatically.

## Deployment Flow

### Scenario
- Developer creates `app.py` (Flask application) in repository
- Automate testing by provisioning infrastructure and deploying application

### Infrastructure Components Created
1. **VPC** - Virtual Private Cloud
2. **Public Subnet** - For internet-accessible resources
3. **Key Pair** - For EC2 SSH access
4. **Route Table** - Route all traffic to Internet Gateway
5. **Security Group** - Network access rules
6. **EC2 Instance** - Application server
7. **Public IP** - For external access

### Provisioning Steps
1. Terraform creates all AWS infrastructure
2. Provisioner runs commands on EC2 instance
3. Application deployed and started
4. Public IP displayed for access

### Codespaces Limitation
- Cannot get public IP directly in GitHub Codespaces
- Need to open security group for all IPs (0.0.0.0/0) for testing
- Terraform provisions and runs deployment commands automatically

### Key Files
- `main.tf` - Infrastructure definition
- `app.py` - Python Flask application
- `variables.tf` - Input variables
- `terraform.tfvars` - Variable values