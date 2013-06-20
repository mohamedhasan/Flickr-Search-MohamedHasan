//
//  ViewController.m
//  astarAppzMohamedHasan
//
//  Created by Mohammed Hasan on 6/17/13.
//  Copyright (c) 2013 Mohammed Hasan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize textSearch,session;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)searchButton:(id)sender{

    NetConnect *net=[[NetConnect alloc]init];
    net.NetWorkDelegate=self;
    
    session=[[SearchSession alloc]init];
    

    session.current_page=1;
    session.perpage=6;


    
    [net loadRequestWithSearchText:[textSearch text]andSession:session];
    


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];



}

-(void)did_finish_loadingwithData:(NSArray*)list andSession:(SearchSession*)session{

    
        
    UIStoryboard *sb=[self storyboard];
    Results *res=[sb instantiateViewControllerWithIdentifier:@"Results"];
    res.img_list=list;
    res.mysession=session;
    
   [self.navigationController pushViewController:res animated:YES];
    
    
    NSLog(list.description);
    
    
    


}

@end
