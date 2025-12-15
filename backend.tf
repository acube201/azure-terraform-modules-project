terraform{
    backend "azurerm"{
        resource_group_name  = "tfstate-rg"
        storage_account_name =  "tfterraformstate1234"
        container_name       = "tfstates2"
         
       // key                  = "dev/terraform.tfstate" 
       
    }
}
 

 