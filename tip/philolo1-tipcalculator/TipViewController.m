//
//  TipViewController.m
//  philolo1-tipcalculator
//
//  Created by Patrick Klitzke on 10/3/14.
//  Copyright (c) 2014 Patrick Klitzke. All rights reserved.
//

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
- (IBAction)selectionChanged:(id)sender {
  [self updateValues];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateValues];
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

- (void)updateValues
{
  float billAmount = [self.billTextField.text floatValue];
  
  NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
  float tipAmount = billAmount *[tipValues[self.tipControl.selectedSegmentIndex] floatValue];
  float total = tipAmount + billAmount;
  self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
  self.totalAmountLabel.text = [NSString stringWithFormat:@"$%.2f", total];
}


- (IBAction)testTap:(id)sender {
  [self.view endEditing:YES];
  [self updateValues];
}
@end
