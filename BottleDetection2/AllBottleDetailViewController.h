//
//  AllBottleDetailViewController.h
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllBottleDetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *bottleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *rfidNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleMadeCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleMadeCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleMadeCompanyIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleMadeCompanyLicenseLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNominalPressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleWaterTestPressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleDesignThicknessLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleActualWeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleActualVolumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleMadeDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleFirstInstallDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleLastCheckDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleNextCheckDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleServiceYearsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleBelongedLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleLicenseLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleGuigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleInstallLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottleStdVolLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carMadeFactoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *carBelongedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *carBelongedTelLabel;
@property (weak, nonatomic) IBOutlet UILabel *carBelongedCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *carBelongedCompanyAddressLabel;
@property (nonatomic,strong) NSDictionary *sendParameters;

@end
