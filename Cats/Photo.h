//
//  Photo.h
//  Cats
//
//  Created by KevinT on 2018-03-01.
//  Copyright © 2018 KevinT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

@property (nonatomic) NSURL *url;
@property (nonatomic) NSString *title;

- (instancetype) initWithDict: (NSDictionary *) photo;

@end
