//
//  Results.h
//  astarAppzMohamedHasan
//
//  Created by Mohammed Hasan on 6/17/13.
//  Copyright (c) 2013 Mohammed Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellImage.h"
#import "ImagesGrabber.h"
#import "NetConnect.h"

@interface Results : UICollectionViewController<GrabberProtocol,NetworkProtocol>


@property (nonatomic,strong)IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) NSArray *img_list;
@property (strong, nonatomic) NSMutableArray *buffer;
@property(strong,nonatomic)SearchSession* mysession;
@property(strong,nonatomic)IBOutlet UIBarButtonItem *buttonMore;
-(IBAction)moreImages:(id)sender;

@end
