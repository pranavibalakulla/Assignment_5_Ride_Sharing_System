# Assignment 5: Ride Sharing System (C++ and Smalltalk)

A class-based ride sharing system implemented in C++ and Smalltalk (Pharo) to demonstrate encapsulation, inheritance and polymorphism.

## Files

| File | Description |
|---|---|
| `ride_sharing.cpp` | Complete C++ implementation and demo (`main`) |
| `RideSharingSystem.st` | Smalltalk class definitions: `Ride`, `StandardRide`, `PremiumRide`, `Driver`, `Rider` |
| `ride_sharing_playground.st` | Smalltalk demo script to run in a Pharo Playground |
| `screenshots/CPP_Code_Classes.png`, `screenshots/CPP_Code_Main.png` | C++ source code |
| `screenshots/CPP_Output.png` | C++ program output |
| `screenshots/Smalltalk_Code_*.png` | Smalltalk class definitions, methods and Playground script |
| `screenshots/Smalltalk_Output.png` | Smalltalk Transcript output |

## Class design

- **Ride** (abstract base): `rideID`, `pickupLocation`, `dropoffLocation`, `distance`; `fare()` and `rideDetails()`
- **StandardRide**: overrides `fare()` at $2.00 per mile
- **PremiumRide**: overrides `fare()` at $3.50 per mile
- **Driver**: `driverID`, `name`, `rating`, private `assignedRides`; `addRide()`, `getDriverInfo()`
- **Rider**: `riderID`, `name`, private `requestedRides`; `requestRide()`, `viewRides()`

## Running the C++ version

```
g++ -std=c++17 ride_sharing.cpp -o ride_sharing
./ride_sharing
```

## Running the Smalltalk version (Pharo)

1. Drag `RideSharingSystem.st` onto the Pharo window and choose **Install into the image**.
2. Open a Playground, paste the contents of `ride_sharing_playground.st`, select all and choose **Do it**.
3. Open the Transcript to see the output.

## OOP principles demonstrated

- **Encapsulation:** ride lists in `Driver` and `Rider` are private and change only through `addRide`/`requestRide`.
- **Inheritance:** `StandardRide` and `PremiumRide` inherit shared data and `rideDetails()` from `Ride`.
- **Polymorphism:** rides of different types are stored in one collection, and calling `fare()` / `rideDetails()` on each runs the subclass's own version.
