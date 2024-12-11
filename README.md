# Fiscus: Set Up
## 1. Install VS Code
  https://code.visualstudio.com/docs/setup/windows
  
## 2. Install Flutter and Android Studio.
  https://docs.flutter.dev/get-started/install/windows/mobile
  
  Run this command in the command line to check if Flutter is install correctly
  ```
  flutter doctor
  ```

  Please make sure that Flutter is install correctly to run the repository. Pay attention to setting System and User Environment Variables as well as Android SDK set up.
  
  Note that for our version of Flutter, you should have jdk 17 as the default. Replace <jdk-path> with jdk 17's path on your computer to set it for this repository
  ```
  flutter config --jdk-dir=<jdk-path>
  ```
  Example
  ```
  flutter config --jdk-dir="C:\Program Files\Java\jdk-17"
  ```
## 3. Running the front end
### Creating emulator
  1. Input Ctrl + Shift + P to open the Command Pallete
  2. Choose Flutter: Select Device
  3. Choose Create Android Emulator
  4. After it's created select it
It should show that flutter emulator is selected like this
![image](https://github.com/user-attachments/assets/8441f5cc-55c4-4ef0-8f36-f4df73400899)

### Running the front end
Under /lib, press F5 while viewing any .dart file to enter debug mode. Select Fiscus in the android emulator to run the app.

## 4. Scan Receipt Testing
To test the scan receipt feature, you're required to run the back end. Clone this repo and follow the instruction there to set up the back end 
https://github.com/shinychikapu/ScanReceiptBackEnd

## 5. Troubleshooting 
1. To rebuild project do
 ```
 flutter clean
 flutter pub get
 ```

