//
//  ContactGroup.h
//  contact1
//
//  Created by 谢谦 on 16/2/6.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactGroup : NSObject

@property (nonatomic,strong)NSString *groupName;
@property (nonatomic,strong)NSString *groupDetail;
@property (nonatomic,strong)NSMutableArray *contactPersons;

-(ContactGroup *)initWithGroupName:(NSString *)groupName withGroupDetail:(NSString *)groupDetail withContactPersons:(NSMutableArray *)contactPersons;

+(ContactGroup *)initWithGroupName:(NSString *)groupName withGroupDetail:(NSString *)groupDetail withContactPersons:(NSMutableArray *)contactPersons;

@end
