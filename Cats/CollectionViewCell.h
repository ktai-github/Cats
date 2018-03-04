//
//  CollectionViewCell.h
//  Cats
//
//  Created by KevinT on 2018-03-03.
//  Copyright © 2018 KevinT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
