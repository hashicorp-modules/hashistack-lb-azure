# Hashistack Load Balancer for Azure, Terraform Module
_Provisions resources for a load balancer for the hashistack in Azure._

### Setting up an Azure Service Principal for Usage with this Module

1. In order to perform the steps in this guide, you will need to have an Azure subscription for which you can create Service Principals as well as network and compute resources. You can create a free Azure account [here](https://azure.microsoft.com/en-us/free/).
2. Certain steps will require entering commands through the Azure CLI. You can find out more about installing it [here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli).
3. Create Azure API Credentials: set up the main Service Principal that will be used for Terraform:
    * [https://www.terraform.io/docs/providers/azurerm/index.html]()
    * The above steps will create a Service Principal with the [Contributor](https://docs.microsoft.com/en-us/azure/active-directory/role-based-access-built-in-roles#contributor) role in your Azure subscription

4. `export` environment variables for the main (Terraform) Service Principal. For example, create an `env.sh` file with the following values (obtained from step `1` above):

    ```
    # Exporting variables in both cases just in case, no pun intended
    export ARM_SUBSCRIPTION_ID="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
    export ARM_CLIENT_ID="bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
    export ARM_CLIENT_SECRET="cccccccc-cccc-cccc-cccc-cccccccccccc"
    export ARM_TENANT_ID="dddddddd-dddd-dddd-dddd-dddddddddddd"
    export subscription_id="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
    export client_id="bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
    export client_secret="cccccccc-cccc-cccc-cccc-cccccccccccc"
    ```

5. Finally, create a read-only Azure Service Principal (using the Azure CLI) that will be used to perform the Consul auto-join (make note of these values as you will use them later in this guide):

    ```
    $ az ad sp create-for-rbac --role="Reader" --scopes="/subscriptions/[YOUR_SUBSCRIPTION_ID]"
    ```


## Input Variables
- `name`: The name to use on all of the resources, in this case it will also be the Azure Resource Group name.
- `azure_region`: The Azure Region to use for all resources (ex: westus, eastus).
- `azure_nat_pool_count`: The number of nat pools to spin up for the load balancer.

## Outputs
- `backend_address_pool_id`: The resource id of the backend address pool created for the load balancer.
- `inbound_nat_pool_id`: The inbound NAT pool ID created for the load balancer.
- `public_ip_address`: The load balancer public IP address.
- `public_fqdn`: The load balancer public fully qualified domain name.

## Module Dependencies

_None_

## Authors

HashiCorp Solutions Engineering Team.

## License

Mozilla Public License Version 2.0. See LICENSE for full details.
