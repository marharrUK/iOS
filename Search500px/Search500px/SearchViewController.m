//
//  ViewController.m
//  Search500px
//
//  Created by offline on 03/10/2014.
//  Copyright (c) 2014 offline. All rights reserved.
//

#import "SearchViewController.h"

#import "PhotoCollectionViewController.h"


@interface SearchViewController ()



@property (strong, nonatomic) IBOutlet UITextField *searchTermOutlet;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchTermOutlet becomeFirstResponder];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self performSegueWithIdentifier:@"searchPush" sender:self];

    
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    PhotoCollectionViewController *controller = segue.destinationViewController;
    controller.searchTerm =  self.searchTermOutlet.text;
    
}


@end
