"ride_sharing_playground.st
 Demo script for the Ride Sharing System (Pharo).
 Load RideSharingSystem.st first, then paste this into a Playground,
 select all and choose 'Do it' (Ctrl+D). Output appears in the Transcript."

| driver rider rides |

Transcript clear.
Transcript show: '===== RIDE SHARING SYSTEM ====='; cr; cr.

"Create rides of different types and store them in ONE collection"
rides := OrderedCollection new.
rides
	add: (StandardRide new initializeRideID: 1001 pickup: 'Downtown' dropoff: 'Airport' distance: 10);
	add: (PremiumRide new initializeRideID: 1002 pickup: 'City Center' dropoff: 'University' distance: 8);
	add: (StandardRide new initializeRideID: 1003 pickup: 'Mall' dropoff: 'Hotel' distance: 5).

"Polymorphism: the same messages (rideDetails, fare) are sent to every ride;
 each object runs its own class's version of fare."
rides do: [ :ride | ride rideDetails ].

Transcript
	show: 'Total of all fares: $',
		((rides inject: 0 into: [ :sum :ride | sum + ride fare ]) printShowingDecimalPlaces: 2);
	cr; cr.

"Driver: rides can only be added through addRide:"
driver := Driver new.
driver driverID: 1; name: 'John Smith'; rating: 4.8.
driver addRide: (rides at: 1).
driver addRide: (rides at: 2).
driver getDriverInfo.

"Rider: rides can only be added through requestRide:"
rider := Rider new.
rider riderID: 101; name: 'Alice Brown'.
rider requestRide: (rides at: 1).
rider requestRide: (rides at: 2).
rider viewRides.
