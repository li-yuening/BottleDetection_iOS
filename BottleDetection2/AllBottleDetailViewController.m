//
//  AllBottleDetailViewController.m
//  BottleDetection2
//
//  Created by Li Yuening on 15/6/7.
//  Copyright (c) 2015年 Li Yuening. All rights reserved.
//

#import "AllBottleDetailViewController.h"

@implementation AllBottleDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bottleNumberLabel.text = [self.sendParameters objectForKey:@"bottleNumber"];
    self.carNumberLabel.text = [self.sendParameters objectForKey:@"carNumber"];
    self.rfidNumberLabel.text = [self.sendParameters objectForKey:@"rfidNumber"];
    self.bottleMadeCountryLabel.text = [self.sendParameters objectForKey:@"bottleMadeCountry"];
    self.bottleTypeLabel.text = [self.sendParameters objectForKey:@"bottleTypeC"];
    self.bottleMadeCompanyLabel.text = [self.sendParameters objectForKey:@"bottleMadeCompany"];
    self.bottleMadeCompanyIDLabel.text = [self.sendParameters objectForKey:@"bottleMadeCompanyID"];
    self.bottleMadeCompanyLicenseLabel.text = [self.sendParameters objectForKey:@"bottleMadeLicense"];
    self.bottleNominalPressureLabel.text = [self.sendParameters objectForKey:@"bottleNominalPressure"];
    self.bottleWaterTestPressureLabel.text = [self.sendParameters objectForKey:@"bottleWaterTestPressure"];
    self.bottleDesignThicknessLabel.text = [self.sendParameters objectForKey:@"bottleDesignThickness"];
    self.bottleActualWeightLabel.text = [self.sendParameters objectForKey:@"bottleActualWeight"];
    self.bottleActualVolumeLabel.text = [self.sendParameters objectForKey:@"bottleActualVolume"];
    self.bottleMadeDateLabel.text = [self.sendParameters objectForKey:@"bottleMadeDate"];
    self.bottleFirstInstallDateLabel.text = [self.sendParameters objectForKey:@"bottleFirstInstallDate"];
    self.bottleLastCheckDateLabel.text = [self.sendParameters objectForKey:@"bottleLastCheckDate"];
    self.bottleNextCheckDateLabel.text = [self.sendParameters objectForKey:@"bottleNextCheckDate"];
    self.bottleServiceYearsLabel.text = [self.sendParameters objectForKey:@"bottleServiceYears"];
    self.bottleBelongedLabel.text = [self.sendParameters objectForKey:@"bottleBelonged"];
    self.bottleLicenseLabel.text = [self.sendParameters objectForKey:@"bottleLicense"];
    self.bottleGuigeLabel.text = [self.sendParameters objectForKey:@"bottleGuige"];
    self.bottleInstallLabel.text = [self.sendParameters objectForKey:@"bottleInstall"];
    self.bottleStdVolLabel.text = [self.sendParameters objectForKey:@"bottleStdVol"];
    self.carTypeLabel.text = [self.sendParameters objectForKey:@"carTypeC"];
    self.carBelongedNameLabel.text = [self.sendParameters objectForKey:@"carBelongedName"];
    self.carMadeFactoryLabel.text = [self.sendParameters objectForKey:@"carMadeFactory"];
    self.carBelongedTelLabel.text = [self.sendParameters objectForKey:@"carBelongedTel"];
    self.carBelongedCompanyAddressLabel.text = [self.sendParameters objectForKey:@"carBelongedCompanyAddress"];
    self.carBelongedCompanyLabel.text = [self.sendParameters objectForKey:@"carBelongedCompany"];
}

@end
