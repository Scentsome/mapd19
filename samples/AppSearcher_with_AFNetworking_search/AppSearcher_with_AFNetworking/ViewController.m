//  ViewController.m
#import "ViewController.h"
#import "AFNetworking.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UITabBarControllerDelegate>{

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultTable.dataSource = self;
    self.appNameTextField.delegate = self;
    self.countryTextField.delegate = self;

    self.navigationController.tabBarController.delegate = self;
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    if ([appDelegate isLogined]) {
        return YES;
    }else {
        UIViewController * loginVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchBTNPressed:(id)sender {
    
    // 將textfield的內容轉換成UTF8的文字
    NSString * appNameFromField = self.appNameTextField.text;

    NSString * appName = [appNameFromField stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString * countryFromField = self.countryTextField.text;
    NSString * country = [countryFromField stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 產生連線網址，將搜尋範圍限制在software
    // 且搜尋筆數限制在20筆
    NSString * queryAddress = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&country=%@&media=music&limit=20", appName, country];
   
    NSURL * url = [NSURL URLWithString:queryAddress];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    // AFNetworking連線：
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // 利用JSON分析器
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 分析網站回傳的JSON資料，並存放在array裡
        self.resultList = ((NSDictionary *) responseObject)[@"results"];
        // 資料取得後，將tableView進行重新整理
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.resultTable reloadData];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 若連線失敗，將array設為nil，並重新整理tableView
        NSLog(@"get error %@",error);
        self.resultList = nil;
        [self.resultTable reloadData];
    }];
    
    [operation start];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    //呈現的資料只有一個section
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (!self.resultList) {
        return 0;
    } else {
        return self.resultList.count;
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (!self.resultList) {
        //如果Array還沒接收到資料時，回傳nil
        return nil;
    } else {
        //如果Array已經接收到資料，產生Cell來將資料呈現出來
        static NSString * cellID = @"cellID";
        
        //cell採用 “UITableViewCellStyleSubtitle” 的類型
        UITableViewCell * theCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        //透過key:"trackName" 來取得app名稱
        theCell.textLabel.text = self.resultList[indexPath.row][@"trackName"];
        
        theCell.imageView.image = [UIImage imageNamed:@"loading"];
        
        //透過key:"primaryGenreName" 來取得app的分類
        theCell.detailTextLabel.text = self.resultList[indexPath.row][@"primaryGenreName"];
//        theCell.imageView.image = [UIImage imageNamed:@"loading.png"];
        //由於圖片檔案會比文字檔案下載來得慢
        //因此當圖片下載完後再將圖片更新
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            //透過key:"artworkUrl60" 來取得app圖片的下載連結
            NSURL * url = [NSURL URLWithString:self.resultList[indexPath.row][@"artworkUrl60"]];
            
            NSData * imageData = [NSData dataWithContentsOfURL:url];
            UIImage * image = [UIImage imageWithData:imageData];
            
            // 圖片檔案下載完後就更新cell上的imageView
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableViewCell * cell = [self.resultTable cellForRowAtIndexPath:indexPath];
                cell.imageView.image = image;
            });
        });

        return theCell;
    }
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender{
    NSInteger rowIndex = [self.resultTable indexPathForCell:sender].row;
    
    
    DetailViewController * detailVC = segue.destinationViewController;
    detailVC.item = self.resultList[rowIndex];
//    NSLog(@"%@", self.resultList[rowIndex] );
    
}

@end
