//
//  Facade.m
//  PocketStore
//
//  Created by Felipe Andrade on 11/30/12.
//  Copyright (c) 2012 i2 Mobile Solutions. All rights reserved.
//

#import "Facade.h"

__strong static Facade* instanceOf = nil;

@implementation Facade

@synthesize delegate;

// alloc and initializes the facade
+ (Facade*) getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceOf = [[Facade alloc] init];
    });
    return instanceOf;
}

- (id) init
{
    if (self == [super init]) {
        
    }
    return self;
}

// Get current directory name for data persistence
-(NSString *) directoryName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return documentsDirectory;
}

// save content for offline usage
-(BOOL) saveContentForOfflineUsageAtPath:(NSString *)path withContent:(NSString *)content
{
    NSError * error;
    NSString * filePath = [[self directoryName] stringByAppendingPathComponent: path];
    
    BOOL status = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(!status)
    {
        [self.delegate didFailWithError:error];
    }
    
    return status;
}

// load content from local directories to satisfy offline usage
-(NSData *) loadContentForOfflineUsageAtPath:(NSString *)path
{
    NSError *error;
    NSString *filePath = [[self directoryName] stringByAppendingPathComponent: path];
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath options:NSDataReadingUncached error:&error];
    
    if(error != nil)
    {
        [self.delegate didFailWithError:error];
    }
    
    return data;
}

// Query service for a given URL
- (void)queryService:(NSDictionary*)gets AndPost:(NSDictionary*)posts{
    
    //	[self testConection];
	
	NSString * url;
    
//    url = [self getUrlFromService:service];
    
	NSLog(@"---------------------------------------------------------------------->");
	
	// chaves do dictironary de parametros
	NSArray * keys = [gets allKeys];
//	NSLog(@"Facade-> URL string: %@",url);
//	NSLog(@"Gets:");
	for (int i=0; i<[keys count];i++) {
		
		NSString * key 		= [keys objectAtIndex:i];
		NSString * value 	= [gets objectForKey:key];
		
		url = [url stringByAppendingFormat:@"?%@",value];
		
//		NSLog(@"%@ = %@",key , value);
		
	}
	NSLog(@"---------------------------------------------------------------------->");
	
   	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url] options:NSDataReadingUncached error:&error];
    
        if(error != nil) {
            [self.delegate didFailWithError:error];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self fetchedData:data withUrl:url];
        });
    });
}

// Fetch data, save or load for offline or online usage, parse data
- (void)fetchedData:(NSData *)responseData withUrl:(NSString*)url
{
    NSString * filePath = [[[url stringByReplacingOccurrencesOfString:@"/" withString:@"+"]
                            stringByReplacingOccurrencesOfString:@":" withString: @"+"]
                           stringByReplacingOccurrencesOfString:@"." withString:@"+"];
    
    // if content loaded from URL
    if(responseData != nil)
    {
        
        NSString *content = [[NSString alloc] initWithBytes:[responseData bytes]
                                                     length:[responseData length]
                                                   encoding:NSUTF8StringEncoding];
        
        // save file for offline usage
        [self saveContentForOfflineUsageAtPath:filePath withContent: content];
        
        // parse content for service
        [self parse: responseData];
    } else {
        // if fail you should try to load the offline file
        NSData *dataFromFile = [self loadContentForOfflineUsageAtPath: filePath];
        
        if(dataFromFile != nil)
        {
            [self parse: dataFromFile];
        } else {
            [self.delegate didFailWithError:[NSError errorWithDomain:@"Error loading offline content" code:1 userInfo:nil]];
        }
    }
	
}

// parse data and delegate the results
- (void) parse:(NSData *)responseData
{
    
	NSError		 * error;
	id result 	= nil;
	NSDictionary 	* resultDic = nil;
	
	if(error != nil) {
		[self.delegate didFailWithError:error];
	} else {
        
		// fazer parser do json
//		result = [self parserJson:service AndObject:json];
        
		
		if( result )
			[delegate processSuccessful:YES dataReceived:result];
		else
			[delegate processSuccessful:YES dataReceived:resultDic];
	}
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (AFHTTPRequestOperationManager*)connect:(NSString*)urlString{
	
	urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	
	
	NSURL			* url			= [NSURL URLWithString:urlString];
	AFHTTPRequestOperationManager	* httpClient	= [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    [httpClient.requestSerializer setTimeoutInterval:10];
    
	
	return httpClient;
	
}

- (NSString*)isNull:(NSString*)myString{
	
	NSString * stringRetorno= @"";
	
	if( ![myString isEqual:[NSNull null]] ){
		stringRetorno = myString;
	}
	
	return stringRetorno;
	
}
@end
