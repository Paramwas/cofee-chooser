# Flutter Firebase App

## Overview
This is a simple Flutter application that allows users to log in and edit their preferences, such as:
- **Sugar Strength**
- **Name**

The app is integrated with **Firebase** for authentication and data storage.

## Features
- User **authentication** (login)
- Edit user **preferences** (sugar strength, name)
- Data stored and retrieved from **Firebase**

## Installation
### Prerequisites
Make sure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart
- Firebase setup (Follow [Firebase Docs](https://firebase.flutter.dev/docs/overview))

### Setup
1. Clone this repository:
   ```sh
   git clone <repo-url>
   ```
2. Navigate to the project folder:
   ```sh
   cd your_project_folder
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Configure Firebase:
   - Add your **GoogleService-Info.plist** (iOS) or **google-services.json** (Android) to the project.
   - Follow the [Flutter Firebase setup guide](https://firebase.flutter.dev/docs/overview/).

## Running the App
To run the app on a connected device or emulator, use:
```sh
flutter run
```

## Technologies Used
- **Flutter** (UI framework)
- **Firebase** (Auth & Firestore for data storage)

## Contribution
Feel free to fork this project and submit pull requests!

## License
This project is open-source and available under the MIT License.
