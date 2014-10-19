//
//  MovieViewController.h
//  rottentomatoes
//
//  Created by Patrick Klitzke on 10/14/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *networkErrorView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *movieIconView;
@property (weak, nonatomic) IBOutlet UIImageView *dvdIconView;

@end
