variable "resource_group_name" {
  type        = string
  default     = "rg-laboratorio-v4" # Nome inédito para limpar o cache da nuvem
  description = "Nome do Grupo de Recursos principal do laboratório"
}

variable "location" {
  type        = string
  default     = "eastus2"
  description = "Região do Azure onde a infraestrutura será implantada"
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v5"
  description = "Tamanho e família da Máquina Virtual Windows Server"
}

variable "vm_name" {
  type        = string
  default     = "srvwin01"
  description = "Nome do servidor Windows no Azure"
}
variable "admin_username" {
  type        = string
  default     = "azureadmin"
  description = "Usuario administrador local da Maquina Virtual"
}
variable "admin_password" {
  type        = string
  sensitive   = true
  description = "Senha do administrador local da VM (fornecida via TF_VAR_admin_password ou prompt)"
}
