#include <iostream>
#include <vector>
#include <string>
using namespace std;

// Base Ride class
class Ride {
protected:
    string rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance;

public:
    Ride(string id, string pickup, string dropoff, double dist)
        : rideID(id), pickupLocation(pickup),
          dropoffLocation(dropoff), distance(dist) {}

    virtual double fare() const = 0;

    virtual void rideDetails() const {
        cout << "Ride ID: " << rideID << endl;
        cout << "Pickup: " << pickupLocation << endl;
        cout << "Dropoff: " << dropoffLocation << endl;
        cout << "Distance: " << distance << " miles" << endl;
        cout << "Fare: $" << fare() << endl;
    }

    virtual ~Ride() {}
};

// Standard Ride
class StandardRide : public Ride {
public:
    StandardRide(string id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 2.00;
    }
};

// Premium Ride
class PremiumRide : public Ride {
public:
    PremiumRide(string id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    double fare() const override {
        return distance * 3.50;
    }
};

// Driver class
class Driver {
private:
    string driverID;
    string name;
    double rating;
    vector<Ride*> assignedRides;

public:
    Driver(string id, string driverName, double driverRating)
        : driverID(id), name(driverName), rating(driverRating) {}

    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        cout << "\nDriver Information" << endl;
        cout << "Driver ID: " << driverID << endl;
        cout << "Name: " << name << endl;
        cout << "Rating: " << rating << endl;
        cout << "Assigned Rides: " << assignedRides.size() << endl;
    }
};

// Rider class
class Rider {
private:
    string riderID;
    string name;
    vector<Ride*> requestedRides;

public:
    Rider(string id, string riderName)
        : riderID(id), name(riderName) {}

    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
    }

    void viewRides() const {
        cout << "\nRider: " << name << endl;
        cout << "Rider ID: " << riderID << endl;
        cout << "Requested Rides: " << requestedRides.size() << endl;

        for (Ride* ride : requestedRides) {
            ride->rideDetails();
            cout << "------------------------" << endl;
        }
    }
};

int main() {

    StandardRide ride1(
        "R001",
        "Downtown",
        "Airport",
        10
    );

    PremiumRide ride2(
        "R002",
        "City Center",
        "University",
        8
    );

    StandardRide ride3(
        "R003",
        "Mall",
        "Hotel",
        5
    );

    // Polymorphism
    vector<Ride*> rides = {
        &ride1,
        &ride2,
        &ride3
    };

    cout << "===== RIDE SHARING SYSTEM =====\n" << endl;

    for (Ride* ride : rides) {
        ride->rideDetails();
        cout << "------------------------" << endl;
    }

    Driver driver1("D001", "John Smith", 4.8);

    driver1.addRide(&ride1);
    driver1.addRide(&ride2);

    driver1.getDriverInfo();

    Rider rider1("R001", "Alice Brown");

    rider1.requestRide(&ride1);
    rider1.requestRide(&ride2);

    rider1.viewRides();

    return 0;
}