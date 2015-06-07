//
//  FISAppDelegate.m
//  locationTrivia-Dictionaries
//
//  Created by Joe Burgess on 5/14/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISAppDelegate.h"

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//  *************
//  +++++++++++++
//  *************

//  You could also use substringToIndex, or just set the element[length+1] = nil.
-(NSString *)shortenLocationNameWithLocation:(NSDictionary*)location ToCount:(NSInteger)newMaxLength
{
    if (newMaxLength < 0) {
        return location[@"name"];
    }
    
    NSString *longName = location[@"name"];
    NSMutableString *shortName = [NSMutableString stringWithString:longName];
    [shortName deleteCharactersInRange:NSMakeRange(newMaxLength, ([longName length] - newMaxLength))];
    return [shortName copy];
}

-(NSDictionary *)createLocationWithName:(NSString*)locName Latitude:(NSNumber*)lat Longitude:(NSNumber*)lng
{
    NSArray *categoryKeys   = @[@"name", @"longitude", @"latitude"];
    NSArray *locationValues = @[locName,          lng,        lat ];
    NSDictionary *locationEntry = [NSDictionary dictionaryWithObjects:locationValues forKeys:categoryKeys];
  
    return locationEntry;
}

-(NSArray *)getLocationNamesWithLocations:(NSArray *)locationList
{   //refactored version:
    return [locationList valueForKey:@"name"];
    
//    This was my first version (successful):
//    ###########
//    NSMutableArray *locationNames = [[NSMutableArray alloc] init];
//
//    for (NSDictionary *locationEntry in locationList) {
//        [locationNames addObject:locationEntry[@"name"]];
//    }
//
//    return [locationNames copy];
}

-(BOOL)verifyLocation:(NSDictionary*)locationEntry
{
    BOOL theKeysMatch;
    BOOL theEntryIsFilledIn;
    
    NSSet *setOfProperKeys  =  [NSSet setWithArray: @[@"name", @"longitude", @"latitude"]];
    NSSet *setOfLocationEntryKeys = [NSSet setWithArray:[locationEntry allKeys]];
    
    if ([setOfProperKeys isEqualToSet: setOfLocationEntryKeys]) {
        theKeysMatch = YES;
    } else {
        theKeysMatch = NO;
    }
    
    if ([setOfLocationEntryKeys count] == [locationEntry count]) {
        theEntryIsFilledIn = YES;
    } else {
        theEntryIsFilledIn = NO;
    }
    
    return (theEntryIsFilledIn && theKeysMatch);
}

-(NSDictionary*)searchForLocationName:(NSArray*)locationsList inLocations:(NSString*)chosenLocation
{
//    NSArray *locationNamesOnlyList = [locationsList valueForKey: @"name"]; //ty, Monolo(github)
//    BOOL locationIsInList = [locationNamesOnlyList containsObject:chosenLocation];

    NSSet *locationsListAsNSSet = [NSSet setWithArray:locationsList];
//    NSMutableDictionary *searchResult = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *location in locationsListAsNSSet) {
        if ([location[@"name"] isEqualToString:chosenLocation]) {
            return location;
        }
    }
    return nil;

//    if (locationIsInList) {
//        locationsListAsNSSet[chosenLocation];
//    }

//    return [searchResult copy];
}

@end
