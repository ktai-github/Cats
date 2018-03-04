//
//  Photo.m
//  Cats
//
//  Created by KevinT on 2018-03-01.
//  Copyright © 2018 KevinT. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithDict: (NSDictionary *) photo
{
  self = [super init];
  if (self) {
    NSNumber *farmID = photo[@"farm"];
    NSNumber *secret = photo[@"secret"];
    NSNumber *photoID = photo[@"id"];
    NSString *server = photo[@"server"];
    NSString *title = photo[@"title"];
    
    NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farmID, server, photoID, secret];
    NSLog(@"%@", urlString);
    NSLog(@"%@", title);

    _url = [NSURL URLWithString:urlString];
    _title = title;
  }
  return self;
}

@end
