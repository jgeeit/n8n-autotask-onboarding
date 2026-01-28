# Offboarding Workflows

This directory contains workflows for automating employee offboarding processes.

## Workflows

### employee-exit.json
Main orchestrator workflow that manages the complete offboarding process.

**Status**: 🚧 To be created  
**Priority**: High  
**Description**: Triggered by termination date in Autotask, coordinates all offboarding tasks with timeline enforcement.

---

### access-revocation.json
Disables all user accounts and access permissions.

**Status**: 🚧 To be created  
**Priority**: High  
**Description**: Systematically revokes access to AD, email, VPN, applications, and physical access.

---

### equipment-recovery.json
Manages company equipment collection and processing.

**Status**: 🚧 To be created  
**Priority**: Medium  
**Description**: Creates collection tickets, tracks returned equipment, updates asset management.

---

### data-backup.json
Archives employee data before account deletion.

**Status**: 🚧 To be created  
**Priority**: High  
**Description**: Backs up files, email, and documents to designated archive locations.

---

### final-billing-review.json
Reviews time entries and project assignments.

**Status**: 🚧 To be created  
**Priority**: Medium  
**Description**: Queries Autotask for open items, generates reports for manager approval.

---

### exit-checklist.json
Creates and tracks exit checklist completion.

**Status**: 🚧 To be created  
**Priority**: Low  
**Description**: Generates checklist ticket, tracks completion, sends reminders.

---

## Creating Workflows

To create these workflows:

1. Design workflow in n8n UI
2. Test with sample data in sandbox
3. Export as JSON
4. Place in this directory
5. Update this README with status

## Security Considerations

Offboarding workflows handle sensitive operations:
- Ensure proper authorization
- Log all access revocations
- Verify data backup completion
- Follow compliance requirements
- Document all actions in Autotask

## Workflow Standards

- Implement comprehensive error handling
- Include security audit logging
- Use time-based scheduling
- Add manager approval steps
- Test thoroughly before production use
