//
//  SettingsViewController.m
//  philolo1-tipcalculator
//
//  Created by Patrick Klitzke on 10/3/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *firstSlider;

@property (weak, nonatomic) IBOutlet UISlider *thirdSlider;

@property (weak, nonatomic) IBOutlet UISlider *secondSlider;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@end

@implementation SettingsViewController

- (id)init
{
  self = [super init];
  if (self) {
    self.title = @"Settings";
  }
  return self;
}

- (IBAction)sliderChanged:(id)sender {
  [self updateValues];
}

- (void) updateValues
{
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  
  int val = _firstSlider.value * 100;
  self.firstLabel.text = [NSString stringWithFormat:@"%d %%", val];
  
  [arr addObject:@(val/100.0)];
  
  val = _secondSlider.value * 100;
  self.secondLabel.text = [NSString stringWithFormat:@"%d %%", val];
  
  [arr addObject:@(val/100.0)];

  val = _thirdSlider.value * 100;
  self.thirdLabel.text = [NSString stringWithFormat:@"%d %%", val];
  
  [arr addObject:@(val/100.0)];
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

  [defaults setObject:arr forKey:@"tips"];
  [defaults synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableArray *arr = [defaults objectForKey:@"tips"];
  
  self.firstLabel.text = [NSString stringWithFormat:@"%@ %%", [arr objectAtIndex:0]];
  self.firstSlider.value = [[arr objectAtIndex:0] floatValue];
  
  
  self.secondLabel.text = [NSString stringWithFormat:@"%@ %%", [arr objectAtIndex:1]];
  self.secondSlider.value = [[arr objectAtIndex:1] floatValue];
  
  self.thirdLabel.text = [NSString stringWithFormat:@"%@ %%", [arr objectAtIndex:2]];
  self.thirdSlider.value = [[arr objectAtIndex:2] floatValue];

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
