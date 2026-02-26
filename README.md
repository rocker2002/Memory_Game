<div align="center">

# 🎮 Memory Game

### A Flutter-based Memory Card Game Built with Clean Architecture

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8.1+-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Provider](https://img.shields.io/badge/Provider-6.1.5-orange?style=for-the-badge)](https://pub.dev/packages/provider)

*A production-ready memory matching game demonstrating best practices in Flutter development*

[Features](#-features) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [Project Structure](#-project-structure)

</div>

---

## ✨ Features

- 🎯 **Classic Memory Game Mechanics** - Match pairs of emoji cards
- 🎵 **Immersive Sound Effects** - Background music and interactive audio feedback
- 🔄 **Flip Card Animations** - Smooth, engaging card flip transitions
- 🌐 **Remote Data Integration** - Fetches emoji data from external API
- 📱 **Responsive Design** - Adapts to different screen sizes
- 🎨 **Clean UI/UX** - Intuitive and visually appealing interface

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles, ensuring separation of concerns, testability, and maintainability. The codebase is organized into three distinct layers:

### Architecture Layers

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (UI, Widgets, State Management)        │
│         Provider Pattern                │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│          Domain Layer                   │
│  (Business Logic, Use Cases, Entities)  │
└──────────────┬──────────────────────────┘
               │
┌──────────────▼──────────────────────────┐
│           Data Layer                    │
│  (Repositories, Data Sources, Models)   │
└─────────────────────────────────────────┘
```

### 🎯 Domain Layer
The core business logic, independent of any framework or external dependencies.

- **Entities**: Pure Dart objects representing core business models
- **Use Cases**: Application-specific business rules
- **Repository Interfaces**: Abstract contracts for data operations

### 💾 Data Layer
Handles data operations and external communications.

- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Remote API integration (Emoji API)
- **Repository Implementations**: Concrete implementations of domain contracts

### 🎨 Presentation Layer
User interface and state management using **Provider**.

- **Screens**: Game UI components
- **Widgets**: Reusable UI elements
- **Providers**: State management with `ChangeNotifier`
- **Services**: Sound and audio management

---

## 🔧 State Management with Provider

This project leverages **Provider** for efficient and scalable state management:

### Key Benefits

✅ **Dependency Injection** - Clean separation of concerns  
✅ **Reactive UI Updates** - Automatic widget rebuilds on state changes  
✅ **Testability** - Easy to mock and test providers  
✅ **Performance** - Optimized rebuilds with `Consumer` and `Selector`

### Provider Setup

```dart
MultiProvider(
  providers: [
    Provider<EmojiRemoteDataSource>(...),
    Provider<EmojiRepositoryImpl>(...),
    Provider<GetEmojiCards>(...),
    ChangeNotifierProvider<GameProvider>(...),
  ],
  child: MaterialApp(...),
)
```

---

## 📁 Project Structure

```
lib/
├── main.dart                          # Application entry point
└── memory_game/
    ├── data/                          # Data Layer
    │   ├── datasources/
    │   │   └── emoji_datasource.dart  # Remote API integration
    │   ├── models/
    │   │   └── card_model.dart        # Data models
    │   └── repositories/
    │       └── emoji_repository_impl.dart
    │
    ├── domain/                        # Domain Layer
    │   ├── entities/
    │   │   └── card_entity.dart       # Business entities
    │   ├── repositories/
    │   │   └── emoji_repository.dart  # Repository contracts
    │   └── usecases/
    │       └── get_emoji_cards.dart   # Business logic
    │
    └── presentation/                  # Presentation Layer
        ├── provider/
        │   ├── game_provider.dart     # Game state management
        │   └── sound_service.dart     # Audio service
        ├── screens/
        │   ├── game_screen.dart       # Main game UI
        │   └── start_screen.dart      # Start menu
        └── widgets/
            └── game_over.dart         # Game over dialog
```

---

## Screenshots

>> Screenshots will be added here.

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.8.1 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd memory_game
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| [provider](https://pub.dev/packages/provider) | ^6.1.5 | State management |
| [flip_card](https://pub.dev/packages/flip_card) | ^0.7.0 | Card flip animations |
| [http](https://pub.dev/packages/http) | ^1.4.0 | HTTP requests |
| [audioplayers](https://pub.dev/packages/audioplayers) | ^6.5.0 | Sound effects |

---

## 🎮 How to Play

1. Launch the game and select your difficulty level
2. Tap cards to flip them and reveal emojis
3. Match pairs of identical emojis
4. Complete the board by matching all pairs
5. Try to beat your best time!

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 Code Quality

This project follows Flutter best practices and coding standards:

- ✅ Clean Architecture principles
- ✅ SOLID principles
- ✅ Dependency injection
- ✅ Separation of concerns
- ✅ Comprehensive code documentation

---

<div align="center">

**Built with ❤️ using Flutter and Clean Architecture**

</div>
