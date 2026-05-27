# 🍱 Nakhwa (نخوة)

<div align="center">

# Share Food • Spread Kindness

### A community-driven platform designed to reduce food waste and support people in need through an integrated food donation ecosystem.

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Backend-orange?logo=firebase)
![BLoC](https://img.shields.io/badge/State%20Management-BLoC-blueviolet)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green)

</div>

---

# 📖 Overview

**Nakhwa (نخوة)** is a social impact mobile application built with Flutter and Firebase that enables communities to collaborate in reducing food waste while helping individuals and families in need.

The platform connects:

- 🍲 **Donors** — people willing to donate food/meals.
- 🙏 **Receivers** — beneficiaries looking for available donations.
- 🚚 **Delivery Volunteers** — users who transport donations safely.
- 🏢 **Charities** — organizations responsible for approving and managing users.
- 🛡️ **Admins** — platform administrators responsible for moderation and announcements.

The application follows a **role-based architecture** with real-time updates powered by Firebase Cloud Firestore and scalable state management using the **BLoC/Cubit pattern**.

---

# ✨ Core Features

## 👨‍💼 Admin Features

- Manage platform accounts.
- Add users directly using a secondary Firebase app instance.
- Broadcast global announcements.
- Moderate platform activities.
- Manage donors, receivers, and delivery volunteers.

---

## 🏢 Charity Features

- Approve or reject new registrations.
- Monitor community activity.
- Manage linked users and permissions.
- Review requests submitted by users.

---

## 🍲 Donor Features

- Create food donations.
- Add donation details:
  - Meal type
  - Number of people served
  - Description
  - Pickup and delivery locations
- Track donation lifecycle.
- View donation history.

---

## 🙏 Receiver Features

- Browse available donations.
- Request meals.
- Track request status.
- Coordinate delivery details.

---

## 🚚 Delivery Features

- View open delivery requests.
- Accept transport requests.
- Manage delivery lifecycle.
- Mark deliveries as completed.
- Maintain delivery history.

---

## ⭐ Rating & Quality Control System

The platform includes a real-time rating system that:

- Evaluates donors and delivery personnel.
- Stores:
  - `ratingTotal`
  - `ratingCount`
  - `ratingAverage`
- Uses Firestore atomic updates and transactions.
- Automatically triggers alerts/announcements when ratings fall below critical thresholds.

---

# 🏗️ Architecture

## Application Architecture

Nakhwa follows a layered and modular architecture:

```text
Presentation Layer
    ↓
Cubit / State Management Layer
    ↓
Business Logic Layer
    ↓
Firebase Services Layer
```

---

## State Management

The application uses:

- `flutter_bloc`
- `Cubit`

### Main Cubits

| Cubit | Responsibility |
|---|---|
| `login_cubit` | Authentication logic |
| `register_cubit` | User & charity registration |
| `user_cubit` | User dashboards & workflows |
| `admin_cubit` | Admin operations |
| `charity_cubit` | Charity management |
| `profile_cubit` | Profile loading/updating |

---

# 🛠️ Tech Stack

## Frontend

- Flutter
- Dart
- Material Design

## Backend & Services

- Firebase Authentication
- Cloud Firestore
- Firebase Core

## State Management

- flutter_bloc
- Cubit

## Utilities & Libraries

- google_fonts
- intl

---

# 📂 Project Structure

```bash
lib/
├── classes/                  # Data Models
│   ├── admin.dart
│   ├── announcement.dart
│   ├── charity.dart
│   ├── donation.dart
│   ├── mainuser.dart
│   └── user.dart
│
├── cubits/                   # State Management
│   ├── admin/
│   ├── charity/
│   ├── login/
│   ├── profile/
│   ├── register/
│   └── user/
│
├── screens/                  # UI Screens
│   ├── admin/
│   ├── charity/
│   ├── user/
│   ├── register/
│   ├── common_screens/
│   └── base_screens/
│
├── components/               # Reusable Widgets
├── shared/                   # Shared Utilities
├── firebase_options.dart
└── main.dart
```

---

# 🔥 Firebase Integration

The project uses Firebase for:

- Authentication
- Real-time database operations
- User management
- Role-based access
- Announcements
- Donation tracking

## Firebase Collections

### `users`
Stores all donor, receiver, and delivery user information.

### `charity`
Stores charity organization accounts.

### `admin`
Stores admin accounts.

### `donations`
Stores food donation records and statuses.

### `announcements`
Stores system-wide notifications.

### `requests`
Stores permission and participation requests.

---

# 🔐 Authentication Flow

The app uses Firebase Authentication with email/password login.

### Supported Workflows

- User Registration
- Charity Registration
- Login Authentication
- Admin User Creation
- Profile Management

---

# 🔄 Donation Lifecycle

```text
Donor creates donation
        ↓
Receiver requests donation
        ↓
Delivery volunteer accepts task
        ↓
Food transported
        ↓
Delivery completed
        ↓
Rating submitted
```

---

# 🎨 UI & Design

The application follows a clean and modern UI approach:

- Gradient-based layouts
- Material Design components
- Responsive interfaces
- Reusable widgets
- Animated transitions
- Role-specific dashboards

Primary design colors are centered around:

- Green (`#2F855A`)
- Emerald (`#68D391`)
- Soft white surfaces

---

# 🚀 Getting Started

## Prerequisites

Before running the project, ensure you have:

- Flutter SDK installed
- Dart SDK installed
- Firebase project configured
- Android Studio / VS Code
- Android SDK / Xcode

---

# 🧠 Future Improvements

- Push Notifications
- Google Maps Integration
- Real-time Chat System
- AI-based Donation Matching
- Multi-language Support
- Food Expiration Prediction
- Analytics Dashboard
- Offline Support
- QR-based Delivery Verification

---

# 🔒 Security Considerations

- Firebase Authentication secures access.
- Role-based authorization enforced.
- Firestore validation recommended.
- Sensitive operations isolated by user roles.
- Community moderation system implemented.

---

# 👨‍💻 Development Highlights

## Scalable Architecture

The project is designed with modularity and maintainability in mind using:

- Separation of concerns
- Reusable components
- Cubit-based state management
- Structured feature modules

---

## Real-Time Data Synchronization

Cloud Firestore enables:

- Instant updates
- Live announcements
- Dynamic dashboards
- Real-time delivery tracking

---

# 📸 Main Modules

| Module | Description |
|---|---|
| Authentication | Login & registration workflows |
| Donations | Donation management system |
| Delivery | Transport coordination |
| Charity Management | Community governance |
| Admin Panel | System moderation |
| Ratings System | Trust & quality assurance |
| Announcements | Community communication |

---

# 🎓 Graduation Project

Nakhwa was developed as a **Software Engineering Graduation Project**, aiming to demonstrate the practical implementation of:

- Cross-platform mobile development using Flutter.
- Scalable state management using BLoC/Cubit.
- Real-time cloud-based architectures using Firebase.
- Role-based system design.
- Community-focused digital solutions for social impact.

The project combines modern mobile engineering practices with humanitarian objectives to create a sustainable and impactful solution.

---

# 👨‍💻 Authors

- Qusai Altoubasy
- Osama Amerah
- Waleed Dweik
- Mohammad Abuissa

---

# 🌍 Social Impact Vision

Nakhwa is more than a mobile application — it is a digital humanitarian ecosystem focused on:

- Fighting food waste
- Supporting vulnerable communities
- Encouraging volunteering
- Strengthening social solidarity
- Promoting sustainable resource sharing

> “Small acts of kindness can create powerful community change.”

---
