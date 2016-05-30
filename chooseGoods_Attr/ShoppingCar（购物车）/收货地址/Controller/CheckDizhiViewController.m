//
//  CheckDizhiViewController.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/25.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "CheckDizhiViewController.h"
#import "AddressModel.h"
#import "HXHttpTool.h"
#import "ACMacros.h"
#import "SVProgressHUD.h"
#import "HZAreaPickerView.h"

@interface CheckDizhiViewController ()<UITextFieldDelegate, HZAreaPickerDelegate>
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@property (weak, nonatomic) IBOutlet UILabel *stateCityAndDistrictLbl;
@property (weak, nonatomic) IBOutlet UILabel *streetLbl;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImgView;
@property (weak, nonatomic) IBOutlet UIView *lastBackView;
@property (nonatomic, copy) NSString *isDefault;
@end

@implementation CheckDizhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址管理";
    
    _stateCityAndDistrictLbl.text = _addressModel.city_addr;
    _streetLbl.text = _addressModel.street_addr;
    _phoneField.text = _addressModel.mobile;
    _nameField.text = _addressModel.consignee;
    _detailAddressField.text = _addressModel.address_xx;
    if ([_addressModel.moren_status isEqual:@"1"]) {
        _lastBackView.hidden = YES;
    } else {
        _lastBackView.hidden = NO;
    }
}

- (IBAction)chooseBtnClick {
    [_nameField resignFirstResponder];
    [_phoneField resignFirstResponder];
    [_detailAddressField resignFirstResponder];
    
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

- (IBAction)cellBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _isDefault = @"1";
        _checkBoxImgView.image = [UIImage imageNamed:@"7收货地址"];
    } else {
        _isDefault = @"0";
        _checkBoxImgView.image = [UIImage imageNamed:@"7收货地址1"];
    }
}

- (IBAction)bottomBtnClick:(UIButton *)sender {
    if (sender.tag == 11) {
        [self deleteAddress];
    } else {
        [self changeAddress];
    }
}
/**
 *  修改默认地址
 */
- (void)changeAddress {

    if (_phoneField.text.length == 11 && [[_phoneField.text substringToIndex:1] isEqualToString:@"1"]){
        typeof(self) _weakSelf = self;
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
        NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
        paramas[@"method"] = @"morenaddr";
        paramas[@"user_id"] = userID;
        paramas[@"addr_id"] = _addressModel.address_id;
        paramas[@"moren"] = _isDefault;
        paramas[@"name"] = _nameField.text;
        paramas[@"mobile"] = _phoneField.text;
        paramas[@"zipcode"] = @"";
        paramas[@"city"] = _stateCityAndDistrictLbl.text;
        paramas[@"street"] = _streetLbl.text;
        paramas[@"addr_xx"] = _detailAddressField.text;
        [HXHttpTool post:URL params:paramas success:^(id json) {
            LXLog(@"%@", json);
            NSInteger status = [json[@"status"] integerValue];
            if (status == 1) {
                [_weakSelf.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD showSuccessWithStatus:@"保存成功" maskType:SVProgressHUDMaskTypeGradient];
            } else {
                // 提示框
                [_weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
            LXLog(@"%@", error);
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" maskType:SVProgressHUDMaskTypeGradient];
        
    }

    typeof(self) _weakSelf = self;
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"method"] = @"morenaddr";
    paramas[@"user_id"] = userID;
    paramas[@"addr_id"] = _addressModel.address_id;
    paramas[@"moren"] = _isDefault;
    paramas[@"name"] = _nameField.text;
    paramas[@"mobile"] = _phoneField.text;
    paramas[@"zipcode"] = @"";
    paramas[@"city"] = _stateCityAndDistrictLbl.text;
    paramas[@"street"] = _streetLbl.text;
    paramas[@"addr_xx"] = _detailAddressField.text;
    [HXHttpTool post:URL params:paramas success:^(id json) {
        LXLog(@"%@", json);
        NSInteger status = [json[@"status"] integerValue];
        if (status == 1) {
            [_weakSelf.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:@"保存成功" maskType:SVProgressHUDMaskTypeGradient];
        } else {
            // 提示框
            [_weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
        LXLog(@"%@", error);
    }];

}
/**
 *  收货地址删除
 */
- (void)deleteAddress {
    typeof(self) _weakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"method"] = @"addrdel";
    paramas[@"addr_id"] = _addressModel.address_id;
    [HXHttpTool post:URL params:paramas success:^(id json) {
        LXLog(@"%@", json);
        NSInteger status = [json[@"status"] integerValue];
        if (status == 1) {
            [_weakSelf.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:@"删除成功" maskType:SVProgressHUDMaskTypeGradient];
        } else {
            // 提示框
            [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
        LXLog(@"%@", error);
    }];
}
#pragma mark - UITextFieldDelegate
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
}

@end
