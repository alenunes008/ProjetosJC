//
//  FacadeUtil.m
//  Blopper
//
//  Created by Wagner Sales on 10/28/13.
//  Copyright (c) 2013 Neto Leal. All rights reserved.
//

#import "FacadeUtil.h"

@implementation FacadeUtil

- (NSString*)isNull:(NSString*)myString{
	
	NSString * stringRetorno= @"";
	
	if( ![myString isEqual:[NSNull null]] ){
		if( [myString isKindOfClass:[NSString class]] )
			stringRetorno = myString;
	}
	
	return stringRetorno;
	
}

-(NSString*)transformarCampoNULLstring :(id)campo{
    
    NSString *retorno = @"";
    ([campo isEqual:nil] ) ? (retorno = @"") : (retorno = [NSString stringWithFormat:@"%@",campo]);
    return retorno;
}

- (NSDate *)strForDate:(NSString *)data {
    NSArray *strData = [data componentsSeparatedByString:@"."];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:strData[0]];
    return date;
}

@end
