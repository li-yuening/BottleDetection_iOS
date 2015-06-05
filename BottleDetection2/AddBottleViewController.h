//
//  AddBottleViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/5/2.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBottleViewController : UITableViewController //<UIPickerViewDelegate,UIPickerViewDataSource>
//@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *carNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *rfidNumberLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *bottleTypeSegment;
@property (weak, nonatomic) IBOutlet UITextField *bottleMadeCountryLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleMadeCompanyLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleMadeCompanyIDLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleMadeLicenseLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleNominalPressureLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleWaterTestPressureLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleDesignThicknessLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleActualWeightLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleActualVolumeLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleStdVolLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleMadeDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleFirstInstallDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleLastCheckDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleNextCheckDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleServiceYearsLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleBelongedLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleLicenseLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleGuideLabel;
@property (weak, nonatomic) IBOutlet UITextField *bottleInstallLabel;
- (IBAction)saveAddBottle:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *carTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *carBelongedNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *carMadeFactoryLabel;
@property (weak, nonatomic) IBOutlet UITextField *carBelongedTelLabel;
@property (weak, nonatomic) IBOutlet UITextField *carBelongedCompanyAddressLabel;
@property (weak, nonatomic) IBOutlet UITextField *carBelongedCompanyLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBottleButton;
- (Boolean)checkInput;
- (void)sendAddBottleRequest;
- (int)checkBottleType;
- (int)checkCarType;
- (NSString *)toStringBottleType;
- (IBAction)keyboardHide:(id)sender;
@property (nonatomic,strong) NSMutableDictionary *listData;
@property (nonatomic,strong) NSMutableData *datas;
@end
