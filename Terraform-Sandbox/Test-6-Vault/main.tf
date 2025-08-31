provider "aws" {
    region = "us-east-1"
}
  
provider "vault" {
    address = "http://54.83.232.130:8200"
    skip_child_token = true

    auth_login {
        path = "auth/approle/login"


        parameters = {
            role_id = "10608e94-3209-5bac-1389-04a114853628"
            secret_id = "b241bc07-a630-7f3d-5b0e-f2257d1d035b"
        }
    }
}

data "vault_kv_secret_subkeys_v2" "instancetag" {
    
    /* get from vault ui : Secrets-kv-kv */
    mount = "kv"
    name = "kv"
  
}

resource "aws_instance" "test-instance" {
    ami = "ami-0360c520857e3138f"
    instance_type = "t3a.micro"
    subnet_id = "subnet-0fde1949d61f6d9c9"
    security_groups = ["sg-0b698d1fe325d2c3a"]

    tags = {
      Name = "test-vault"
      Secrets = data.vault_kv_secret_subkeys_v2.instancetag.data["username"]
    }
}