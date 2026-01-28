# Onboarding Workflows

This directory contains workflows for automating employee onboarding processes.

## Workflows

### new-hire-setup.json
Main orchestrator workflow that coordinates the entire onboarding process.

**Status**: 🚧 To be created  
**Priority**: High  
**Description**: Receives webhook/manual trigger with new hire information and orchestrates all onboarding sub-workflows.

---

### autotask-contact-creation.json
Creates contact and resource records in Autotask PSA.

**Status**: 🚧 To be created  
**Priority**: High  
**Description**: Validates data, checks for duplicates, creates contact, and optionally creates resource.

---

### email-setup.json
Provisions email accounts and mailbox settings.

**Status**: 🚧 To be created  
**Priority**: Medium  
**Description**: Integrates with Microsoft 365 or Google Workspace to create email accounts.

---

### ad-account.json
Creates Active Directory user accounts.

**Status**: 🚧 To be created  
**Priority**: Medium  
**Description**: LDAP integration for AD account creation and group assignment.

---

### equipment-request.json
Creates equipment provisioning tickets.

**Status**: 🚧 To be created  
**Priority**: Low  
**Description**: Generates Autotask tickets for hardware setup and delivery.

---

### notification-manager.json
Handles all onboarding-related notifications.

**Status**: 🚧 To be created  
**Priority**: Medium  
**Description**: Template-based email notifications to stakeholders.

---

## Creating Workflows

To create these workflows:

1. Design workflow in n8n UI
2. Test with sample data
3. Export as JSON
4. Place in this directory
5. Update this README with status

## Workflow Standards

- Include error handling
- Add descriptive node names
- Document complex logic
- Use environment variables
- Test with multiple scenarios
