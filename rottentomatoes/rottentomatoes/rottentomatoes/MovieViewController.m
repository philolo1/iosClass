//
//  MovieViewController.m
//  rottentomatoes
//
//  Created by Patrick Klitzke on 10/14/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD.h"

@interface MovieViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation MovieViewController
{
  NSArray *_movies;
  UIRefreshControl *_refreshController;
}


- (void)loadDataWithUrl:(NSString *)myurl
{
  NSURL *url = [NSURL URLWithString:myurl];
  
  
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                  initWithURL:url
                                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                  timeoutInterval:30];
  [request setHTTPMethod: @"GET"];
  
  [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
    if (data == nil) {
      _networkErrorView.hidden = NO;
    } else {
      _networkErrorView.hidden = YES;
      NSDictionary *responseDictionary  = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:9
                                                                            error:nil];
      
      _movies = responseDictionary[@"movies"];
      [_refreshController endRefreshing];
      [self.tableView reloadData];
    }
    
    [SVProgressHUD dismiss];
  }];
}

- (void)onRefresh
{
  [self loadDataWithUrl:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=qm8jefqegt4qzawhaw664wzc&limit=20&country=us"];
}


- (void)viewDidLoad {
  [super viewDidLoad];
  
  _refreshController = [[UIRefreshControl alloc] init];
  [_refreshController addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
  
  [_tableView insertSubview:_refreshController atIndex:0];
  
  _networkErrorView.hidden = YES;
  [SVProgressHUD show];
  
  self.title = @"Movies";
  self.tableView.delegate = self;
  self.tableView.rowHeight = 100;
  
  self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
  [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
  
  [self loadDataWithUrl:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=qm8jefqegt4qzawhaw664wzc&limit=20&country=us"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
  
  NSDictionary *movie = [_movies objectAtIndex:indexPath.row];
  
  cell.titleLabel.text = movie[@"title"];
  cell.subtitleLabel.text = movie[@"synopsis"];
  
  NSString *posterUrl = [movie valueForKeyPath:@"posters.thumbnail"];
  [cell.posterView setImageWithURL:[NSURL URLWithString:posterUrl]];
  
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath
                           animated:YES];
  
  MovieDetailsViewController *vc = [[MovieDetailsViewController alloc] init];
  vc.movie = [_movies objectAtIndex:indexPath.row];
  
  [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)movieTap:(id)sender {
  NSLog(@"movie Tap");
  [_movieIconView setHighlighted:YES];
}


@end
