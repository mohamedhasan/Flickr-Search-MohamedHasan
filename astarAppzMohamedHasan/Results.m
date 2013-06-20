//
//  Results.m
//  astarAppzMohamedHasan
//
//  Created by Mohammed Hasan on 6/17/13.
//  Copyright (c) 2013 Mohammed Hasan. All rights reserved.
//

#import "Results.h"

@interface Results ()

@end

@implementation Results

@synthesize img_list,mysession,buffer,indicator,buttonMore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     buffer =[[NSMutableArray alloc]init];
    self.navigationItem.title=[[NSString alloc]initWithFormat:@"%@ Images Found",mysession.total_images ];
    
        
}

-(void)viewDidAppear:(BOOL)animated
{
    [self becomeFirstResponder];    
    [self loadnextPage];

            
    
}
-(void)loadnextPage{
    
    
    indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.color=[UIColor blackColor];
    indicator.hidden=NO;
    int w=self.collectionView.frame.size.width/2;
    int h= self.collectionView.frame.size.height/2;
    indicator.center=CGPointMake(w, h);
    [ self.view addSubview:indicator ];
    [indicator startAnimating];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible: YES]
    ;
    [buttonMore setEnabled:NO];

    
    ImagesGrabber *grabber=[[ImagesGrabber alloc]init];
    grabber.GrabberDelegate=self;
    [grabber grabImagesFromList:img_list];


}



-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    
    return buffer.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellImage *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                    forIndexPath:indexPath];
    
    
           
        UIImage *image = [UIImage imageWithData:[buffer objectAtIndex:indexPath.row]];
        myCell.img.image = image;
    
    

    
    return myCell;
}

-(void)did_finish_grabbingImage:(NSData*)image{
    
    [buffer insertObject:image atIndex:buffer.count ];
    
    NSLog(@" count  : %d perpage : %d",buffer.count,mysession.perpage );
    
    
   
    if(buffer.count%mysession.perpage==0)
    {
        [indicator stopAnimating];
        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible: YES]
        ;
        [buttonMore setEnabled:YES];
         
    }
    [self.collectionView reloadData];



}
-(void)did_finish_loadingwithData:(NSArray*)list andSession:(SearchSession*)session{
    
    img_list=list;
    mysession=session;
    NSLog(@"delegate function called list :%d",list.count);
    [self loadnextPage];
    
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.subtype == UIEventSubtypeMotionShake)
	{
        NSLog(@"did shake");
		[self.navigationController popToRootViewControllerAnimated:YES];
	}
}

-(IBAction)moreImages:(id)sender{


    if(mysession.total_images.intValue>buffer.count)
    {
        
        NetConnect *network=[[NetConnect alloc]init];
        network.NetWorkDelegate=self;
        mysession.current_page+=1;
        network.mySession=mysession;
        [network find_next];
        

    
    }
    else
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"No more images" message:@""delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
        
        [alert show];
    
    
    }
    
    


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
