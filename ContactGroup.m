//
//  ContactGroup.m
//  contact1
//
//  Created by 谢谦 on 16/2/6.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import "ContactGroup.h"

@implementation ContactGroup

-(ContactGroup *)initWithGroupName:(NSString *)groupName withGroupDetail:(NSString *)groupDetail withContactPersons:(NSMutableArray *)contactPersons
{
    if (self = [super init]) {
        _groupName = groupName;
        _groupDetail = groupDetail;
        _contactPersons = contactPersons;
    }
    return self;

}

+(ContactGroup *)initWithGroupName:(NSString *)groupName withGroupDetail:(NSString *)groupDetail withContactPersons:(NSMutableArray *)contactPersons
{
    ContactGroup *group = [[ContactGroup alloc]initWithGroupName:groupName withGroupDetail:groupDetail withContactPersons:contactPersons];
    return group;

}


@end
