//
//  NetConnect.h
//  OgraProject
//
//  Created by Mohammed Hasan on 10/7/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchSession.h"
#import "SBJson.h"

@protocol NetworkProtocol


-(void)did_finish_loadingwithData:(NSArray*)list andSession:(SearchSession*)session;
@end


Boolean success;
id<NetworkProtocol>NetWorkDelegate;
static NSString* searchtext;

@interface NetConnect : NSObject

@property(nonatomic)id<NetworkProtocol>NetWorkDelegate;
@property(nonatomic,strong)SearchSession* mySession ;


@property (nonatomic,retain)NSMutableData *responseData;
-(void)loadRequestWithSearchText:(NSString*)text andSession:(SearchSession*)session;
-(void)find_next;
+(void)setSearchText:(NSString*)text;
@end
