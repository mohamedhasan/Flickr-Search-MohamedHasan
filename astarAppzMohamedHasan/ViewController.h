//
//  ViewController.h
//  astarAppzMohamedHasan
//
//  Created by Mohammed Hasan on 6/17/13.
//  Copyright (c) 2013 Mohammed Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetConnect.h"

#import "Results.h"




@interface ViewController : UIViewController<NetworkProtocol,UITextFieldDelegate>

@property(nonatomic)IBOutlet UITextField* textSearch;
@property (nonatomic)SearchSession *session;
-(IBAction)searchButton:(id)sender;

@end
