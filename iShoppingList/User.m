//
//  User.m
//  iShoppingList
//
//  Created by thierry allard saint albin on 22/02/2015.
//  Copyright (c) 2015 Tasa&Fllo. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize mailUser = mailUser_;
@synthesize UserName = UserName_;
@synthesize passUser = passUser_;
@synthesize IdIphone = IdIphone_;


#pragma instanciation of User
-(instancetype)init
{
    return [[User alloc] initWithName:@"" AndMailUser:@"" andPassUser:@"" andIdIphone:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
}

-(instancetype)initWithName:(NSString*)UserName AndMailUser:(NSString*)mailUser andPassUser:(NSString*)passUser andIdIphone:(NSString*)idIphone
{
    if(self = [super init])
    {
        self.UserName = UserName;
        self.mailUser = mailUser;
        self.passUser = passUser;
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
    return [[User alloc] initWithName:UserName AndMailUser:mailUser andPassUser:passUser andIdIphone:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
}




-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.mailUser = [aDecoder decodeObjectForKey:@"mail_user"];
        self.UserName = [aDecoder decodeObjectForKey:@"name_user"];
        self.passUser = [aDecoder decodeObjectForKey:@"pass_user"];
        IdIphone_ = [aDecoder decodeObjectForKey:@"device_user"];
    
    }
    return self;
}
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.mailUser forKey:@"mail_user"];
    [aCoder encodeObject:self.UserName forKey:@"name_user"];
    [aCoder encodeObject:self.passUser forKey:@"pass_user"];
    [aCoder encodeObject:IdIphone_ forKey:@"device_user"];
}


#pragma Description of user
-(NSString*)description
{
    NSString* myString = [[NSMutableString alloc] initWithFormat:@"{ 'name_user' = '%@' , 'pass_user' = '%@' , 'device_user' = '%@' , 'mail_user' = '%@'", self.UserName, self.passUser, self.IdIphone,self.mailUser ];
    
    return myString;

}



@end
