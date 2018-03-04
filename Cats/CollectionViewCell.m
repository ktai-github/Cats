//
//  CollectionViewCell.m
//  Cats
//
//  Created by KevinT on 2018-03-03.
//  Copyright © 2018 KevinT. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void) prepareForReuse {
  [super prepareForReuse];
  [self.downloadTask cancel];
  self.photoImageView.image = nil;
  
}

@end
