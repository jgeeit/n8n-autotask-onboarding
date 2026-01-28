# Contributing to n8n-Autotask Onboarding

Thank you for considering contributing to this project! This document provides guidelines and instructions for contributing.

## 🤝 How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include:

- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Screenshots or error logs
- Environment details (n8n version, Autotask instance, etc.)

Use the **Bug Report** issue template when submitting bugs.

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- Use a clear and descriptive title
- Provide detailed description of the proposed feature
- Explain why this enhancement would be useful
- Include mockups or examples if applicable

Use the **Feature Request** issue template for enhancements.

## 🔧 Development Process

### Setting Up Development Environment

1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR-USERNAME/n8n-autotask-onboarding.git
   cd n8n-autotask-onboarding
   ```

2. **Set Up n8n Development Instance**
   ```bash
   # Using Docker
   docker run -it --rm \
     --name n8n-dev \
     -p 5678:5678 \
     -v ~/.n8n-dev:/home/node/.n8n \
     n8nio/n8n
   ```

3. **Configure Test Environment**
   - Copy `.env.example` to `.env`
   - Use Autotask sandbox instance for testing
   - Never use production credentials in development

### Making Changes

1. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-description
   ```

2. **Branch Naming Convention**
   - `feature/` - New features
   - `fix/` - Bug fixes
   - `docs/` - Documentation updates
   - `refactor/` - Code refactoring
   - `test/` - Test additions or modifications

3. **Make Your Changes**
   - Follow the coding standards below
   - Test thoroughly in development environment
   - Update documentation as needed
   - Add comments for complex logic

4. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "type: brief description"
   ```

   **Commit Message Format:**
   ```
   type: brief description

   Longer explanation if necessary, including:
   - Why the change was made
   - What was changed
   - Any breaking changes or migration notes
   ```

   **Types:**
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `style:` - Code style changes (formatting, etc.)
   - `refactor:` - Code refactoring
   - `test:` - Adding or updating tests
   - `chore:` - Maintenance tasks

### Workflow Development Standards

#### Node Naming
- Use descriptive names: `Create Contact in Autotask` not `HTTP Request`
- Include the action and target: `Send Welcome Email to New Hire`
- Be consistent with naming patterns

#### Error Handling
- Every workflow MUST have an Error Trigger node
- Implement retry logic for API calls
- Log errors with context (workflow name, input data, timestamp)
- Send notifications for critical failures

#### Documentation
- Add notes to complex nodes explaining logic
- Document any custom expressions or code
- Include example payloads in workflow notes
- Keep documentation up-to-date with changes

#### Testing
Test workflows with:
- Valid data (happy path)
- Invalid/missing data
- Edge cases
- Large data sets
- API failures/timeouts

#### Code in Function Nodes
```javascript
// Always include error handling
try {
  // Your code here
  const result = processData($input.all());
  return result;
} catch (error) {
  // Log error with context
  console.error('Error in [Node Name]:', error);
  throw new Error(`Failed to process: ${error.message}`);
}
```

#### Expressions
- Use descriptive variable names in expressions
- Add comments for complex expressions
- Test expressions with different input types
- Handle null/undefined values gracefully

### Configuration Files

#### Updating Mappings
When updating `config/autotask-mappings.json`:
- Verify field IDs match your Autotask instance
- Document any custom fields
- Test with real Autotask API responses
- Update README if adding new mappings

#### Email Templates
When updating `config/email-templates.json`:
- Use clear placeholder names: `{{firstName}}` not `{{fn}}`
- Test rendering with actual data
- Check formatting in different email clients
- Keep professional tone and branding

### Pull Request Process

1. **Update Documentation**
   - Update README.md if adding features
   - Add/update workflow documentation
   - Update CHANGELOG.md with your changes

2. **Test Thoroughly**
   - Test in development environment
   - Verify no existing functionality breaks
   - Test error scenarios
   - Include test results in PR description

3. **Submit Pull Request**
   - Use the PR template
   - Link related issues
   - Provide clear description of changes
   - Include screenshots/logs if applicable
   - Request review from maintainers

4. **PR Review Process**
   - Address reviewer feedback
   - Make requested changes
   - Keep PR focused (one feature/fix per PR)
   - Rebase if needed to resolve conflicts

5. **After Merge**
   - Delete your feature branch
   - Pull latest changes from main
   - Close related issues

## 📋 Coding Standards

### Workflow JSON Files
- Indent with 2 spaces
- Sort nodes logically (triggers first, error handlers last)
- Remove test credentials before committing
- Use environment variables for sensitive data

### Configuration Files
- Valid JSON format
- Include comments where helpful (in separate docs)
- Keep organized and readable
- Use consistent structure

### Documentation
- Use Markdown format
- Include code examples
- Keep language clear and concise
- Update table of contents
- Check spelling and grammar

### Git Practices
- Commit often with meaningful messages
- Don't commit sensitive data (credentials, keys, etc.)
- Keep commits focused and atomic
- Write descriptive PR descriptions
- Squash commits if requested

## 🧪 Testing Guidelines

### Manual Testing Checklist
Before submitting PR, verify:
- [ ] Workflow executes successfully
- [ ] Error handling works correctly
- [ ] Autotask data is created/updated properly
- [ ] Email notifications are sent
- [ ] No sensitive data is logged
- [ ] Works with different input scenarios
- [ ] Documentation is updated

### Test Data
- Use Autotask sandbox instance
- Create test contacts/companies
- Don't use real employee data
- Clean up test data after testing

## 📝 Documentation Updates

When updating documentation:
- Keep README.md as the primary reference
- Update workflow diagrams if changing flow
- Document breaking changes clearly
- Include migration instructions if needed
- Update examples to match current code

## 🔐 Security Considerations

### Never Commit:
- API keys or credentials
- Production configuration
- Personal/sensitive employee data
- Production Autotask URLs or IDs

### Always:
- Use environment variables
- Test with sandbox/development data
- Review diffs before committing
- Use `.gitignore` properly
- Follow principle of least privilege

## 🤔 Questions or Need Help?

- Open an issue for questions
- Tag maintainers for assistance
- Check existing issues and discussions
- Review documentation thoroughly first

## 📜 Code of Conduct

### Our Standards
- Be respectful and professional
- Welcome diverse perspectives
- Focus on constructive feedback
- Help others learn and grow
- Maintain confidentiality

### Unacceptable Behavior
- Harassment or discrimination
- Trolling or insulting comments
- Publishing others' private information
- Unprofessional conduct

## 🎉 Recognition

Contributors will be:
- Listed in project acknowledgments
- Credited in release notes
- Thanked for their contributions

Thank you for contributing to making IT automation better!

## 📞 Contact

For questions about contributing:
- Open a GitHub issue
- Contact project maintainers
- Email: [Contact information]

---

**Remember**: Quality over quantity. A well-tested, documented PR is more valuable than multiple rushed changes.
