//
//  PhotosViewController.m
//  Instagram
//
//  Created by Patrick Klitzke on 10/15/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "PhotoDetailsViewController.h"

@interface PhotosViewController ()

@property (nonatomic, strong) NSDictionary *media;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  
  
  UINib *photoCellNib = [UINib nibWithNibName:@"PhotoViewCell" bundle:nil];
  [self.tableView registerNib:photoCellNib forCellReuseIdentifier:@"PhotoViewCell"];
  
    self.title = @"Instagram Feed";
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=0246705b5b7b482b9d7855a168142331"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    // NSLog(@"response: %@", responseDictionary);
      _media = responseDictionary;
      _dataArray = _media[@"data"];
      
      NSLog(@"dataArray : %@", _dataArray);
      
      self.tableView.rowHeight = 350;
      
      
      [_tableView reloadData];
    }];
  
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"count : %ld" , _dataArray.count);
  return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  PhotoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoViewCell" forIndexPath:indexPath];
  
  NSDictionary *photo = self.dataArray[indexPath.row];
  
  NSString *urlString = [photo valueForKeyPath:@"images.low_resolution.url"];
  NSString *desc = [photo valueForKeyPath:@"caption.text"];
  cell.descLabel.text = desc;
  [cell.photoImageView setImageWithURL:[NSURL URLWithString:urlString]];
  //cell.textLabel.text = [NSString stringWithFormat:@"This is row : %ld", indexPath.row];
  return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  
  
  PhotoDetailsViewController *detailViewController = [[PhotoDetailsViewController alloc] init];
  detailViewController.photo = self.dataArray[indexPath.row];
  
  
  [self.navigationController pushViewController:detailViewController animated:YES];
  
  
  
  
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
