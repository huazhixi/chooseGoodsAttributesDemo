//
//  AddDizhiViewController.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/25.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "AddDizhiViewController.h"
#import "HZAreaPickerView.h"
#import "ACMacros.h"
#import "HXHttpTool.h"
#import "SVProgressHUD.h"

@interface AddDizhiViewController ()<UITextFieldDelegate, HZAreaPickerDelegate>

@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *zipcodeField;
@property (weak, nonatomic) IBOutlet UITextField *streetField;

@property (weak, nonatomic) IBOutlet UILabel *stateCityAndDistrictLbl;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation AddDizhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址管理";
}

- (IBAction)chooseBtnClick {
    [_detailAddressField resignFirstResponder];
    [_nameField resignFirstResponder];
    [_phoneField resignFirstResponder];
    [_zipcodeField resignFirstResponder];
    [_streetField resignFirstResponder];
    
    typeof(self) _weakSelf = self;
    if (!_locatePicker) {
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
        
        _weakSelf.stateCityAndDistrictLbl.text = @"北京通州";
        
        self.locatePicker.pickerDidChangeStatus = ^(HZAreaPickerView *picker) {
            
            if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
                _weakSelf.stateCityAndDistrictLbl.text = [NSString stringWithFormat:@"%@%@%@", picker.locate.state, picker.locate.city, picker.locate.district];
            } else{
                
            }
        };
    }
    [self.locatePicker showInView:self.view];
}
- (void)changeSaveBtnState {
    if (![_nameField.text isEqual:@""] && ![_phoneField.text isEqual:@""] && ![_detailAddressField.text isEqual:@""] && ![_streetField.text isEqual:@""] && ![_stateCityAndDistrictLbl.text isEqualToString:@"点击选择所在区域"]) {
        _saveBtn.enabled = YES;
        _saveBtn.titleLabel.textColor = kWhiteColor;
        [_saveBtn setBackgroundImage:[UIImage imageNamed:@"2项目详情_16"] forState:UIControlStateNormal];
    }
}
- (IBAction)saveBtnClick {
    
    [self saveAddressToServer];
}
/**
 *  上传地址到服务器
 */
- (void)saveAddressToServer {
    
    if (_phoneField.text.length == 11 && [[_phoneField.text substringToIndex:1] isEqualToString:@"1"]) {
        typeof(self) _weakSelf = self;
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
        NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
        paramas[@"method"] = @"addaddr";
        paramas[@"user_id"] = userID;
        paramas[@"name"] = _nameField.text;
        paramas[@"mobile"] = _phoneField.text;
        paramas[@"zipcode"] = @"";
        paramas[@"city"] = _stateCityAndDistrictLbl.text;
        paramas[@"street"] = _streetField.text;
        paramas[@"addr_xx"] = _detailAddressField.text;
        [HXHttpTool post:URL params:paramas success:^(id json) {
            LXLog(@"%@", json);
            NSInteger status = [json[@"status"] integerValue];
            if (status == 1) {
                [_weakSelf.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD showSuccessWithStatus:@"添加成功" maskType:SVProgressHUDMaskTypeGradient];
            } else {
                // 提示框
                [SVProgressHUD showErrorWithStatus:@"添加失败" maskType:SVProgressHUDMaskTypeGradient];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"添加失败" maskType:SVProgressHUDMaskTypeGradient];
            LXLog(@"%@", error);
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" maskType:SVProgressHUDMaskTypeGradient];
    }
    
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _phoneField) {
        textField.text.length > 11 ? (textField.text = [textField.text substringToIndex:10]) : nil;
    }
    [self changeSaveBtnState];
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, kScreenW, kScreenH);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, kScreenW, kScreenH);
    self.view.frame = rect;
    [UIView commitAnimations];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:_detailAddressField]) {
        int offset = 0;
        if (kScreenH == 480) {
            offset = 20;
        }
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float height = kScreenH;
        float width = kScreenW;
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
        [UIView commitAnimations];
    }
    if ([textField isEqual:_nameField]) {
        int offset = 0;
        if (kScreenH == 480) {
            offset = 80;
        }
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float height = kScreenH;
        float width = kScreenW;
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
        [UIView commitAnimations];
    }
    if ([textField isEqual:_phoneField]) {
        int offset = 0;
        if (kScreenH == 480) {
            offset = 120;
        } else if (kScreenH == 568) {
            offset = 50;
        }
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float height = kScreenH;
        float width = kScreenW;
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
        [UIView commitAnimations];
    }
    if ([textField isEqual:_zipcodeField]) {
        int offset = 0;
        if (kScreenH == 480) {
            offset = 170;
        } else if (kScreenH == 568) {
            offset = 100;
        } else if (kScreenH == 667) {
            offset = 20;
        } else {
            offset = 0;
        }
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float height = kScreenH;
        float width = kScreenW;
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
        [UIView commitAnimations];
    }
    
    [_locatePicker cancelPicker];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [_detailAddressField resignFirstResponder];
    [_nameField resignFirstResponder];
    [_phoneField resignFirstResponder];
    [_zipcodeField resignFirstResponder];
    [_streetField resignFirstResponder];
}
@end
