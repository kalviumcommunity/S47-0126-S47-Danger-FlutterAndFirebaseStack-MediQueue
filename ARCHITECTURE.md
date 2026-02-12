# MediQueue Architecture

## Clean Architecture Principles
- **Feature-first:** Modules grouped by feature, not by type
- **Separation of concerns:** UI, business logic, and data layers are independent
- **Scalability:** Easy to add new features and modules
- **Testability:** Clear boundaries for unit tests

## Folder Structure Explained
```
lib/
├── main.dart                 # App entry point
├── app.dart                  # MaterialApp configuration
├── core/                     # Core functionality
│   ├── constants/           # App-wide constants
│   ├── theme/               # Theme configuration
│   ├── utils/               # Helper functions
│   └── config/              # App configuration
├── features/                 # Feature-based modules
│   ├── auth/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── models/
│   │   └── services/
│   ├── queue/
│   └── dashboard/
├── shared/                   # Shared across features
│   ├── widgets/             # Reusable widgets
│   ├── models/              # Common data models
│   └── services/            # Shared services
└── routes/                   # Navigation & routing
assets/
├── images/
│   ├── logo/
│   ├── icons/
│   └── illustrations/
├── fonts/
│   └── Roboto/
└── data/
    └── mock_data.json
```

## Module Details
- **core/**: App-wide utilities, constants, theme, and config
- **features/**: Each feature (auth, queue, dashboard) has its own screens, widgets, models, and services
- **shared/**: Reusable widgets, models, and services used across features
- **routes/**: Centralized navigation and routing
- **assets/**: Images, fonts, and mock data

## Barrel Files
- Use `index.dart` in each module for simplified imports

## Naming Conventions
- Use lower_snake_case for files and folders
- Use PascalCase for class names

## Example
- To add a new feature, create a folder in `features/` and follow the same structure

---
For questions, see CONTRIBUTING.md or contact the maintainers.
