//
//  ViewController.m
//  Cats
//
//  Created by KevinT on 2018-03-01.
//  Copyright © 2018 KevinT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loadButtonTapped:(id)sender {
  [self makeNetworkRequest];
}

- (void)makeNetworkRequest {
  NSString *urlString = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=3c526ed9d9e101c1083db43c436943d7&tags=cat";
  NSURL *url = [NSURL URLWithString:urlString];
  
  NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (error != nil) {
      return;
    }
    
    //    dispatch_async(dispatch_get_main_queue(), <#^(void)block#>)
    [self parseResponseData:data];
  }];
  [dataTask resume];
}

- (void)parseResponseData:(NSData *)data {
  NSError *error = nil;
  id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
  
  if (error != nil) {
//    dispatch_async(dispatch_get_main_queue(), <#^(void)block#>)
    return;
  }
  
  if ([jsonObj isKindOfClass:[NSDictionary class]]) {
    NSDictionary *jsonDict = (NSDictionary *)jsonObj;
    
    dispatch_async(dispatch_get_main_queue(), ^{
      NSLog(@"Retrieved dictionary: %@", jsonDict);
    });
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
