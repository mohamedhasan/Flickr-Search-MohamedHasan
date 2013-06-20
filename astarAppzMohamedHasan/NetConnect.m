//
//  NetConnect.m
//  OgraProject
//
//  Created by Mohammed Hasan on 10/7/12.
//  Copyright (c) 2012 Mohammed Hasan. All rights reserved.
//

#import "NetConnect.h"

@implementation NetConnect
@synthesize responseData,NetWorkDelegate,mySession;
-(void)dealloc{


}
-(void)loadRequestWithSearchText:(NSString*)text andSession:(SearchSession*)session{

    mySession=session;
    responseData=[NSMutableData data];
    searchtext=text;
    
    NSString *str=[[NSString alloc]initWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e1f16e06b2e1b06fbdff4b425af3cff1&text=%@&format=json&nojsoncallback=1&per_page=%d&page=%d",text,session.perpage,session.current_page];
    
    NSLog(@"url :%@",str);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}
-(void)find_next{

    responseData=[NSMutableData data];
    
    
    NSString *str=[[NSString alloc]initWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e1f16e06b2e1b06fbdff4b425af3cff1&text=%@&format=json&nojsoncallback=1&per_page=%d&page=%d",searchtext,mySession.perpage,mySession.current_page];
    
    NSLog(str);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];


}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    NSLog(@"the response in %d",responseStatusCode);

   
   [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
        
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"error in connection" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSString *str=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    // parse the JSON string into an object - assuming json_string is a NSString of JSON data
    NSDictionary *results = [parser objectWithString:str];
    
    NSDictionary *search_parms=[results objectForKey:@"photos"];
    
    NSString *temp;
    mySession.total_images=(NSString*)[search_parms objectForKey:@"total"];
    mySession.current_page=(NSInteger)[search_parms objectForKey:@"page"];
    
    temp=(NSString*)[search_parms objectForKey:@"perpage"];
    mySession.perpage=[temp intValue];
    
    temp=(NSString*)[search_parms objectForKey:@"pages"];
    mySession.total_pages=[temp intValue];

   NSArray* images= (NSArray*)[search_parms objectForKey:@"photo"];
    
    NSLog(@"details %@",search_parms);
    
    [NetWorkDelegate did_finish_loadingwithData:images andSession:mySession];

    
        
}

+(void)setSearchText:(NSString*)text{
    
    searchtext=text;


}


@end
