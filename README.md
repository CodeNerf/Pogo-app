# PoGo
## Table of contents

- Requirements
- Installation & Configuration
- Troubleshooting
- FAQ
- Maintainers

## Requirements

- Flutter installed on local machine: https://docs.flutter.dev/get-started/install

- Flutter Version >= 3.7.11 Required

- Flutter Doctor Output should look similar to:
  
```
[✓] Flutter (Channel stable, 3.7.11)


[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.1)

// Developing on MacOS
[✓] Xcode - develop for iOS and macOS (Xcode 14.3)

[✓] Chrome - develop for the web

[✓] Android Studio (version 2022.1)

[✓] VS Code (version 1.77.1)

[✓] Connected device

[✓] HTTP Host Availability
```

- Amplify CLI installed on local machine: https://docs.amplify.aws/cli/start/install/

- Access to the PoGo-Dev AWS Amplify Studio

- Access to the PoGo repository on Github: https://github.com/NMaass/PoGo

- Git installed on local machine: https://git-scm.com/downloads

- Git Version >= 2.39.2 Required

## Installation & Configuration

Steps for Installation

1. In the desired directory for project run: ```git clone https://github.com/NMaass/PoGo.git```

2. Pull the latest from AWS Amplify into your source code: ```amplify pull --appId d1atn630tbu1xc --envName dev```

3. Import Flutter Packages: ```flutter pub get```

4. Launch Application: ```flutter run```
    - If errors occur see Troubleshooting and FAQ

## Troubleshooting

I am receiving a pod file error on my iOS build

- Confirm that you are on the correct flutter version (run ```flutter upgrade``` to update). 
- Next cd into PoGo/ios
- Run ```pod update``` followed by ```pod install```.

I  am receiving a Linker command failed

- Confirm that you are on the correct flutter version (run ```flutter upgrade``` to update). 
- Next cd into PoGo/ios
- Run ```pod update``` followed by ```pod install```.

## FAQ

**Q:** I have Xcode installed how do I launch an iOS simulator?

**A:** ```open -a simulator```

**Q:** What are these API calls doing behind the scenes in awsFunctions.dart

**A:** Navigate to PoGo/API for lambda function code

## Code Maintainers

- Bandhan Preet Kaur - https://www.linkedin.com/in/bandhanpreet-kaur/
- Rifat Rodoshi - https://www.linkedin.com/in/rifat-rodoshi-686bbb230/
- Dominic Gueccia - https://www.linkedin.com/in/dominic-gueccia-966557271/
- Nicholas Maassen - https://www.linkedin.com/in/nicholas-maassen-63ab53187/
- Nicholas Farkas - https://www.linkedin.com/in/nicholas-farkas-097a6b157/