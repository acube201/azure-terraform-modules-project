# Azure Terraform Infrastructure — Dev/Prod Safe Design

![Static Badge](https://img.shields.io/badge/Terraform%20-v1.13.3-%20purple)
![Static Badge](https://img.shields.io/badge/Azure-%20East%20us%202-blue)


## Overview

This repository demonstrates a production-oriented Terraform architecture on Azure, with an emphasis on:

Remote state management

Environment isolation

Operational safety

Guardrails against accidental destruction

Clear and repeatable workflows

The focus of this project is how infrastructure is safely operated over time, not just how resources are deployed.

## Architecture Summary

Cloud Provider: Microsoft Azure

Infrastructure as Code: Terraform

State Backend: Azure Blob Storage

Environments: dev, prod

Modules: Networking, Virtual Machine

Repository Structure
.
├── backend.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── network/
│   └── vm/
└── README.md


The root configuration orchestrates environment behavior.
Modules are reusable, environment-agnostic building blocks.

## Remote State Design
Rationale

Terraform state is critical operational data.
Storing state locally introduces risk around:

Concurrent usage

Environment confusion

Accidental overwrites

Recovery

This project uses an Azure Storage Account backend to provide:

Centralized state

Automatic state locking

Durability and consistency

Safe multi-environment operation

Backend Configuration
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfterraformstate1234"
    container_name       = "tfstate2"
  }
}


The backend configuration is intentionally static.
Environment selection does not occur here.

## Environment Isolation Strategy
State-Based Separation

Environments are isolated using separate backend state keys, not Terraform workspaces:

dev/terraform.tfstate
prod/terraform.tfstate


Each environment:

Has an independent state file

Is fully isolated from the other

Cannot modify or destroy resources outside its own state

This approach mirrors common enterprise Terraform practices.

Environment Switching

Environment context is selected explicitly during initialization.

Custom shell commands are used to avoid ambiguity:

tfdev   → initializes Terraform with dev state
tfprod  → initializes Terraform with prod state


This ensures:

Environment intent is always clear

Production access is deliberate

Accidental context switching is avoided

## Guardrails and Safety Controls
Terraform Lifecycle Protection

Critical resources include a lifecycle rule:

```hcl
lifecycle {
  prevent_destroy = true
}


This instructs Terraform to refuse destructive actions, including:

terraform destroy

Resource replacement during refactors

Misconfigured automation pipelines

This guardrail protects against errors originating from Terraform itself.

Azure Resource Locks (Platform-Level Protection)

In a full production deployment, Azure CanNotDelete locks would also be applied at the resource group or critical resource level.

These locks prevent deletion from:

Azure Portal

Azure CLI

Scripts or automation outside Terraform

Terraform lifecycle rules protect code-driven actions.
Azure locks protect the cloud platform directly.

Defense-in-Depth Model

This design uses multiple layers of protection:

State Isolation
Dev and prod cannot affect each other

Explicit Environment Selection
Environment switching is intentional

Terraform Guardrails
Destructive plans are blocked

Azure Locks (optional)
Platform-level deletion protection

The system is designed with the assumption that human error is inevitable.

## Operational Workflow

A typical workflow follows this pattern:

```text
tfdev
terraform plan
terraform apply

```text
tfprod
terraform plan
(terraform apply after review)


Key principle:
Production changes are never implicit.

## Design Principles Demonstrated

Remote state is mandatory for safe Terraform usage

Environment isolation should be state-based
```md
Guardrails should be enforced by systems rather than operator memory

Terraform should be operated deliberately, not interactively

Safety and clarity take priority over convenience

## Notes

This repository intentionally minimizes unnecessary resource creation during learning and design phases.
The emphasis is on correct architecture, operational safety, and repeatability, rather than cost or portal artifacts.

## Summary

This project demonstrates Terraform used as an operational system, not just a deployment tool.

The design prioritizes:

Predictability

Safety

Maintainability

Real-world operational practices

Final guiding principle

Infrastructure should be easy to operate correctly and hard to operate incorrectly.