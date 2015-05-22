//
//  ViewController.m
//  ScrollerDemo
//
//  Created by Hemant on 5/19/15.
//  Copyright (c) 2015 smartcloud. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, assign) BOOL wrap;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) IBOutlet UIButton *btnDelete;
@property (nonatomic, strong) NSMutableArray *arrChapter;

@end



@implementation ViewController
@synthesize wrap;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrChapter = [[NSMutableArray alloc]init];
    self.carousel.ignorePerpendicularSwipes = NO;
    self.carousel.vertical = NO;
     BOOL it =   self.carousel.isPagingEnabled;
    NSLog(@"%s",it);
    self.carousel.tag= 1;
    wrap = NO;

    /*
    CGSize offset = CGSizeMake(0.0f, 0.0f);
    self.carousel.viewpointOffset = offset;
     */
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(IBAction)addChapter:(id)sender{
    [self.arrChapter addObject:[NSString stringWithFormat:@"%lu",self.arrChapter.count+1]];
    self.carousel.type = iCarouselTypeLinear;

    [self.carousel reloadData];

}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{

    NSLog(@"%@",carousel.description);

}
#pragma mark -
#pragma mark iCarousel methods
- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{

    return 3;
}
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.arrChapter.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //ChapterView *chapterView = [[ChapterView alloc]init];


    NSArray *xibContents = [[NSBundle mainBundle] loadNibNamed:@"ChapterView" owner:self options:nil];
    UIView *chapterView = [xibContents lastObject]; //safer than objectAtIndex:0


    /*
     UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) style:UITableViewStylePlain];
     tableView.dataSource = self;


     return tableView;
     */

    /*
    UIView *paintView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    [paintView setBackgroundColor:[UIColor grayColor]];
    paintView.userInteractionEnabled = YES;


    UIView *paintView2=[[UIView alloc]initWithFrame:CGRectMake(10, 10, 250, 280)];
    [paintView2 setBackgroundColor:[UIColor blackColor]];
    paintView2.userInteractionEnabled = YES;
    [paintView addSubview:paintView2];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(fetchImage)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"test.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(50, 50, 100, 100);
    [paintView2 addSubview:button];
     
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 100, 50)];
    fromLabel.text = [NSString stringWithFormat:@"%ld",(long)index+1];;
    fromLabel.font = [UIFont systemFontOfSize:50];
    fromLabel.numberOfLines = 1;
    fromLabel.baselineAdjustment = UIBaselineAdjustmentNone; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.textColor = [UIColor whiteColor];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    [paintView2 addSubview:fromLabel];
     */
    //return [self getCardViewForItemAtIndex:index reusingView:view itemsArray:self.self.arrChapter];

    return chapterView;

}

- (UIView *)getCardViewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view itemsArray:(NSMutableArray*)items{
    UILabel *label = nil;

    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130.0f, 230.0f)];
        [view setBackgroundColor:[UIColor whiteColor]];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;

        [view.layer setCornerRadius:10];
        [view.layer setShadowColor:[UIColor blackColor].CGColor];
        [view.layer setShadowOpacity:0.8];
        [view.layer setShadowOffset:CGSizeMake(-2, -2)];

        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }

    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [NSString stringWithFormat:@"%lu",(unsigned long)items.count];

    return view;
}
-(void)fetchImage{
    NSLog(@"called");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{

    return [self getPlaceHolderViewAtIndex:index reusingView:view];

}

- (UIView *)getPlaceHolderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view{
    UILabel *label = nil;

    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130.0f, 230.0f)];
        [view setBackgroundColor:[UIColor whiteColor]];
        view.contentMode = UIViewContentModeCenter;

        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }

    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel

    //label.text = (index == 0)? @"[": @"]";

    return view;
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
            //implement 'flip3D' style carousel
        transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
        return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);

}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return wrap;
        }
        case iCarouselOptionArc:
        {
            return 2 * M_PI * 0.119929;
        }
        case iCarouselOptionRadius:
        {
            return value * 1.557364;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
                return 1.052855;


        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

/*- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
 {
 if (carousel == carouselTop) {
 NSNumber *item = (self.itemsTop)[index];
 NSLog(@"Tapped view number: %@", item);
 [self moveItemToBottom:index];
 }
 else{
 NSNumber *item = (self.itemsBottom)[index];
 NSLog(@"Tapped view number: %@", item);
 [self moveItemToTop:index];
 }
 }*/

- (void)moveItemToTop:(NSInteger)itemIndex{
    // remove from bottom
    if (self.carousel.numberOfItems > 0)
    {
        //NSInteger index = carouselBottom.currentItemIndex;
        [self.arrChapter removeObjectAtIndex:itemIndex];
        [self.carousel removeItemAtIndex:itemIndex animated:YES];
    }
}
- (void)carousel:(iCarousel *)carousel replaceView:(NSInteger)index WithView:(NSInteger)index{

    
}


- (void)carousel:(iCarousel *)carousel itemMoveWithIndex:(NSInteger)index{

        [self moveItemToTop:index];
        [self deleteAnimation];
}
-(void)deleteAnimation{
    UIImageView * animation = [[UIImageView alloc] init];
    animation.frame = CGRectMake(self.btnDelete.frame.origin.x, self.btnDelete.frame.origin.y, self.btnDelete.frame.size.width, self.btnDelete.frame.size.height);

    animation.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed: @"iconEliminateItem1.png"],
                                 [UIImage imageNamed: @"iconEliminateItem2.png"],
                                 [UIImage imageNamed: @"iconEliminateItem3.png"],
                                 [UIImage imageNamed: @"iconEliminateItem4.png"]
                                 ,nil];
    [animation setAnimationRepeatCount:1];
    [animation setAnimationDuration:0.35];
    [animation startAnimating];
    [self.view addSubview:animation];
    [animation bringSubviewToFront:self.view];
    [UIView commitAnimations];

}

@end
