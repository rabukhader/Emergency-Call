
# Amank

Amank is a Flutter-based emergency call application that allows users to quickly contact emergency services like ambulances, civil defense, or police. The app calculates the user's location and connects them to the nearest service provider based on their selection. All emergency calls are recorded on an emergency dashboard.



## Features

- Emergency Service Selection: Users can choose between ambulance, civil defense, or police.
- Location-Based Calls: The app calculates the user’s location and automatically calls the nearest service of the selected type.
- Dashboard Recording: All calls are recorded and logged on an emergency dashboard for tracking.
- Firebase Integration: The app uses Firebase as its backend for data management and user authentication.
- User Types: The app supports two types of users, each with specific roles and functionalities.



## Installation

Clone the Repository:

```bash
  git clone https://github.com/rabukhader/Emergency-Call.git
```
    
  Navigate to the Project Directory:

```bash
  cd Emergency-Call

```    
Install Dependencies:
```bash
  flutter pub get

```   

Run the App:
```bash
  flutter run

```  
## Usage

- Grant Location Permissions: Upon the first launch, the app will request location permissions. Please ensure these permissions are granted for accurate functionality.

- Select Emergency Service: Choose between ambulance, civil defense, or police.

- Place Call: The app will automatically calculate your location and connect you to the nearest service provider.
- Dashboard Access: Authorized users can view and manage recorded emergency calls via the emergency dashboard.


## Contributing

    1. Fork the repository.
    2. Create a new branch (git checkout -b feature-branch).
    3. Make your changes.
    4. Commit your changes (git commit -m 'Add new feature').
    5. Push to the branch (git push origin feature-branch).
    6. Open a pull request.


## License

[MIT](https://choosealicense.com/licenses/mit/)

