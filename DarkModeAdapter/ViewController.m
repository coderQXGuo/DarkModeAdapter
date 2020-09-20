//
//  ViewController.m
//  DarkModeAdapter
//
//  Created by coder QXGuo on 2020/9/19.
//  Copyright © 2020 China. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+ColorName.h"
#import "ConstantsHeader.h"
#import "UIView+Adapter.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor qx_colorNamed:Color_FFFFFF];
    self.label.textColor = [UIColor qx_colorNamed:Color_E6B97D];
    
    self.testView.backgroundColor = [UIColor qx_colorNamed:Color_5F9EA0_Opacity];
    self.testView.layerShadowColorHex = Color_EE82EE_Shadow;
    self.testView.layer.shadowOpacity = 1.0;
    self.testView.layer.shadowRadius = 8.0;
    self.testView.layer.shadowOffset = CGSizeMake(8.0, 8.0);
    
    self.button.backgroundColor = [UIColor qx_colorNamed:Color_FFB700];
    
    self.button.layer.cornerRadius = 20.0;
    self.button.layerBorderColorHex = Color_90EE90;
    self.button.layer.borderWidth = 2.0;
}


@end
