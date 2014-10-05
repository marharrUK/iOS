//
//  PhotoDetailViewController.m
//  Search500px
//
//  Created by offline on 03/10/2014.
//  Copyright (c) 2014 offline. All rights reserved.
//

#import "PhotoDetailViewController.h"
@import SystemConfiguration;
@import MobileCoreServices;
@import Security;

#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
@interface PhotoDetailViewController ()



@property (strong, nonatomic) IBOutlet UIImageView *photo;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *photoAuthor;

@property (strong, nonatomic) IBOutlet UILabel *photoDescription;
@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name.text = self.photoDict[@"name"];
    self.photoDescription.text = self.photoDict[@"description"] ;
    NSDictionary *user = self.photoDict[@"user"];
    self.photoAuthor.text = user[@"username"];
    
    NSString *imageUrl = self.photoDict[@"image_url"];
    
    
    [self.photo setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"Loading" ]];

    
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
