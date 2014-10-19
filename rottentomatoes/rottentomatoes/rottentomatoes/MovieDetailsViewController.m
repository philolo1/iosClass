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

- (NSString *) getImageURL
{
  return [_movie valueForKeyPath:@"posters.thumbnail"];
}

- (void) loadHighQualityImage
{
  NSLog(@"start replacing");
  NSString *url = [[self getImageURL] stringByReplacingOccurrencesOfString:@"tmb" withString:@"ori"];
  
  
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
  NSLog(@"Url : %@", url);
  
  
  
  [_backgroundView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    NSLog(@"better quality loaded!");
    _backgroundView.image = image;
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    NSLog(@"Error %@", error);
  }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  self.titleLabel.text = _movie[@"title"];
  self.subtitleLabel.text = _movie[@"synopsis"];
  self.scrollView.contentSize = CGSizeMake(320, 1000);
  
  
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self getImageURL]]
                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                       timeoutInterval:60.0];
  
  [_backgroundView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    NSLog(@"loaded !");
    _backgroundView.image = image;
    [self loadHighQualityImage];
    
    
  } failure:nil];
  

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
