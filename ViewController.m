//
//  ViewController.m
//  contact1
//
//  Created by 谢谦 on 16/2/6.
//  Copyright © 2016年 杜苏南. All rights reserved.
//

#import "ViewController.h"
#import "ContactGroup.h"
#import "contact.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_contacts;
    BOOL _isInsert;
    BOOL _isEditing;
    UIToolbar *_toolBar;
    UISearchBar *_searchBar;
    NSMutableArray *_searchContacts;
    BOOL _isSearching;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self initData];
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);
    [self.view addSubview:_tableView];

    [self addToolBar];
    [self addSearchBar];
    // Do any additional setup after loading the view, typically from a nib.
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ContactGroup *group = _contacts[section];
    return group.groupName;

}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ContactGroup *group = _contacts[section];
    return group.groupDetail;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;

}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *a = [[NSMutableArray alloc]init];
    for(ContactGroup *group in _contacts)
    {
        [a addObject:group.groupName];
    
    }
    return a;
}

-(void)initData
{
    _contacts = [[NSMutableArray alloc]init];
    contact *c1 = [[contact alloc]initWithFirstName:@"haha" withLastName:@"jack" withPhoneNumber:@"213976293160312"];
    contact *c2 = [[contact alloc]initWithFirstName:@"hello" withLastName:@"tom" withPhoneNumber:@"2318726358712356"];
    contact *c3 = [[contact alloc]initWithFirstName:@"hihu" withLastName:@"iuyoi" withPhoneNumber:@"392187638142"];
    ContactGroup *g1 = [[ContactGroup alloc]initWithGroupName:@"H" withGroupDetail:@"begin with H" withContactPersons:[NSMutableArray arrayWithObjects:c1,c2,c3,nil]];
    [_contacts addObject:g1];
    
    
    
    contact *c4 = [[contact alloc]initWithFirstName:@"jaha" withLastName:@"jack" withPhoneNumber:@"213976293160312"];
    contact *c5 = [[contact alloc]initWithFirstName:@"juji" withLastName:@"tom" withPhoneNumber:@"2318726358712356"];
    contact *c6 = [[contact alloc]initWithFirstName:@"jojk" withLastName:@"iuyoi" withPhoneNumber:@"392187638142"];
    ContactGroup *g2 = [[ContactGroup alloc]initWithGroupName:@"j" withGroupDetail:@"begin with j" withContactPersons:[NSMutableArray arrayWithObjects:c4,c5,c6,nil]];
    [_contacts addObject:g2];
    
    
    contact *c7 = [[contact alloc]initWithFirstName:@"ninm" withLastName:@"jack" withPhoneNumber:@"213976293160312"];
    contact *c8 = [[contact alloc]initWithFirstName:@"NONI" withLastName:@"tom" withPhoneNumber:@"2318726358712356"];
    contact *c9 = [[contact alloc]initWithFirstName:@"NENA" withLastName:@"iuyoi" withPhoneNumber:@"392187638142"];
    ContactGroup *g3 = [[ContactGroup alloc]initWithGroupName:@"N" withGroupDetail:@"begin with N" withContactPersons:[NSMutableArray arrayWithObjects:c7,c8,c9,nil]];
    [_contacts addObject:g3];

}

#pragma mark UITableView 实现datasource delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearching) {
        return 1;
    }
    return _contacts.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearching) {
        return _searchContacts.count;
    }
    ContactGroup *g1 = _contacts [section];
    return g1.contactPersons.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    contact *c1 = nil;
    
    if (_isSearching) {
        c1 = _searchContacts[indexPath.row];
    }else{
        ContactGroup *g1 = _contacts[indexPath.section];
        c1 = g1.contactPersons[indexPath.row];
    
    }
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
   
    
    cell.textLabel.text = [c1 getName];
    cell.detailTextLabel.text = c1.phoneNumber;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"system info" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"输入以修改号码";
            }];
    
    UIAlertAction *okItem = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ContactGroup *g1 = _contacts[indexPath.section];
        contact *c1 = g1.contactPersons[indexPath.row];
        UITextField *textField = alertController.textFields.firstObject;
        c1.phoneNumber = textField.text;
        [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }];
    [alertController addAction:okItem];
    
    
    UIAlertAction *cancelItem = [UIAlertAction actionWithTitle:@"cacel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelItem];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 实现 UITableView 的ADD DELETE

-(void)addToolBar
{
    
    CGRect frame =CGRectMake(0, 40, self.view.frame.size.width, 40);
    _toolBar = [[UIToolbar alloc]init];
    _toolBar.frame = frame;
    [self.view addSubview:_toolBar];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addContact:)];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteContact:)];
    UIBarButtonItem *flexibelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
   
    NSArray *items = [NSArray arrayWithObjects:addItem,flexibelItem,deleteItem,nil];
    _toolBar.items = items;
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isInsert) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;

}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactGroup *group = _contacts[indexPath.section];
    contact *contact1 = group.contactPersons[indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_contacts removeObject:contact1];
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    
    
    
    if (group.contactPersons.count == 0) {
        [_contacts removeObject:group];
        [_tableView reloadData];
    }
    
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        contact *c2 = [[contact alloc]init];
        c2.firstName = @"miko";
        c2.lastName = @"dskj";
        c2.phoneNumber = @"dsla23123";
        [group.contactPersons insertObject:c2 atIndex:indexPath.row];
        [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    ContactGroup *sourceGroup = _contacts[sourceIndexPath.section];
    contact *sourceContact = sourceGroup.contactPersons[sourceIndexPath.row];
    
    ContactGroup *destinationGroup = _contacts[destinationIndexPath.section];
    
    [sourceGroup.contactPersons removeObject:sourceContact];
    [destinationGroup.contactPersons insertObject:sourceContact atIndex:destinationIndexPath.row];
    
    if (sourceGroup.contactPersons == 0) {
        [_contacts removeObject:sourceGroup];
        [_tableView reloadData];
    }

}


-(void)addContact:(contact *)contactPerson
{
    _isInsert = YES;
    [_tableView setEditing:!_tableView.isEditing animated:YES];

}

-(void)deleteContact:(contact *)contactPerson
{
    _isInsert = NO;
    [_tableView setEditing:!_tableView.isEditing animated:YES];
}



-(void)searchDataWithKeyWord:(NSString *)keyWord
{
    _isSearching = YES;
    _searchContacts = [[NSMutableArray alloc]init];
    
    [_contacts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ContactGroup *group = obj;
        [group.contactPersons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            contact *con = obj;
            if ([con.firstName.uppercaseString containsString:keyWord.uppercaseString]||[con.lastName.uppercaseString containsString:keyWord.uppercaseString]||[con.phoneNumber containsString:keyWord]) {
                [_searchContacts addObject:con];
            }
        }];
    }];
    [_tableView reloadData];
    
}


-(void)addSearchBar
{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectOffset(_toolBar.frame, 0, 40)];
    _searchBar.placeholder = @"输入以搜索联系人";
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
//    _tableView.tableHeaderView = _searchBar;
    
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _isSearching = NO;
    _searchBar.text = @"";
    [_tableView reloadData];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchBar.text isEqualToString:@""]) {
        _isSearching = NO;
        [_tableView reloadData];
        return;
    }
    [self searchDataWithKeyWord:_searchBar.text];
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchDataWithKeyWord:_searchBar.text];
    [self resignFirstResponder];
}

@end
