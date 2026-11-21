# Laboratório Azure IaC & Módulos Reutilizáveis (`AZ-104 Labs`)

Repositório dedicado ao desenvolvimento de **módulos reutilizáveis em Terraform** e laboratórios práticos voltados aos domínios técnicos da certificação **Microsoft Certified: Azure Administrator Associate (AZ-104)**.

---

## Objetivos Técnicos do Repositório

* **Modularização de Código:** Criação de blocos padronizados para provisionamento rápido e consistente de recursos no Azure (*Compute, Networking e Storage*).
* **Automação de Infraestrutura:** Substituição de deploys manuais via Portal por pipelines declarativos e versionados em Git.
* **Prática Direcionada AZ-104:** Validação prática de conceitos de redes virtuais, regras de segurança (NSG), armazenamento e governança de recursos.

---

## Tecnologias Utilizadas

* **Microsoft Azure** (VNets, Subnets, NSGs, VMs, Storage Accounts, Resource Groups)
* **Terraform (HCL)** & **Azure CLI**
* **Git / GitHub**

---

## Fluxo de Execução

```bash
# 1. Login no Azure
az login

# 2. Inicialização dos providers e módulos
terraform init

# 3. Validação e visualização do plano
terraform validate
terraform plan

# 4. Criação dos recursos
terraform apply
```

---

## Autor

**Bruno Cardoso Verchev** — Analista de Cloud Azure & Infraestrutura Híbrida  
* **Certificações:** Microsoft Certified: Azure Fundamentals (AZ-900) | Em preparação final para **AZ-104**  
* **LinkedIn:** https://www.linkedin.com/in/brunoverchev
