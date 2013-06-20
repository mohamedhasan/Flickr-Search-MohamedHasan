//
//  ImagesGrabber.m
//  astarAppzMohamedHasan
//
//  Created by Mohammed Hasan on 6/19/13.
//  Copyright (c) 2013 Mohammed Hasan. All rights reserved.
//

#import "ImagesGrabber.h"

@implementation ImagesGrabber
@synthesize GrabberDelegate,images_list;


-(void)saveToPlist:(NSData *)data forKey:(NSString*)key{
    
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath= [rootPath stringByAppendingPathComponent:@"images.plist"];
    
    NSMutableDictionary *newRoot = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    
    NSMutableArray *img_list=[newRoot objectForKey:key];
    
    [img_list insertObject:data atIndex:img_list.count];
    
    [newRoot setObject:img_list forKey:key];
    
    [newRoot writeToFile:filePath atomically: YES];
    
    
    
    
    
}


-(void)grabImagesFromList:(NSArray*)list{

    images_list=[[NSMutableArray alloc]init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    

        
        
        
        for (int i=0; i<list.count; i++) {
            
            
                dispatch_async(queue, ^{
            
            NSDictionary *img_details=[list objectAtIndex:i];
            NSString *img_url=[[NSString alloc]initWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg",[img_details objectForKey:@"farm"],
                               [img_details objectForKey:@"server"],
                               [img_details objectForKey:@"id"],
                               [img_details objectForKey:@"secret"],Nil];
            NSData *img_data=[NSData dataWithContentsOfURL:[NSURL URLWithString:img_url]];
              
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        
                        [GrabberDelegate did_finish_grabbingImage:img_data];
                        
                        
                    });
                });
            
        }

        
     //  [GrabberDelegate did_finish_grabbingAll];



}
@end
