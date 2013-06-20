//
//  SearchSession.h
//  astarAppzMohamedHasan
//
//  Created by Mohammed Hasan on 6/19/13.
//  Copyright (c) 2013 Mohammed Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchSession : NSObject

@property(nonatomic)NSInteger current_page;
@property(nonatomic)NSInteger total_pages;
@property(nonatomic)NSInteger perpage;
@property(nonatomic)NSString* total_images;

@end
