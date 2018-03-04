//
//  ViewController.m
//  Cats
//
//  Created by KevinT on 2018-03-01.
//  Copyright © 2018 KevinT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSMutableArray *photoMutArray;
//@property (weak, nonatomic) IBOutlet UICollectionViewCell *collectionViewCell;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;

@end

@implementation ViewController

//- (void)viewDidLoad {
//  [super viewDidLoad];
//  // Do any additional setup after loading the view, typically from a nib.
//  self.collectionView.dataSource = self;
//
//- (void)makeNetworkRequest {
//  self.photoMutArray = [NSMutableArray array];
//
//  NSString *flickURLString = @"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=ef4d8941b6daa978364ffd6588d1810e&tags=cat";
//
//  NSURLSession *session = [NSURLSession sharedSession];
//
//  NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:flickURLString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//    NSError *error2 = nil;
//
//    NSDictionary *rootPhotoDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error2];
//
//    NSDictionary *photosDict = rootPhotoDict[@"photos"];
//
//    NSArray *photosArray = photosDict[@"photo"];
//
//    for (NSDictionary *photo in photosArray){
//      NSLog(@"photo is %@", photo);
//
//      Photo *photoObject = [[Photo alloc] initWithDict:photo];
//
//      [self.photoMutArray addObject:photoObject];
//
//    }
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//      [self.collectionView reloadData];
//    });
//
//
//  }];
//
//  [dataTask resume];
//
//  NSLog(@"outside completionHandler");
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.dataSource = self;
}

- (IBAction)loadButtonTapped:(id)sender {
  [self makeNetworkRequest];
}

- (void)makeNetworkRequest {
  self.photoMutArray = [[NSMutableArray alloc] init];
  
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


//      NSLog(@"Retrieved dictionary: %@", jsonDict);

//      json structure
//      top level - dictionary of objects
    NSDictionary *photosDict = [jsonDict objectForKey:@"photos"];

//      2nd level - dictionary of stats objects
    NSArray *photoArray = [photosDict objectForKey:@"photo"];

//      3rd level - array of photo objects
//      4th level - dictionary of photo fields
    for (NSDictionary *photo in photoArray) {

      Photo *photoObj = [[Photo alloc] initWithDict:photo];

      [self.photoMutArray addObject:photoObj];

    }

    dispatch_async(dispatch_get_main_queue(), ^{
      //reload data in collection view
      [self.collectionView reloadData];
    });
  }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.photoMutArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
  
  NSURLSession *session = [NSURLSession sharedSession];
  
  Photo *photo = self.photoMutArray[indexPath.row];
  
  cell.downloadTask = [session downloadTaskWithURL:photo.url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    UIImage *image = [UIImage imageWithData:data];
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
      cell.photoImageView.image = image;
      cell.titleLabel.text = photo.title;
    });
  }];
  
  [cell.downloadTask resume];
  
  return cell;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

