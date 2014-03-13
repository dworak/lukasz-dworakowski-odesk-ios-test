//
//  ViewController.m
//  BuggyProject
//  Copyright (c) 2014 oDesk Corporation. All rights reserved.
//

#import "ViewController.h"
#import "SomeClass.h"
#import "CoreDataHelpers.h"
#import "ModelsEntity.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstBug:(id)sender {
	[SomeClass printTextInMain:@"Bug 1"];
}

- (IBAction)secondBug:(id)sender {
	NSInteger x = 123;
    x++; // if we create block, it copies all of the scope but before the declaration
	void (^printX)() = ^() {
		NSLog(@"%i", x);
	};
	printX();
}

- (IBAction)thirdBug:(id)sender {
	[CoreDataHelpers fillUnsortedData];
	NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
	NSLog(@"%@", models);
}

- (IBAction)fourthBug:(id)sender {
    // check if there are any elements
    NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
    
    // if there are some elements clean it for the purpose of this task
	if (models.count>0) {
		[CoreDataHelpers cleanData];
	}
    
    // fill the db
    [CoreDataHelpers fillUnsortedData];

    
    // obtain all objects created momment ago if it was there before
    if(models.count==0) {
        models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
    }
	
	NSLog(@"%@", models);
}

- (IBAction)fifthBug:(id)sender {
	[CoreDataHelpers fillUnsortedData];
	NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"modelName" ascending:YES];
    NSArray *sortedModels = [models sortedArrayUsingDescriptors:@[sortDescriptor]];
    [sortedModels enumerateObjectsUsingBlock:^(ModelsEntity *obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@ %@", obj.owner, obj.modelName);
    }];
}

@end
