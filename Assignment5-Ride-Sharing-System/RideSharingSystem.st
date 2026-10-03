"RideSharingSystem.st
 Ride Sharing System - Smalltalk (Pharo) class definitions.
 Load into Pharo by dragging this file onto the Pharo window and choosing
 'Install into the image' (or File Browser > select file > 'Install').
 Demonstrates encapsulation, inheritance and polymorphism."!

Object subclass: #Ride
	instanceVariableNames: 'rideID pickupLocation dropoffLocation distance'
	classVariableNames: ''
	package: 'RideSharingSystem'!

!Ride commentStamp: '' prior: 0!
I am the abstract base class for every ride. I hold the details all rides share
(rideID, pickupLocation, dropoffLocation, distance). Subclasses must override
#fare to supply their own pricing. My instance variables are private and are
read only through the accessor methods below.!

Ride subclass: #StandardRide
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'RideSharingSystem'!

!StandardRide commentStamp: '' prior: 0!
I am an economy ride charged at $2.00 per mile.!

Ride subclass: #PremiumRide
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'RideSharingSystem'!

!PremiumRide commentStamp: '' prior: 0!
I am a premium ride charged at $3.50 per mile.!

Object subclass: #Driver
	instanceVariableNames: 'driverID name rating assignedRides'
	classVariableNames: ''
	package: 'RideSharingSystem'!

!Driver commentStamp: '' prior: 0!
I represent a driver. My list of assignedRides is private: rides can only be
added through #addRide:, and #assignedRides returns a copy so callers cannot
modify my internal list.!

Object subclass: #Rider
	instanceVariableNames: 'riderID name requestedRides'
	classVariableNames: ''
	package: 'RideSharingSystem'!

!Rider commentStamp: '' prior: 0!
I represent a rider. My requestedRides list is private and changes only
through #requestRide:.!


"---------------- Ride ----------------"!

!Ride methodsFor: 'initialization'!
initializeRideID: anID pickup: aPickup dropoff: aDropoff distance: aDistance
	"Set the shared ride details. Called once when a ride is created."
	rideID := anID.
	pickupLocation := aPickup.
	dropoffLocation := aDropoff.
	distance := aDistance! !

!Ride methodsFor: 'accessing'!
rideID
	^ rideID! !

!Ride methodsFor: 'accessing'!
pickupLocation
	^ pickupLocation! !

!Ride methodsFor: 'accessing'!
dropoffLocation
	^ dropoffLocation! !

!Ride methodsFor: 'accessing'!
distance
	^ distance! !

!Ride methodsFor: 'pricing'!
fare
	"Abstract method: every subclass must provide its own fare calculation."
	^ self subclassResponsibility! !

!Ride methodsFor: 'pricing'!
rideType
	"Overridden by subclasses to name the kind of ride."
	^ 'Ride'! !

!Ride methodsFor: 'printing'!
rideDetails
	"Print this ride to the Transcript. 'self fare' and 'self rideType' are
	 resolved at run time, so each subclass prints its own type and price."
	Transcript
		show: 'Ride ID: ', rideID printString; cr;
		show: 'Type: ', self rideType; cr;
		show: 'Pickup: ', pickupLocation; cr;
		show: 'Dropoff: ', dropoffLocation; cr;
		show: 'Distance: ', distance printString, ' miles'; cr;
		show: 'Fare: $', (self fare printShowingDecimalPlaces: 2); cr;
		show: '------------------------'; cr! !

!Ride methodsFor: 'printing'!
printOn: aStream
	"Readable one-line form, e.g. 'PremiumRide #1002 (Mall -> University)'."
	aStream
		nextPutAll: self class name;
		nextPutAll: ' #';
		print: rideID;
		nextPutAll: ' (';
		nextPutAll: pickupLocation;
		nextPutAll: ' -> ';
		nextPutAll: dropoffLocation;
		nextPut: $)! !


"---------------- StandardRide ----------------"!

!StandardRide methodsFor: 'pricing'!
fare
	"Override: standard rides cost $2.00 per mile."
	^ distance * 2! !

!StandardRide methodsFor: 'pricing'!
rideType
	^ 'Standard'! !


"---------------- PremiumRide ----------------"!

!PremiumRide methodsFor: 'pricing'!
fare
	"Override: premium rides cost $3.50 per mile."
	^ distance * 3.5! !

!PremiumRide methodsFor: 'pricing'!
rideType
	^ 'Premium'! !


"---------------- Driver ----------------"!

!Driver methodsFor: 'initialization'!
initialize
	super initialize.
	assignedRides := OrderedCollection new! !

!Driver methodsFor: 'accessing'!
driverID
	^ driverID! !

!Driver methodsFor: 'accessing'!
driverID: anID
	driverID := anID! !

!Driver methodsFor: 'accessing'!
name
	^ name! !

!Driver methodsFor: 'accessing'!
name: aName
	name := aName! !

!Driver methodsFor: 'accessing'!
rating
	^ rating! !

!Driver methodsFor: 'accessing'!
rating: aNumber
	"Only accept ratings between 0 and 5."
	(aNumber between: 0 and: 5)
		ifFalse: [ ^ self error: 'Rating must be between 0 and 5' ].
	rating := aNumber! !

!Driver methodsFor: 'accessing'!
assignedRides
	"Return a copy so the private list cannot be changed from outside."
	^ assignedRides copy! !

!Driver methodsFor: 'rides'!
addRide: aRide
	"The only way to add a ride to this driver's private list."
	assignedRides add: aRide! !

!Driver methodsFor: 'printing'!
getDriverInfo
	"Print the driver's details and the rides assigned to them."
	Transcript
		show: 'Driver Information'; cr;
		show: 'Driver ID: ', driverID printString; cr;
		show: 'Name: ', name; cr;
		show: 'Rating: ', rating printString; cr;
		show: 'Assigned Rides: ', assignedRides size printString; cr.
	assignedRides do: [ :ride |
		Transcript show: '  - ', ride printString; cr ].
	Transcript cr! !


"---------------- Rider ----------------"!

!Rider methodsFor: 'initialization'!
initialize
	super initialize.
	requestedRides := OrderedCollection new! !

!Rider methodsFor: 'accessing'!
riderID
	^ riderID! !

!Rider methodsFor: 'accessing'!
riderID: anID
	riderID := anID! !

!Rider methodsFor: 'accessing'!
name
	^ name! !

!Rider methodsFor: 'accessing'!
name: aName
	name := aName! !

!Rider methodsFor: 'accessing'!
requestedRides
	"Return a copy so the private list cannot be changed from outside."
	^ requestedRides copy! !

!Rider methodsFor: 'rides'!
requestRide: aRide
	"The only way to add a ride to this rider's private list."
	requestedRides add: aRide! !

!Rider methodsFor: 'printing'!
viewRides
	"Print the rider's ride history; each ride prints its own details."
	Transcript
		show: 'Rider: ', name; cr;
		show: 'Rider ID: ', riderID printString; cr;
		show: 'Requested Rides: ', requestedRides size printString; cr;
		show: '------------------------'; cr.
	requestedRides do: [ :ride | ride rideDetails ]! !
