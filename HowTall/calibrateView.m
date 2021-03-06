//
//  calibrateView.m
//  HowTall
//
//  Created by Kyle on 3/23/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import "calibrateView.h"
#import "calibratedLensHeight.h"
#import "angleToBase.h"
#import "angleToTop.h"
#import "AdvancedView.h"

@interface calibrateView ()

@property (nonatomic, strong) UITextField *userCalibrationBox;

@end

@implementation calibrateView

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        // create GUI
        [self createCalibrateGUI];
        
        
    }
    
    return self;
    
}

/*
 Allocates the buttons and text box for the calibration screen with instruction labels */

-(void)createCalibrateGUI {
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    // Allocate buttons and text boxes
    UIButton *saveCalibrationButton = [UIButton new];
    UIButton *doneCalibrating = [UIButton new];
    UIButton *advancedCalibration = [UIButton new];
    self.userCalibrationBox = [UITextField new];
    
    UILabel *userInstructions = [UILabel new];
    UILabel *userHint = [UILabel new];
    
    UIImageView *mainTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"howTall"]];
    [[self view] addSubview:mainTitle];
    
    [saveCalibrationButton setTitle:@"Set Height" forState:UIControlStateNormal];
    saveCalibrationButton.backgroundColor = [UIColor redColor];
    [saveCalibrationButton addTarget:self action:@selector(saveCalibrationAndDismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [doneCalibrating setTitle:@"Done" forState:UIControlStateNormal];
    doneCalibrating.backgroundColor = [UIColor blueColor];
    [doneCalibrating addTarget:self action:@selector(doneCalibrating) forControlEvents:UIControlEventTouchUpInside];
    
    [advancedCalibration setTitle:@"Advanced Calibration" forState:UIControlStateNormal];
    advancedCalibration.backgroundColor = [UIColor redColor];
    [advancedCalibration addTarget:self action:@selector(advancedCalibrationPress) forControlEvents:UIControlEventTouchUpInside];
    
    self.userCalibrationBox.backgroundColor = [UIColor whiteColor];
    self.userCalibrationBox.keyboardType = UIKeyboardTypeDecimalPad;
    self.userCalibrationBox.textAlignment = NSTextAlignmentCenter;
    self.userCalibrationBox.text = [NSString stringWithFormat:@"%.1f" , [calibratedLensHeight sharedInstance].value];
    
    userInstructions.text = @"Enter the height of the camera lens from the ground in inches:";
    userInstructions.numberOfLines = 0;
    
    userHint.text = @"You can usually use your own height minus 4 inches depending on how you hold your phone";
    userHint.numberOfLines = 0;
    
    // Add buttons and title to view
    [self.view addSubview:saveCalibrationButton];
    [self.view addSubview:self.userCalibrationBox];
    [self.view addSubview:userInstructions];
    [self.view addSubview:userHint];
    [self.view addSubview:mainTitle];
    [self.view addSubview:doneCalibrating];
    [self.view addSubview:advancedCalibration];
    
    // Create contraints for view
    saveCalibrationButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.userCalibrationBox.translatesAutoresizingMaskIntoConstraints = NO;
    userInstructions.translatesAutoresizingMaskIntoConstraints = NO;
    userHint.translatesAutoresizingMaskIntoConstraints = NO;
    mainTitle.translatesAutoresizingMaskIntoConstraints = NO;
    doneCalibrating.translatesAutoresizingMaskIntoConstraints = NO;
    advancedCalibration.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[title(100.0)]-5-[instructions(45.0)]-10-[input(40.0)]-10-[hint(60.0)]-10-[advanced(40.0)]-20-[done(50.0)]"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"instructions" : userInstructions,
                                                                                @"input" :self.userCalibrationBox,
                                                                                @"hint" : userHint,
                                                                                @"title" : mainTitle,
                                                                                @"advanced" : advancedCalibration,
                                                                                @"done" : doneCalibrating
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[instructions]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"instructions" : userInstructions,
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[input]-10-[save(120.0)]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"input" : self.userCalibrationBox,
                                                                                @"save" : saveCalibrationButton
                                                                                }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[hint]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"hint" : userHint                                                                          }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[advanced]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"advanced" : advancedCalibration                                                                          }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[done]-30-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"done" : doneCalibrating                                                                          }]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-60-[title]-60-|"
                                                                      options:kNilOptions
                                                                      metrics:nil
                                                                        views:@{@"title" : mainTitle                                                                          }]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:saveCalibrationButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.userCalibrationBox
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:saveCalibrationButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.userCalibrationBox
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0]];
    
    
    
}

-(void)saveCalibrationAndDismiss {
    
    [calibratedLensHeight sharedInstance].value = [self.userCalibrationBox.text floatValue];
    [self.userCalibrationBox resignFirstResponder];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)doneCalibrating {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)advancedCalibrationPress {
    
    AdvancedView *advanced = [AdvancedView new];
    
    [self.navigationController pushViewController:advanced animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
