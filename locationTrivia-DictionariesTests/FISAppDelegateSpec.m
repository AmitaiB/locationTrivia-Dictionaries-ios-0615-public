//
//  FISAppDelegateSpec.m
//  locationTrivia-Dictionaries
//
//  Created by Joe Burgess on 5/14/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import <Expecta.h>
#import "FISAppDelegate.h"


SpecBegin(FISAppDelegate)

describe(@"FISAppDelegate", ^{
    __block FISAppDelegate *appDelegate;
    __block NSDictionary *location;
    __block NSDictionary *location2;
    __block NSDictionary *location3;
    __block NSArray *locationsArray;
    beforeAll(^{
        appDelegate = [[FISAppDelegate alloc] init];
        location = @{@"name":@"Empire State Building",
                     @"latitude":@23.432,
                     @"longitude":@-34.34
                     };
        location2 = @{@"name":@"The Flatiron School",
                                    @"latitude":@34.432,
                                    @"longitude":@-23.67
                                    };
        location3 = @{@"name":@"Statue Of Liberty",
                                    @"latitude":@78.34,
                                    @"longitude":@92.42
                                    };
        locationsArray = @[location,location2,location3];
    });
    
    beforeEach(^{

    });

    describe(@"Shorten Location Name", ^{
        it(@"Should have a method called shortenLocationNameWithLocation:toCount:", ^{
            expect(appDelegate).to.respondTo(@selector(shortenLocationNameWithLocation:toCount:));
        });

        it(@"Should return an NSString", ^{
            expect([appDelegate shortenLocationNameWithLocation:location ToCount:5]).to.beKindOf([NSString class]);
        });

        it(@"Should shorten Location Name to 5 characters", ^{
            NSString *shortenedName =[appDelegate shortenLocationNameWithLocation:location ToCount:5];
            expect([shortenedName length]).to.equal(5);
        });

        it(@"Should handle negative numbers by returning the same string", ^{
            NSString *shortenedName =[appDelegate shortenLocationNameWithLocation:location ToCount:-5];
            expect(shortenedName).to.equal(location[@"name"]);
        });
    });

    describe(@"Create Location NSDictionary", ^{
        it(@"Should have a method called createLocationWithName:Latitude:Longitude", ^{
            expect(appDelegate).to.respondTo(@selector(createLocationWithName:Latitude:Longitude:));
        });

        it(@"Should create an appropriate NSDictionary", ^{
            NSDictionary *returnLocation = [appDelegate createLocationWithName:@"The Flatiron School" Latitude:@34.432 Longitude:@-23.67];
            expect(returnLocation).to.equal(location2);
        });

        it(@"should return an NSDictionary", ^{
            expect([appDelegate createLocationWithName:@"The Flatiron School" Latitude:@34.432 Longitude:@-23.67]).to.beKindOf([NSDictionary class]);
        });
    });

    describe(@"Get Location Names With Location", ^{
        it(@"Should have a method called getLocationNamesWithLocations", ^{
            expect(appDelegate).to.respondTo(@selector(getLocationNamesWithLocations:));
        });

        it(@"Should get the locations", ^{
            NSArray *locationNames = [appDelegate getLocationNamesWithLocations:locationsArray];
            expect(locationNames).to.contain(location[@"name"]);
            expect(locationNames).to.contain(location2[@"name"]);
            expect(locationNames).to.contain(location3[@"name"]);
        });

        it(@"Should return an NSArray", ^{
            expect([appDelegate getLocationNamesWithLocations:locationsArray]).to.beKindOf([NSArray class]);
        });
    });

    describe(@"Verify Location", ^{
        it(@"Should have a method called verifyLocation", ^{
            expect(appDelegate).to.respondTo(@selector(verifyLocation:));
        });

        it(@"Should return YES for a correct location", ^{
            expect([appDelegate verifyLocation:location3]).to.beTruthy();
        });

        it(@"Should return NO for a location with incorrect keys", ^{
            NSDictionary *badLocation = @{@"asdf":@"asdf",
                                          @"asdasdff":@"asdf",
                                          @"iwir":@"asdf"};
            expect([appDelegate verifyLocation:badLocation] ).to.beFalsy();
        });

        it(@"Should return NO for a location with not enough keys", ^{
            NSDictionary *badLocation = @{@"name":@"asdf",
                                          @"latitude":@"asdf"
                                          };
            expect([appDelegate verifyLocation:badLocation] ).to.beFalsy();
        });

        it(@"Should return NO for a location with extra keys", ^{
            NSDictionary *badLocation = @{@"name":@"asdf",
                                          @"latitude":@"asdf",
                                          @"longitude":@"asf",
                                          @"otherThing":@"aiwef"};
            expect([appDelegate verifyLocation:badLocation] ).to.beFalsy();
        });
    });

    describe(@"Search for Location Name", ^{
        it(@"Should have a method called searchForLocationName:inLocations:", ^{
            expect(appDelegate).to.respondTo(@selector(searchForLocationName:inLocations:));
        });

        it(@"Should return an NSDictionary", ^{
            expect([appDelegate searchForLocationName:@"The Flatiron School" inLocations:locationsArray]).to.beKindOf([NSDictionary class]);
        });

        it(@"Should return the appropriate NSDictionary Location", ^{
            NSDictionary *returnedLocation = [appDelegate searchForLocationName:@"The Flatiron School" inLocations:locationsArray];
            expect(returnedLocation).to.equal(location2);
        });

        it(@"Should return nil if no location is found", ^{
            NSDictionary *returnedLocation = [appDelegate searchForLocationName:@"BAD LOCATION" inLocations:locationsArray];
            expect(returnedLocation).to.beNil();
        });
    });
   
});

SpecEnd
