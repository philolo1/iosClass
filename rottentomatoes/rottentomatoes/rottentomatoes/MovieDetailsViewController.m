//
//  MovieDetailsViewController.m
//  rottentomatoes
//
//  Created by Patrick Klitzke on 10/14/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  self.titleLabel.text = _movie[@"title"];
  self.subtitleLabel.text = _movie[@"synopsis"];
  self.scrollView.contentSize = CGSizeMake(320, 1000);
  

 NSString *posterUrl = [_movie valueForKeyPath:@"posters.thumbnail"];
 [_backgroundView setImageWithURL:[NSURL URLWithString:posterUrl]];
  _backgroundView.layer.zPosition = -1;
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
