//
//  PhotoDetailsViewController.m
//  Instagram
//
//  Created by Patrick Klitzke on 10/15/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsViewController ()

@end

@implementation PhotoDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  

  NSString *urlString = [self.photo valueForKeyPath:@"images.low_resolution.url"];
  [self.photoImage setImageWithURL:[NSURL URLWithString:urlString]];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
