//
//  GEditBeaconViewController.m
//  Gimbal
//
//  Created by Emiliano Bivachi on 12/11/14.
//  Copyright (c) 2014 Emiliano Bivachi. All rights reserved.
//

#import "GEditBeaconViewController.h"

@interface GEditBeaconViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *xTextField;
@property (weak, nonatomic) IBOutlet UITextField *yTextField;
@property (weak, nonatomic) IBOutlet UITextField *zTextField;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@end

@implementation GEditBeaconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.xTextField.text = [NSString stringWithFormat:@"%g",self.beacon.x];
    self.yTextField.text = [NSString stringWithFormat:@"%g",self.beacon.y];
    self.zTextField.text = [NSString stringWithFormat:@"%g",self.beacon.z];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (_tapGestureRecognizer) {
        return _tapGestureRecognizer;
    }
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOutsideTextField)];
    _tapGestureRecognizer.numberOfTapsRequired = 1;
    _tapGestureRecognizer.numberOfTouchesRequired = 1;
    
    return _tapGestureRecognizer;
}

- (void)tapOutsideTextField {
    if (self.xTextField.isFirstResponder) {
        [self.xTextField resignFirstResponder];
    }
    if (self.yTextField.isFirstResponder) {
        [self.yTextField resignFirstResponder];
    }
    if (self.zTextField.isFirstResponder) {
        [self.zTextField resignFirstResponder];
    }
    self.view.gestureRecognizers = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneTapped:(id)sender {
    if (self.xTextField.text.length > 0) {
        self.beacon.x = [self.xTextField.text floatValue];
    }
    if (self.yTextField.text.length > 0) {
        self.beacon.y = [self.yTextField.text floatValue];
    }
    if (self.zTextField.text.length > 0) {
        self.beacon.z = [self.zTextField.text floatValue];
    }
    [self.delegate backHomeFrom:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

@end
