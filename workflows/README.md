# Workflow Directory

This directory contains all n8n workflow definitions for the Autotask onboarding and offboarding automation.

## 📂 Directory Structure

```
workflows/
├── onboarding/          # Employee onboarding workflows
└── offboarding/         # Employee offboarding workflows
```

## 🔄 Workflow Overview

### Onboarding Workflows

#### 1. new-hire-setup.json (Main Orchestrator)
**Purpose**: Coordinates the entire onboarding process  
**Trigger**: Webhook (POST) or Manual  
**Inputs**:
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@example.com",
  "title": "IT Support Technician",
  "department": "IT",
  "startDate": "2025-02-01",
  "manager": "jane.smith@example.com"
}
```
**Outputs**:
- Autotask contact ID
- User account details
- Equipment request ticket number
- Status notifications

**Key Features**:
- Parallel execution of sub-workflows
- Progress tracking
- Error aggregation and reporting
- Completion notifications to HR and manager

---

#### 2. autotask-contact-creation.json
**Purpose**: Creates contact and resource records in Autotask  
**Dependencies**: Autotask API credentials  
**Process**:
1. Validate input data
2. Check for existing contact (by email)
3. Create/update contact
4. Create resource if applicable
5. Assign to default groups
6. Return contact and resource IDs

---

#### 3. access-provisioning.json
**Purpose**: Sets up user accounts and access permissions  
**Integrations**:
- Active Directory (LDAP)
- Microsoft 365 (Graph API)
- VPN system
- Other applications

**Process**:
1. Create AD account
2. Generate temporary password
3. Create email mailbox
4. Set up MFA
5. Assign application licenses
6. Configure VPN access
7. Send credentials (securely)

---

#### 4. notification-manager.json
**Purpose**: Handles all onboarding notifications  
**Notification Types**:
- Welcome email to new hire
- Manager notification
- HR confirmation
- IT team alerts

**Features**:
- Template-based emails
- Dynamic content insertion
- Error notifications
- Digest notifications for batch operations

---

### Offboarding Workflows

#### 1. employee-exit.json (Main Orchestrator)
**Purpose**: Manages the complete offboarding process  
**Trigger**: Webhook (termination date set) or Manual  
**Inputs**:
```json
{
  "contactId": "12345",
  "email": "departing.employee@example.com",
  "terminationDate": "2025-01-31",
  "reason": "resignation",
  "manager": "jane.smith@example.com"
}
```

**Timeline**:
- T-7 days: Pre-departure tasks
- T-0 days: Account deactivation
- T+7 days: Final cleanup and reporting

---

#### 2. access-revocation.json
**Purpose**: Disables all user accounts and access  
**Process**:
1. Disable AD account
2. Revoke email access or convert to shared mailbox
3. Disable VPN
4. Remove from all groups
5. Revoke application licenses
6. Disable building access
7. Document revocation in Autotask

---

#### 3. final-billing-review.json
**Purpose**: Reviews time entries and project assignments  
**Process**:
1. Query Autotask for open time entries
2. Query for assigned tickets
3. Query for project assignments
4. Generate report for manager approval
5. Create handoff tickets as needed

---

#### 4. exit-checklist.json
**Purpose**: Creates and tracks exit checklist  
**Process**:
1. Create checklist ticket in Autotask
2. Populate with standard tasks
3. Assign to manager and IT
4. Track completion
5. Send reminders for incomplete items
6. Generate final report

---

## 🚀 Importing Workflows

### Method 1: Via n8n UI
1. Open n8n in browser
2. Click "Workflows" → "Import from File"
3. Select workflow JSON file
4. Configure credentials
5. Activate workflow

### Method 2: Using Import Script
```bash
chmod +x scripts/import-workflows.sh
./scripts/import-workflows.sh
```

### Method 3: Via n8n API
```bash
curl -X POST http://localhost:5678/api/v1/workflows \
  -H "Content-Type: application/json" \
  -d @workflows/onboarding/new-hire-setup.json
```

## ⚙️ Configuration Requirements

Before importing workflows, ensure you have configured:

### Required Credentials in n8n
- **Autotask API** - PSA integration
- **SMTP** - Email notifications
- **Active Directory** - User provisioning (if applicable)
- **Microsoft Graph** - Office 365 integration (if applicable)

### Environment Variables
Set these in n8n or your `.env` file:
- `AUTOTASK_API_USER`
- `AUTOTASK_API_KEY`
- `AUTOTASK_SERVER_URL`
- `DEFAULT_MANAGER_EMAIL`
- `HR_EMAIL`
- `IT_EMAIL`

## 🧪 Testing Workflows

### Test Mode
Each workflow can be tested with sample data:

1. Open workflow in n8n
2. Click "Execute Workflow"
3. Provide test data
4. Review execution log
5. Verify results in Autotask sandbox

### Test Data
Use the Autotask sandbox instance with test contacts:
```json
{
  "firstName": "Test",
  "lastName": "User",
  "email": "test.user@example-sandbox.com",
  "title": "Test Position",
  "department": "Test Department",
  "startDate": "2025-02-01"
}
```

## 🔧 Customization

### Modifying Workflows
To customize workflows for your organization:

1. **Update Field Mappings**
   - Edit `config/autotask-mappings.json`
   - Match your Autotask schema

2. **Customize Email Templates**
   - Edit `config/email-templates.json`
   - Add your branding and messaging

3. **Adjust Business Logic**
   - Clone workflow in n8n
   - Modify nodes as needed
   - Test thoroughly
   - Export and commit changes

### Adding New Steps
To add a new step to a workflow:

1. Open workflow in n8n editor
2. Add new node(s)
3. Connect to appropriate point in flow
4. Configure node settings
5. Test with sample data
6. Update workflow documentation
7. Export and commit

## 📋 Workflow Dependencies

### Common Dependencies
All workflows require:
- n8n version 1.0.0+
- Autotask API access
- SMTP server for notifications

### Optional Dependencies
Based on your integrations:
- Active Directory access
- Microsoft Graph API credentials
- Slack/Teams webhooks
- Custom application APIs

## 🐛 Troubleshooting

### Workflow Won't Import
- Verify JSON is valid
- Check n8n version compatibility
- Ensure required credentials exist
- Review error logs

### Workflow Fails on Execution
- Check credential configuration
- Verify API connectivity
- Review input data format
- Check Autotask field IDs
- Review execution logs

### Partial Execution
- Review error trigger configuration
- Check conditional node logic
- Verify data transformations
- Test with various input scenarios

## 📊 Monitoring

### Execution History
View workflow executions in n8n:
1. Navigate to "Executions"
2. Filter by workflow name
3. Review success/failure rates
4. Investigate failed executions

### Notifications
Configure alerts for:
- Workflow failures
- API errors
- Timeout issues
- Missing required data

## 🔄 Workflow Updates

### Version Control
- Tag workflow versions in Git
- Document changes in commit messages
- Maintain CHANGELOG.md
- Test before deploying to production

### Deployment Process
1. Test in development environment
2. Export updated workflow
3. Commit to version control
4. Review changes in PR
5. Import to production n8n instance
6. Verify with test execution
7. Monitor for issues

## 📚 Additional Resources

- [n8n Documentation](https://docs.n8n.io)
- [Autotask API Reference](https://www.autotask.com/help/api)
- [Project README](../README.md)
- [Troubleshooting Guide](../docs/troubleshooting.md)

## 🤝 Contributing

When contributing new workflows:
1. Follow naming conventions
2. Include comprehensive error handling
3. Add workflow documentation
4. Test thoroughly
5. Submit PR with description

See [CONTRIBUTING.md](../CONTRIBUTING.md) for full guidelines.

---

**Note**: These workflow files are templates. Customize them to match your organization's specific requirements and Autotask configuration.
