//
//  ImagesGrabber.h
//  astarAppzMohamedHasan
//
//  Created by Mohammed Hasan on 6/19/13.
//  Copyright (c) 2013 Mohammed Hasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GrabberProtocol


-(void)did_finish_grabbingAll;
-(void)did_finish_grabbingImage:(NSData*)image;
@end


@interface ImagesGrabber : NSObject

@property(nonatomic)id<GrabberProtocol>GrabberDelegate;
@property(nonatomic,strong)NSMutableArray* images_list;

-(void)grabImagesFromList:(NSArray*)list;

@end
