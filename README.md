# n8n-Autotask Onboarding & Offboarding Automation

n8n workflow automation server integrated with Autotask PSA for streamlined employee onboarding and offboarding procedures.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Workflow Structure](#workflow-structure)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

This project provides automated workflows for managing employee lifecycle events in Autotask PSA using n8n. It streamlines the process of onboarding new employees and offboarding departing employees by automating repetitive tasks and ensuring consistency across all procedures.

## ✨ Features

### Onboarding Workflows
- Automatic contact creation in Autotask
- Assignment of default resources and permissions
- Creation of standard tickets for setup tasks
- Email notifications to relevant teams
- Integration with other IT systems (AD, email, etc.)

### Offboarding Workflows
- Automated ticket creation for account deactivation
- Resource access review and removal
- Final billing and time entry review
- Exit checklist automation
- Notification to stakeholders

## 📦 Prerequisites

Before you begin, ensure you have the following:

- **n8n Server**: Version 1.0.0 or higher
  - Self-hosted or n8n Cloud instance
  - [Installation Guide](https://docs.n8n.io/hosting/)
  
- **Autotask PSA Account**:
  - API User credentials
  - API Integration enabled
  - Appropriate permissions for creating/modifying contacts and tickets
  
- **Node.js**: Version 18.x or higher (for local development)

- **Git**: For version control

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/jgeeit/n8n-autotask-onboarding.git
cd n8n-autotask-onboarding
```

### 2. Set Up n8n Server

#### Option A: Using Docker (Recommended)

```bash
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```

#### Option B: Using npm

```bash
npm install n8n -g
n8n start
```

### 3. Configure Autotask Credentials in n8n

1. Access your n8n instance at `http://localhost:5678`
2. Navigate to **Settings** → **Credentials**
3. Click **Add Credential** → **Autotask**
4. Enter your Autotask API credentials:
   - API Username
   - API Password/Secret
   - API Integration Code
   - Server URL (e.g., `https://webservices2.autotask.net/atservicesrest`)

## ⚙️ Configuration

### Environment Variables

Create a `.env` file in the project root (use `.env.example` as template):

```bash
# n8n Configuration
N8N_HOST=localhost
N8N_PORT=5678
N8N_PROTOCOL=http

# Autotask Configuration
AUTOTASK_API_USER=your_api_user
AUTOTASK_API_KEY=your_api_key
AUTOTASK_INTEGRATION_CODE=your_integration_code
AUTOTASK_SERVER_URL=https://webservices2.autotask.net/atservicesrest

# Email Notifications
SMTP_HOST=smtp.example.com
SMTP_PORT=587
SMTP_USER=notifications@example.com
SMTP_PASSWORD=your_smtp_password

# Notification Recipients
HR_EMAIL=hr@example.com
IT_EMAIL=it@example.com
MANAGER_EMAIL=manager@example.com
```

### Autotask Webhook Configuration

1. Log in to Autotask
2. Navigate to **Admin** → **Features & Settings** → **Application Integration (API)**
3. Create a new webhook endpoint pointing to your n8n instance
4. Configure triggers for relevant events (e.g., new hire created, termination date set)

## 📂 Workflow Structure

```
workflows/
├── onboarding/
│   ├── new-hire-setup.json          # Main onboarding workflow
│   ├── autotask-contact-creation.json
│   ├── access-provisioning.json
│   └── notification-manager.json
│
└── offboarding/
    ├── employee-exit.json           # Main offboarding workflow
    ├── access-revocation.json
    ├── final-billing-review.json
    └── exit-checklist.json

config/
├── autotask-mappings.json           # Field mappings for Autotask
├── email-templates.json             # Email notification templates
└── default-settings.json            # Default workflow settings

docs/
├── workflow-diagrams/               # Visual workflow documentation
├── api-documentation.md             # Autotask API usage notes
└── troubleshooting.md              # Common issues and solutions

scripts/
├── import-workflows.sh              # Script to import all workflows
├── export-workflows.sh              # Script to backup workflows
└── test-connection.js               # Test Autotask API connection
```

## 🔧 Usage

### Importing Workflows

#### Method 1: Via n8n UI
1. Open n8n in your browser
2. Click **Workflows** → **Import from File**
3. Select the workflow JSON file from the `workflows/` directory
4. Save and activate the workflow

#### Method 2: Using Import Script
```bash
chmod +x scripts/import-workflows.sh
./scripts/import-workflows.sh
```

### Triggering Workflows

#### Onboarding Workflow
The onboarding workflow can be triggered by:
- **Webhook**: POST request to the workflow webhook URL
- **Manual**: Via n8n UI for testing
- **Scheduled**: Automatically check for new hires daily

Example webhook payload:
```json
{
  "action": "onboard",
  "employee": {
    "firstName": "John",
    "lastName": "Doe",
    "email": "john.doe@example.com",
    "title": "IT Support Technician",
    "department": "IT",
    "startDate": "2025-02-01",
    "manager": "jane.smith@example.com"
  }
}
```

#### Offboarding Workflow
The offboarding workflow can be triggered by:
- **Webhook**: When termination date is set in Autotask
- **Manual**: For immediate processing
- **Scheduled**: Runs daily to check for employees with termination dates

Example webhook payload:
```json
{
  "action": "offboard",
  "employee": {
    "contactId": "12345",
    "email": "departing.employee@example.com",
    "terminationDate": "2025-01-31",
    "reason": "resignation",
    "manager": "jane.smith@example.com"
  }
}
```

### Testing Workflows

1. Use the **Execute Workflow** button in n8n to test with sample data
2. Monitor execution logs for any errors
3. Verify results in Autotask PSA
4. Check email notifications are sent correctly

## 🐛 Troubleshooting

### Common Issues

#### Authentication Errors
- **Issue**: "401 Unauthorized" when calling Autotask API
- **Solution**: Verify API credentials are correct and API user has necessary permissions

#### Webhook Not Triggering
- **Issue**: Workflow doesn't start when expected
- **Solution**: 
  - Confirm webhook URL is correctly configured in Autotask
  - Check n8n logs for incoming requests
  - Verify firewall rules allow incoming connections

#### Missing Field Values
- **Issue**: Some fields not populating in Autotask
- **Solution**: Review `config/autotask-mappings.json` and ensure field IDs match your Autotask instance

For more detailed troubleshooting, see [docs/troubleshooting.md](docs/troubleshooting.md).

## 📊 Monitoring and Logs

n8n provides built-in execution logs:
1. Navigate to **Executions** in n8n
2. Filter by workflow name
3. Review execution details, errors, and timing

Consider setting up:
- Email alerts for failed executions
- Webhook notifications to monitoring systems
- Regular backup of workflow configurations

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please ensure your code:
- Follows the existing workflow structure
- Includes appropriate error handling
- Is well-documented with comments
- Has been tested in a development environment

## 📝 Workflow Development Guidelines

- Use descriptive node names
- Add notes to complex logic sections
- Implement error handling with Error Trigger nodes
- Test thoroughly before deploying to production
- Version control all workflow changes
- Document any custom functions or expressions

## 🔐 Security Considerations

- Never commit credentials or API keys to the repository
- Use environment variables or n8n's credential system
- Restrict webhook access with authentication
- Regularly rotate API credentials
- Audit workflow permissions and access logs
- Follow principle of least privilege for API users

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [n8n.io](https://n8n.io) - Workflow automation platform
- [Autotask](https://www.autotask.com) - PSA platform
- Team Logic IT support team

## 📞 Support

For questions or issues:
- Open an issue on GitHub
- Contact: IT Help Desk at Team Logic
- Documentation: See `/docs` directory

## 🗺️ Roadmap

- [ ] Add integration with Active Directory
- [ ] Implement Microsoft 365 license provisioning
- [ ] Create asset assignment workflows
- [ ] Add Slack/Teams notifications
- [ ] Build dashboard for workflow monitoring
- [ ] Implement role-based workflow variations
- [ ] Add compliance reporting features

---

**Last Updated**: January 2025  
**Maintained by**: Team Logic IT Department
