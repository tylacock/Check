//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by Lacock, Ty on 1/16/14.
//

#import "ChecklistsViewController.h"
#import "ChecklistItem.h"

@interface ChecklistsViewController ()

@end

@implementation ChecklistsViewController
{
  NSMutableArray *_items;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -  Life Cycle
///////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
  [super viewDidLoad];

  _items = [[NSMutableArray alloc] initWithCapacity:20];

  ChecklistItem *item;

  item = [[ChecklistItem alloc] init];
  item.text = @"Walk the dog";
  item.checked = NO;
  [_items addObject:item];

  item = [[ChecklistItem alloc] init];
  item.text = @"Brush my teeth";
  item.checked = YES;
  [_items addObject:item];

  item = [[ChecklistItem alloc] init];
  item.text = @"Learn iOS development";
  item.checked = YES;
  [_items addObject:item];

  item = [[ChecklistItem alloc] init];
  item.text = @"Soccer practice";
  item.checked = NO;
  [_items addObject:item];

  item = [[ChecklistItem alloc] init];
  item.text = @"Eat ice cream";
  item.checked = YES;
  [_items addObject:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark - Table View & Data source
///////////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_items count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

  ChecklistItem *item = _items[indexPath.row];
  [item toggleChecked];

  [self configureCheckmarkForCell:cell withChecklistItem:item];
	
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// Delete rows
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [_items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPAths =@[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPAths withRowAnimation:UITableViewRowAnimationAutomatic];
}
///////////////////////////////////////////////////////////////////////////////
#pragma mark -  App Methods
///////////////////////////////////////////////////////////////////////////////

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    UILabel *textLabel = (UILabel *)[cell viewWithTag:1000];
    
    if (item.checked) {
        label.text = @"✅";
        textLabel.textColor = [UIColor lightGrayColor];
    } else {
        label.text = @"";
        textLabel.textColor = [UIColor darkGrayColor];
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    ChecklistItem *item = _items[indexPath.row];
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
	
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"EditItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = _items[indexPath.row];
    }
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -  Delegate Metods
///////////////////////////////////////////////////////////////////////////////

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item {
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item {
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
