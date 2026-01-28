# Project Structure

This document describes the organization of the n8n-Autotask Onboarding project.

## Directory Layout

```
n8n-autotask-onboarding/
│
├── .github/                          # GitHub-specific files
│   ├── ISSUE_TEMPLATE/               # Issue templates
│   │   ├── onboarding.md             # Employee onboarding tracking
│   │   ├── offboarding.md            # Employee offboarding tracking
│   │   ├── bug_report.md             # Bug report template
│   │   └── feature_request.md        # Feature request template
│   └── workflows/                    # GitHub Actions (future)
│       └── backup-workflows.yml      # Automated workflow backup
│
├── workflows/                        # n8n workflow definitions
│   ├── onboarding/                   # Onboarding workflows
│   │   ├── new-hire-setup.json       # Main onboarding orchestrator
│   │   ├── autotask-contact.json     # Contact creation workflow
│   │   ├── email-setup.json          # Email account provisioning
│   │   ├── ad-account.json           # Active Directory setup
│   │   ├── equipment-request.json    # Hardware provisioning
│   │   └── notifications.json        # Notification workflows
│   │
│   └── offboarding/                  # Offboarding workflows
│       ├── employee-exit.json        # Main offboarding orchestrator
│       ├── access-revocation.json    # Account deactivation
│       ├── equipment-recovery.json   # Asset collection
│       ├── data-backup.json          # Data archival
│       └── final-tasks.json          # Exit checklist
│
├── config/                           # Configuration files
│   ├── autotask-mappings.json        # Autotask field mappings
│   ├── email-templates.json          # Email notification templates
│   ├── default-settings.json         # Default workflow settings
│   └── webhook-config.json           # Webhook configurations
│
├── docs/                             # Documentation
│   ├── workflow-diagrams/            # Visual workflow documentation
│   │   ├── onboarding-flow.png       # Onboarding process diagram
│   │   └── offboarding-flow.png      # Offboarding process diagram
│   │
│   ├── api-documentation.md          # Autotask API reference
│   ├── troubleshooting.md            # Common issues and solutions
│   ├── deployment-guide.md           # Production deployment guide
│   └── changelog.md                  # Version history
│
├── scripts/                          # Utility scripts
│   ├── import-workflows.sh           # Import all workflows to n8n
│   ├── export-workflows.sh           # Export/backup workflows
│   ├── test-connection.js            # Test Autotask connectivity
│   ├── validate-config.js            # Validate configuration files
│   └── setup-credentials.sh          # Initial credential setup
│
├── .env.example                      # Environment variable template
├── .gitignore                        # Git ignore patterns
├── LICENSE                           # MIT License
├── README.md                         # Main project documentation
└── CONTRIBUTING.md                   # Contribution guidelines
```

## File Descriptions

### Workflow Files (`.json`)
Each workflow file is an n8n workflow definition that can be imported directly into n8n. These files contain:
- Node configurations
- Connections between nodes
- Workflow settings
- Trigger configurations

**Important**: Never commit credentials or API keys in workflow files. Use n8n's credential system.

### Configuration Files

#### `autotask-mappings.json`
Maps internal field names to Autotask API field IDs. Update this when:
- Adding new fields to track
- Customizing Autotask schema
- Adding custom user-defined fields

#### `email-templates.json`
Contains all email templates with placeholders. Customize for:
- Company branding
- Specific notification requirements
- Different languages or regions

#### `default-settings.json`
Default values for workflows, including:
- Queue assignments
- Priority levels
- Timeout values
- Retry configurations

### Documentation Files

#### `README.md`
Primary documentation covering:
- Project overview
- Installation instructions
- Configuration guide
- Usage examples

#### `docs/api-documentation.md`
Autotask API-specific documentation:
- Common endpoints
- Field reference
- Query examples
- Rate limiting notes

#### `docs/troubleshooting.md`
Solutions for common issues:
- Authentication problems
- API errors
- Workflow failures
- Configuration issues

### Scripts Directory

#### `import-workflows.sh`
Bash script to import all workflows to n8n via API:
```bash
./scripts/import-workflows.sh
```

#### `export-workflows.sh`
Backs up current workflows from n8n:
```bash
./scripts/export-workflows.sh
```

#### `test-connection.js`
Node.js script to verify Autotask API connectivity:
```bash
node scripts/test-connection.js
```

## Workflow Organization

### Onboarding Workflows

1. **new-hire-setup.json** (Main Orchestrator)
   - Triggered by: Webhook or manual
   - Coordinates all onboarding sub-workflows
   - Tracks overall progress
   - Sends completion notifications

2. **autotask-contact.json**
   - Creates contact in Autotask
   - Sets up resource if needed
   - Assigns to appropriate groups

3. **email-setup.json**
   - Provisions email account
   - Configures mailbox settings
   - Sends welcome email

4. **ad-account.json**
   - Creates Active Directory account
   - Sets group memberships
   - Configures permissions

5. **equipment-request.json**
   - Creates equipment tickets
   - Tracks provisioning status
   - Notifies when ready

### Offboarding Workflows

1. **employee-exit.json** (Main Orchestrator)
   - Triggered by: Termination date webhook
   - Coordinates all offboarding tasks
   - Enforces timeline
   - Final status reporting

2. **access-revocation.json**
   - Disables all accounts
   - Removes group memberships
   - Revokes application access

3. **equipment-recovery.json**
   - Creates collection ticket
   - Tracks returned equipment
   - Updates asset records

4. **data-backup.json**
   - Archives user files
   - Backs up email
   - Documents locations

## Adding New Workflows

To add a new workflow:

1. Create workflow in n8n UI
2. Test thoroughly
3. Export workflow JSON
4. Place in appropriate directory
5. Update this documentation
6. Add to import script
7. Create pull request

## Configuration Management

### Environment-Specific Configuration

Different environments (dev, staging, production) should use:
- Separate `.env` files
- Different Autotask instances
- Separate notification addresses
- Distinct workflow versions

### Version Control

- Commit workflow JSON files
- Version configuration files
- Tag releases with semantic versioning
- Maintain CHANGELOG.md

## Best Practices

### Workflow Development
- Use descriptive node names
- Add comprehensive error handling
- Include workflow notes/documentation
- Test with various scenarios
- Use environment variables

### File Organization
- Keep related workflows together
- Use consistent naming conventions
- Document any custom fields/mappings
- Maintain backwards compatibility

### Security
- Never commit credentials
- Use .gitignore properly
- Sanitize exported workflows
- Encrypt sensitive configuration
- Follow principle of least privilege

## Maintenance

### Regular Tasks
- Review and update workflows
- Test with latest n8n version
- Update Autotask mappings
- Refresh documentation
- Clean up unused workflows

### Backup Strategy
- Daily workflow exports
- Version control commits
- Configuration backups
- Test restoration process

## Future Structure

Planned additions:
```
├── tests/                    # Automated tests
│   ├── unit/                 # Unit tests
│   └── integration/          # Integration tests
│
├── monitoring/               # Monitoring configuration
│   ├── dashboards/           # Grafana dashboards
│   └── alerts/               # Alert definitions
│
└── deployment/               # Deployment automation
    ├── docker/               # Docker configurations
    └── kubernetes/           # K8s manifests
```

---

**Note**: This structure is designed to scale with the project. Start simple and add complexity as needed.
