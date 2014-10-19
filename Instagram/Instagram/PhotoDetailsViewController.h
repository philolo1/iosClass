//
//  PhotoDetailsViewController.h
//  Instagram
//
//  Created by Patrick Klitzke on 10/15/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (nonatomic, strong) NSDictionary *photo;
@end
