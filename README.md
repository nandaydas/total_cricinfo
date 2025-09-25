# Total CricInfo

**Total CricInfo** is a Flutter mobile/web application for live cricket scores and match info. It uses Firebase for backend services, GetX for state management, and fetches data from a REST API to keep match details up-to-date in real time.

---

## Table of Contents

- [Features](#features)  
- [Tech Stack](#tech-stack)  
- [Project Structure](#project-structure)  
- [Prerequisites](#prerequisites)  
- [Setup & Installation](#setup--installation)  
- [Configuration](#configuration)  
- [Running the App](#running-the-app)  
- [Testing](#testing)  
- [Contributing](#contributing)  
- [License](#license)  
- [Author](#author)

---

## Features

- Live scores for ongoing matches  
- Match schedules, previews, line-ups etc. via REST API  
- Firebase Authentication 
- Firebase Firestore / Realtime Database for caching or user data  
- Push notifications for upcoming matches / score updates (if implemented)  
- State management with GetX for responsiveness & clean structure  
- Supports multiple platforms: Android, iOS, Web, etc.

---

## Tech Stack

| Layer / Function | Technology / Framework |
|------------------|-------------------------|
| UI / Frontend    | Flutter (Dart)         |
| State Management | GetX                   |
| Backend as Service| Firebase (Auth, Firestore / Storage, Notifications) |
| Data Source      | External REST API for cricket data |
| Platforms        | Android, iOS, Web (Linux / macOS / Windows builds as configured) |

---

## Prerequisites

- Flutter SDK installed (ensure version supports all target platforms)  
- A Firebase project configured, with services you need (Auth, Firestore, etc.)  
- REST API key / endpoint(s) for cricket data  
- Android/iOS setup (if building for mobile): Android SDK, Xcode etc.  
- Keystore (for Android release) if publishing  

---

## Setup & Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/nandaydas/total_cricinfo.git
   cd total_cricinfo
