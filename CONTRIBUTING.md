## 🛠️ Development Guidelines

### Code Organization
- One widget per file (for complex widgets)
- Use barrel files (`index.dart`) for module exports
- Consistent naming conventions
- Shared code goes in `shared/`, not `core/`

### Branching
- Use feature branches: `feature/<name>`
- Use bugfix branches: `bugfix/<name>`
- Use release branches: `release/<version>`

### Commit Messages
- Use clear, descriptive commit messages
- Reference issues where relevant

### PR Review
- All code must be reviewed before merging
- No circular dependencies allowed

### Testing
- Write unit tests for business logic
- Test UI on emulator and physical device
- Handle error and empty states

### Style
- Follow Dart/Flutter formatting
- Use Material Design principles
- Support dark mode

### Getting Started
1. Fork the repo
2. Clone your fork
3. Run `flutter pub get`
4. Create a new branch for your feature

---
For questions, open an issue or contact the maintainers.
# Contributing to MediQueue

First off, thank you for considering contributing to MediQueue! It's people like you that make MediQueue such a great tool for healthcare digitization.

## 🤝 Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

## 🚀 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps to reproduce the problem**
* **Provide specific examples**
* **Describe the behavior you observed and what you expected**
* **Include screenshots if possible**
* **Include your environment details** (OS, Flutter version, device)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a detailed description of the suggested enhancement**
* **Explain why this enhancement would be useful**
* **List any similar features in other apps**

### Pull Requests

* Fill in the required template
* Follow the Flutter style guide
* Include appropriate test cases
* Update documentation as needed
* End all files with a newline

## 💻 Development Setup

1. **Fork the repository**
2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/S47-0126-S47-Danger-FlutterAndFirebaseStack-MediQueue.git
   ```
3. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
4. **Install dependencies**
   ```bash
   flutter pub get
   ```
5. **Make your changes**
6. **Run tests**
   ```bash
   flutter test
   ```
7. **Commit your changes**
   ```bash
   git commit -m "Add: your feature description"
   ```
8. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
9. **Create a Pull Request**

## 📝 Coding Standards

### Dart/Flutter Style Guide

* Follow the [official Dart style guide](https://dart.dev/guides/language/effective-dart/style)
* Use `flutter format` before committing
* Run `flutter analyze` to check for issues
* Maximum line length: 80 characters
* Use meaningful variable and function names

### File Organization

```
lib/
├── models/          # Data models
├── screens/         # UI screens
├── widgets/         # Reusable widgets
├── services/        # Business logic & API calls
├── providers/       # State management
├── utils/           # Utility functions
├── constants/       # Constants & configurations
└── main.dart        # Entry point
```

### Naming Conventions

* **Files**: `snake_case.dart`
* **Classes**: `PascalCase`
* **Variables**: `camelCase`
* **Constants**: `SCREAMING_SNAKE_CASE`
* **Private members**: `_leadingUnderscore`

### Comments

* Write self-documenting code
* Add comments for complex logic
* Use `///` for documentation comments
* Keep comments up-to-date

### Git Commit Messages

* Use present tense ("Add feature" not "Added feature")
* Use imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit first line to 72 characters
* Reference issues and pull requests

**Commit Message Format:**
```
Type: Brief description

Detailed explanation (optional)

Fixes #issue_number
```

**Types:**
* `Add:` New feature
* `Fix:` Bug fix
* `Update:` Update existing feature
* `Remove:` Remove code/feature
* `Refactor:` Code refactoring
* `Docs:` Documentation changes
* `Test:` Adding tests
* `Style:` Code style changes

## 🧪 Testing

* Write unit tests for services
* Write widget tests for UI components
* Write integration tests for critical flows
* Maintain test coverage above 70%

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## 📚 Documentation

* Update README.md if needed
* Update DOCUMENTATION.md for technical changes
* Add inline documentation for public APIs
* Update SPRINT_PLANNING.md for new features

## 🔍 Code Review Process

1. All submissions require review
2. Reviewers will check:
   * Code quality
   * Test coverage
   * Documentation
   * Performance
   * Security
3. Address review comments
4. Get approval from maintainers
5. Squash commits if needed
6. Merge!

## 🎯 Priority Labels

* `priority: critical` - Security issues, crashes
* `priority: high` - Major bugs, important features
* `priority: medium` - Minor bugs, enhancements
* `priority: low` - Nice-to-have features

## 🏷️ Issue Labels

* `bug` - Something isn't working
* `enhancement` - New feature request
* `documentation` - Documentation improvements
* `good first issue` - Good for newcomers
* `help wanted` - Extra attention needed
* `question` - Further information requested

## 📞 Getting Help

* Check existing documentation
* Search existing issues
* Ask in discussions
* Contact maintainers

## 🙏 Recognition

Contributors will be recognized in:
* README.md contributors section
* Release notes
* Project documentation

Thank you for contributing to MediQueue! 🎉
