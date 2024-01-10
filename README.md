## ProPresence

ProPresence, a face recognition application built with flutter and python to ease the employee check in and check out with minimal interface.

## Interface
<table>
  <tr>
    <td><img src="https://raw.githubusercontent.com/visveshkhanna/ProPresence/main/assets/checkin.png" alt="Check In"></td>
    <td><img src="https://raw.githubusercontent.com/visveshkhanna/ProPresence/main/assets/checkout.png" alt="Check Out"></td>
  </tr>
</table>

## BP
<img src="https://raw.githubusercontent.com/visveshkhanna/ProPresence/main/assets/1_dd8.png" alt="blueprint" />

## Features
- Has live camera where users can scan their face by clicking either of the buttons.
- Used to check in and check out from the office with facial recognition
- Uses face recognition api from python, and fast api as the backend server.
- Train all the employee pictures with the employee data
- Easy to add training data
- Faster training

## Installation
To install the app, follow these steps:

1. Clone the repository to your local machine.
2. Open the project in Android Studio or Visual Studio Code.
3. Run the app on an emulator or a physical device.

## Dependencies
1. Flutter
2. Dart
3. Python
4. face_recognition
5. fastapi

## Setup
To setup the app, follow these steps:

- Add the necessary employee details in the json file and add the images accordingly in the db/images
- Make changes to the code as you need
- Run the backend/main.py file to start the backend server.
- Get the url and change it in the api.dart file in the lib section
- Compile / build the apk
- Use it and enjoy.

## Credits
This app was developed by [Visvesh Khanna](https://github.com/visveshkhanna), with the help of the following resources:

1. [Flutter](https://docs.flutter.dev)
2. [Dart](https://dart.dev/guides)
3. [face_recognition](https://github.com/ageitgey/face_recognition)
4. [fastapi](https://github.com/tiangolo/fastapi)

## Image Credits
The image shown in the screen shot is [Emma Watson](https://www.instagram.com/emmawatson)

## License
This app is licensed under the <a href="https://github.com/visveshkhanna/ProPresence/LICENCE">MIT License</a>.
