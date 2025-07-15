# PBMA

A Flutter-based mobile application for personal budget management and analytics.

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Running the App](#running-the-app)
- [Assets](#assets)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- User authentication and registration
- Budget and expense tracking
- Bank card management
- Member and profile management
- Notifications
- Multi-platform support (Android & iOS)
- Firebase integration

---

## Project Structure

```
pbma/
│
├── android/                # Android native code and configuration
├── ios/                    # iOS native code and configuration
├── assets/                 # App assets (JSON, SVG, images)
│   ├── jsons/
│   └── svg/
├── lib/                    # Main Dart codebase
│   ├── controllers/        # Business logic controllers
│   ├── models/             # Data models and entities
│   ├── repositories/       # Data repositories
│   ├── services/           # Service classes (API, Firebase, etc.)
│   ├── enums/              # Enum definitions
│   ├── screens/            # UI screens
│   ├── utils/              # Utility and helper functions
│   ├── main.dart           # App entry point
│   └── ...                 # Other Dart files
├── pubspec.yaml            # Flutter/Dart dependencies
├── analysis_options.yaml   # Linting rules
├── firebase.json           # Firebase configuration
├── database.rules.json     # Firebase database rules
└── README.md               # Project documentation
```

---

Let me know if you want to add more details (e.g., usage examples, API docs, screenshots) or if you have a specific project description or feature list!

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [Xcode](https://developer.apple.com/xcode/) (for iOS)
- Firebase account (for backend services)

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/pbma.git
   cd pbma
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Configure Firebase:**
   - Place your `google-services.json` in `android/app/`
   - Place your `GoogleService-Info.plist` in `ios/Runner/`

---

## Running the App

### Android

```sh
flutter run
```

### iOS

```sh
flutter run
```

> Make sure you have a simulator or device connected.

---

## Assets

- **JSONs:** `assets/jsons/` — Static data files (e.g., bank list)
- **SVGs:** `assets/svg/` — Vector icons and illustrations

---

## Contributing

Contributions are welcome! Please open issues and submit pull requests for improvements or bug fixes.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
