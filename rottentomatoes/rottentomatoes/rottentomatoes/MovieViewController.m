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

@interface MovieViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation MovieViewController
{
  NSArray *_movies;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Movies";
  self.tableView.delegate = self;
  self.tableView.rowHeight = 100;
  
  self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
  [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
  
  NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=qm8jefqegt4qzawhaw664wzc&limit=20&country=us"];
  
  NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
  [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
    NSDictionary *responseDictionary  = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:9
                                                                          error:nil];
    
    NSLog(@"response : %@", responseDictionary);
    _movies = responseDictionary[@"movies"];
    
    [self.tableView reloadData];
    
  }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 10;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
