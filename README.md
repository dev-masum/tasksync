# TaskSync

TaskSync is a full-stack task management system with a **Go** REST API backend and a **Flutter** mobile application.

---

## 🛠 Tech & Architecture Decisions

### Backend
- I chose **Go (Golang)** for the backend because I'm most comfortable with it for building fast, lightweight REST APIs. I am also fully comfortable working with and contributing to **Node.js** and **NestJS** projects.

### Mobile Architecture
- The Flutter app follows **Feature-First Clean Architecture** to demonstrate how to structure scalable, production-ready applications for long-term maintainability. While standard **MVVM** or **Layer-First** architectures are typically fine for smaller apps, MVPs, or POCs, feature-first clean architecture keeps features isolated and easy to scale.

---

## 🚀 Project Guides

To run the backend or the mobile application, follow the specific guides below:

- 📡 **[Backend API README](./tasksync-api/README.md)** — Docker setup, PostgreSQL database choice, and API endpoints.
- 📱 **[Flutter App README](./tasksync-app/README.md)** — App setup, state management choice, and native battery channel integration.
