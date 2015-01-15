//
//  APSocialContact.m
//  SyncBook
//
//  Created by David on 2014-08-01.
//  Copyright (c) 2014 David Muzi. All rights reserved.
//

#import "APSocialProfile.h"
#import <AddressBook/AddressBook.h>

@interface APSocialProfile ()
@property (nonatomic, readwrite) APSocialNetworkType socialNetwork;
@property (nonatomic, readwrite) NSString *username;
@property (nonatomic, readwrite) NSString *userIdentifier;
@property (nonatomic, readwrite) NSURL *url;
@end

@implementation APSocialProfile

#pragma mark - life cycle

- (instancetype)initWithSocialDictionary:(NSDictionary *)dictionary
{
    
    if (self = [super init])
    {
        NSString *urlKey = (__bridge_transfer NSString *)kABPersonSocialProfileURLKey;
        NSString *usernameKey = (__bridge_transfer NSString *)kABPersonSocialProfileUsernameKey;
        NSString *userIdKey = (__bridge_transfer NSString *)kABPersonSocialProfileUserIdentifierKey;
        NSString *serviceKey = (__bridge_transfer NSString *)kABPersonSocialProfileServiceKey;
        _url = [NSURL URLWithString:dictionary[urlKey]];
        _username = dictionary[usernameKey];
        _userIdentifier = dictionary[userIdKey];
        _socialNetwork = [self socialNetworkTypeFromString:dictionary[serviceKey]];
    }
    
    return self;
}

#pragma mark - private

- (APSocialNetworkType)socialNetworkTypeFromString:(NSString *)string
{
    if ([string isEqualToString:@"facebook"])
    {
        return APSocialNetworkFacebook;
    }
    else if ([string isEqualToString:@"twitter"])
    {
        return APSocialNetworkTwitter;
    }
    else if ([string isEqualToString:@"linkedin"])
    {
        return APSocialNetworkLinkedIn;
    }
    else
    {
        return APSocialNetworkUnknown;
    }
}

#pragma mark - helper

- (NSDictionary *) serialize {
    
    NSString *serializedSocialNetwork;
    NSString *serializedUsername = @"";
    NSString *serializedUserIdentifier = @"";
    NSString *serializedUrl = @"";
    
    switch (_socialNetwork) {
            
        case APSocialNetworkFacebook:
            serializedSocialNetwork = @"facebook";
            break;
        case APSocialNetworkTwitter:
            serializedSocialNetwork = @"twitter";
            break;
        case APSocialNetworkLinkedIn:
            serializedSocialNetwork = @"linkedin";
            break;
        default:
            serializedSocialNetwork = @"unknown";
            break;
    }
    
    if (_username != nil) {
        serializedUsername = _username;
    }
    
    if (_userIdentifier != nil) {
        userIdentifier = _userIdentifier;
    }
    
    if (_url != nil && _url.absoluteString != nil) {
        serializedUrl = _url.absoluteString;
    }
    
    NSDictionary *result = @{@"social_network"  : serializedSocialNetwork,
                             @"username"        : serializedUsername,
                             @"user_identifier" : serializedUserIdentifier,
                             @"url"             : serializedUrl }

    return result;
}

@end
