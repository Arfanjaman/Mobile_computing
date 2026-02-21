# firebase_2107030 — iOS Notes App with Firebase

## Overview

**firebase_2107030** is an iOS application built with **SwiftUI** that provides a simple, authenticated note-taking experience backed by **Firebase**. Users can sign up or sign in with email/password, and once authenticated, they can create, view, and delete personal notes that are stored in **Cloud Firestore**.

Each user's notes are stored under their own user document in Firestore, ensuring data isolation between accounts.

---

## Features

- **Email/Password Authentication** — Sign up and sign in using Firebase Authentication.
- **Per-User Notes** — Each authenticated user has their own private collection of notes in Firestore.
- **Create Notes** — Add notes with a title and content via a modal form.
- **View Notes** — Notes are listed in real-time with a snapshot listener (updates appear instantly).
- **Delete Notes** — Remove notes directly from the list with a delete button.
- **Sign Out** — Log out and return to the authentication screen.

---

## Tech Stack

| Layer            | Technology                        |
| ---------------- | --------------------------------- |
| UI Framework     | SwiftUI                          |
| Language         | Swift                            |
| Authentication   | Firebase Authentication (Email)  |
| Database         | Cloud Firestore                  |
| Architecture     | MVVM (Model-View-ViewModel)      |
| Platform         | iOS / macOS (via Xcode)          |

---

## Project Structure

```
firebase_2107030/
├── firebase_2107030/                 # Main app target
│   ├── firebase_2107030App.swift     # App entry point, Firebase configuration
│   ├── AuthView.swift                # Login / Sign-up UI
│   ├── AuthViewModel.swift           # Authentication business logic (MVVM)
│   ├── FContentView.swift            # Main notes list view (post-login)
│   ├── AddNoteView.swift             # Modal form to add a new note
│   ├── FirestoreManager.swift        # Firestore CRUD operations
│   ├── Note.swift                    # Note data model
│   ├── ContentView.swift             # Default template view (unused)
│   ├── GoogleService-Info.plist      # Firebase configuration file
│   ├── firebase_2107030.entitlements # Keychain access entitlements
│   └── Assets.xcassets/              # Asset catalog
├── firebase_2107030Tests/            # Unit test target (template)
└── firebase_2107030UITests/          # UI test target (template)
```

---

## Architecture (MVVM)

The app follows the **Model-View-ViewModel** pattern:

- **Model** — `Note` struct representing a Firestore document.
- **ViewModel** — `AuthViewModel` manages authentication state; `FirestoreManager` manages Firestore data operations.
- **View** — `AuthView`, `FContentView`, and `AddNoteView` handle the user interface.

### Data Flow

```
AuthView  ──▶  AuthViewModel  ──▶  Firebase Auth
                    │
                    ▼ (isSignedIn)
              FContentView  ──▶  FirestoreManager  ──▶  Cloud Firestore
                    │
                    ▼
              AddNoteView
```

1. The app launches and presents `AuthView`.
2. `AuthViewModel` checks if a user is already signed in.
3. On successful authentication, the view switches to `FContentView`.
4. `FContentView` uses `FirestoreManager` to fetch, display, and delete notes.
5. The "+" button opens `AddNoteView` as a sheet to create new notes.
6. A "Sign Out" button logs the user out and returns to `AuthView`.

---

## Firestore Data Structure

```
Firestore Root
└── users (collection)
    └── {userId} (document)
        └── notes (subcollection)
            └── {noteId} (document)
                ├── title: String
                └── content: String
```

---

## Prerequisites

- **Xcode 14+**
- **iOS 16+** deployment target (SwiftUI)
- A **Firebase project** with:
  - Email/Password Authentication enabled
  - Cloud Firestore database created
  - `GoogleService-Info.plist` downloaded and added to the project
- **Swift Package Manager** dependencies:
  - `firebase-ios-sdk`

---

## Setup & Installation

1. Clone or download this repository.
2. Open `firebase_2107030.xcodeproj` in Xcode.
3. Ensure the `GoogleService-Info.plist` is present in the app target.
4. Resolve Swift Package Manager dependencies (Xcode should do this automatically).
5. Build and run on a simulator or physical device.

---

## Usage

1. **Launch the app** — You are presented with the sign-in/sign-up screen.
2. **Create an account** — Enter an email and password, then tap **Sign Up**.
3. **Sign in** — Use your credentials and tap **Sign In**.
4. **Add a note** — Tap the **+** button in the navigation bar, fill in title and content, then tap **Save**.
5. **Delete a note** — Tap the **Delete** button next to any note.
6. **Sign out** — Tap the red **Sign Out** button at the bottom.

---

## License

This project is created for educational purposes as part of a Mobile Computing course (Student ID: 2107030).
