//
//  User.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 22/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize email = email_;
@synthesize firstname = firstname_;
@synthesize password = password_;
@synthesize IdIphone = IdIphone_;
@synthesize lastName = lastName_;


#pragma instanciation of User
-(instancetype)init
{
    return [[User alloc] initWithName:@"" andLastName:@"" AndMailUser:@"" andPassUser:@"" andIdIphone:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
}

-(instancetype)initWithName:(NSString*)firstname andLastName :(NSString*)lastName  AndMailUser:(NSString*)mailUser andPassUser:(NSString*)passUser andIdIphone:(NSString*)idIphone
{
    if(self = [super init])
    {
        self.firstname = firstname;
        self.lastName = lastName;
        self.email = mailUser;
        self.password = passUser;
        IdIphone_ = idIphone;
    }
    return self;
}

-(instancetype)initWithMailUser:(NSString*)mailUser andPassUser:(NSString*)passUser
{
    return [[User alloc] initWithName:@"" AndMailUser:mailUser andPassUser:passUser];
}


-(instancetype)initWithName:(NSString*)UserName AndMailUser:(NSString*)mailUser andPassUser:(NSString*)passUser
{
    return [[User alloc] initWithName:UserName andLastName:@"" AndMailUser:mailUser andPassUser:passUser andIdIphone:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
}




-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.firstname = [aDecoder decodeObjectForKey:@"firstname"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.password = [aDecoder decodeObjectForKey:@"device_user"];
        token_ = [aDecoder decodeObjectForKey:@"token"];
    
    }
    return self;
}

-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.firstname forKey:@"firstname"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:IdIphone_ forKey:@"device_user"];
    [aCoder encodeObject:token_ forKey:@"token"];
}


#pragma Description of user
-(NSString*)description
{

    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[self getDictionary]];
    NSMutableString * parameter = [[NSMutableString alloc] init];
    
    for( NSString * key in dictionary)
    {
        [parameter appendFormat: @"%@ = %@ \n",key,[dictionary valueForKey:key]];
    }
    
    return parameter;
}

-(NSDictionary*)getDictionary
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class ], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:[self valueForKey:key] forKey:key];
    }

    free(properties);
    return dict;
}

-(NSData*)FormatForWebService
{
    NSError *error;
    NSMutableDictionary *dictionaire = [[NSMutableDictionary alloc] init];

    [dictionaire setValue:[self getDictionary] forKey:@"request_datas"];
    return [NSJSONSerialization dataWithJSONObject:dictionaire options:0 error:&error];
    
    
    //mettre dictionnaire
}

-(NSString*)FormatForGet
{
    
    int count = 0;
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[self getDictionary]];
    NSMutableString * parameter = [[NSMutableString alloc] init];
    
    for( NSString * key in dictionary)
    {
        if(count == 0)
        {
            [parameter appendString:@"?"];
        }
        [parameter appendFormat: @"%@=%@",key,[dictionary valueForKey:key]];
        count++;
        if(count < ([dictionary count] ))
        {
            [parameter appendString:@"&"];
        }
        
    }
    return parameter;
}

-(void)setPassword: (NSString*) password
{
        self.password = [self getSha1:password];
}


-(NSString*)getSha1:(NSString*) word
{
    
    const char *cstr = [word cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:word.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}


@end
