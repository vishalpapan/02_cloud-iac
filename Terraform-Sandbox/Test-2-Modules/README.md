# Test-2-Modules - Terraform Modules

## Key Learnings

### Module Structure
When creating modules, you need to:
1. Specify the `source` path to the module
2. Pass values for all variables declared in the module's `main.tf`

### Variable Behavior
- **Variables in module:** If `var.variable_name` is used in module's `main.tf`, you MUST pass the value from the calling `main.tf`
- **Hardcoded values:** If values are hardcoded in the module's `main.tf`, you don't need to specify them in the calling file
- **Example:** `key_name` specified in module's `main.tf` but not accepted in secondary `main.tf` because it's hardcoded

### Output Files
- `output.tf` files in the modules folder are NOT automatically considered
- The calling directory must have its own `output.tf` to display module outputs
- Module outputs need to be explicitly referenced in the root-level output file

### Best Practices
- Keep module variables minimal and required
- Use outputs to expose important resource attributes
- Document module requirements clearly