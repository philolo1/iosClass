//
//  TipViewController.m
//  philolo1-tipcalculator
//
//  Created by Patrick Klitzke on 10/3/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

#import "SettingsViewController.h"
#import "TipViewController.h"


@interface TipViewController ()
@property (retain, nonatomic) IBOutlet UITextField *billTextField;
@property (retain, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (retain, nonatomic) IBOutlet UILabel *totalAmountLabel;
- (IBAction)testTap:(id)sender;
@property (retain, nonatomic) IBOutlet UISegmentedControl *tipControl;
@end

@implementation TipViewController

- (id)init
{
  self = [super init];
  if (self) {
    self.title = @"Tip Calculator";
  }
  return self;
}
- (IBAction)selectionChanged:(id)sender
{
  [self updateValues];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    [self updateValues];
  
    // Do any additional setup after loading the view from its nib.
}

- (void)onSettingsButton
{
  [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
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

- (void)updateValues
{
  float billAmount = [self.billTextField.text floatValue];
  
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  NSMutableArray *tipValues = [defaults objectForKey:@"tips"];
  
  if (!tipValues) {
    tipValues =  [@[@(0.1), @(0.15), @(0.2)] mutableCopy];
    [defaults setObject:tipValues forKey:@"tips"];
    [defaults synchronize];
  }
  
  for (int n=0; n<3; n++) {
    
    float f = [[tipValues objectAtIndex:n] floatValue] * 100;
    int num = f;
    
    [_tipControl setTitle:[NSString stringWithFormat:@"%d %%", num] forSegmentAtIndex:n];
  }
  
  float tipAmount = billAmount *[tipValues[self.tipControl.selectedSegmentIndex] floatValue];
  float total = tipAmount + billAmount;
  self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
  self.totalAmountLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}

- (void)viewWillAppear:(BOOL)animated
{
  [self updateValues];
}


- (IBAction)testTap:(id)sender {
  [self.view endEditing:YES];
  [self updateValues];
}
@end
