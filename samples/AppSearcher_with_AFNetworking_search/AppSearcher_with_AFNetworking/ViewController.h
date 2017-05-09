//  ViewController.h

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *appNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *countryTextField;


@property (strong, nonatomic) IBOutlet UITableView *resultTable;

@property (nonatomic, copy) NSArray * resultList;

- (IBAction)searchBTNPressed:(id)sender;

@end

