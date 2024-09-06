# Deep Linking with `go_route` and Firebase - Flutter Project

This Flutter project demonstrates the implementation of deep linking using the `go_route` package, along with Firebase integration for managing posts (text, video, and image).

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK
- Firebase CLI
- A linked Firebase project with Firestore enabled

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/adityakumar-dev/inter-assignment
   ```
2. Navigate to the project directory:

    ```bash
    cd inter-assignment
    ```
3. Install the necessary dependencies:

    ```bash 
    flutter pub get
    ```
##
### Firebase Setup
1. Configure Firebase for your Flutter project:

    Run the FlutterFire CLI to configure Firebase:
        Firebase Setup
    ```bash 
    dart pub global activate flutterfire_cli
    flutterfire configure
    ```
2. Link your project to Firebase and set up Firestore:

    Ensure you have a Firestore database with the following structure:


    ```
    Posts
    ├── Text Posts
    │   ├── name: string
    │   └── desc: string
    ├── Video Posts
    │   ├── name: string
    │   └── url: string
    └── Image Posts
        ├── name: string
        └── url: string
    ```
##
### Running the App
Once the setup is complete, you can run the app on an emulator or a physical device:
```bash
    flutter run
```

##
### Thanks For Visiting