//
//  CollectionViewController.m
//  Search500px
//
//  Created by offline on 03/10/2014.
//  Copyright (c) 2014 offline. All rights reserved.
//

#import "PhotoCollectionViewController.h"
@import SystemConfiguration;
@import MobileCoreServices;
@import Security;

#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "PhotoCollectionViewController.h"
#import "ThumbnailCollectionViewCell.h"
#import "PhotoDetailViewController.h"

NSString * const ConsumerAPIKey = @"ztNXBPr2jRAYjERvFYhIUecJqzpeubAf5pRmEYPR";
NSString * const URLString = @"https://api.500px.com/v1/photos";



@interface PhotoCollectionViewController ()
@property (strong, nonatomic) NSArray *thumbs;
@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"thumbCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    if (self.searchTerm != nil) {
        self.searchTerm = [self.searchTerm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Search Term: %@", self.searchTerm);
        NSString *jSonUrlString = [[NSString alloc] initWithFormat: @"%@/search", URLString] ;
        NSDictionary *params = @{
                                 @"term": self.searchTerm,
                                 @"consumer_key": ConsumerAPIKey,
                                 @"sort": @"rating"
                                 };
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET: jSonUrlString parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
            //NSLog(@"Search Term: %@", response);
            self.thumbs = response[ @"photos"];
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.collectionView reloadData];
                
                //[self.view setNeedsDisplay];

            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Search Term");
        }];
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.thumbs count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.thumbs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThumbnailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UICollectionViewFlowLayout *layout = (id) self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(screenWidth / 3, screenWidth / 3);
    
    NSDictionary *dict = [self.thumbs objectAtIndex: indexPath.item];
    NSString *imageUrl = dict[@"image_url"];
    
    
    [cell.thumbCellImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"Loading" ]];
    
    
    return cell;
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *rowIndex =  [[self.collectionView  indexPathsForSelectedItems] lastObject] ;
    NSDictionary *photo = self.thumbs[rowIndex.row];
   
    PhotoDetailViewController *controller = segue.destinationViewController;
    
    controller.photoDict = photo;
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
