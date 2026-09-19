# TaskSync Mobile App (`tasksync-app`)

Cross-platform task management app built with **Flutter**, **BLoC (Cubit)**, and **Clean Architecture**.

---

## 💡 State Management & Architecture Choices

### State Management: BLoC (Cubit)
- **Why Cubit**: Provides predictable, unidirectional state flow and keeps business logic separate from UI widgets without event boilerplate.

### Architecture: Clean Architecture (Feature-First)
- **Why Clean Architecture**: Organizes code by features (`auth`, `task`), separating data sources, domain logic/use-cases, and presentation widgets for testability and maintainability.

---

## 📱 Native Platform Channel Integration
- **Battery Level Channel**: Implemented a native Android Kotlin `MethodChannel` (`com.tasksync.app/battery`) that fetches the live device battery percentage and displays it in the Home Screen App Bar.

---

## 🚀 Setup & Execution

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Generate Code (Build Runner)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Run the App
```bash
flutter run -d <DEVICE_ID> --dart-define=BASE_URL=http://<YOUR_LOCAL_IP>:3000
```