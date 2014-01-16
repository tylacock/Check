//
//  AddItemViewController.m
//  Checklists
//
//  Created by Lacock, Ty on 1/16/14.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

///////////////////////////////////////////////////////////////////////////////
#pragma mark -  Life Cycle
///////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Selects the text when opening the view
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}
///////////////////////////////////////////////////////////////////////////////
#pragma mark -  Table View & Data Source
///////////////////////////////////////////////////////////////////////////////

// Disables row selection
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

///////////////////////////////////////////////////////////////////////////////
#pragma mark -  Controller Methods
///////////////////////////////////////////////////////////////////////////////

- (IBAction)cancel {
    [self.delegate itemDetailViewControllerDidCancel:self];
}

- (IBAction)done {
    if (self.itemToEdit == nil) {
        ChecklistItem *item = [[ChecklistItem alloc] init];
        item.text = self.textField.text;
        item.checked = NO;
        
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    } else {
        self.itemToEdit.text = self.textField.text;
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // This will enable the button if the length of the text is greater than 0
    self.doneBarButton.enabled = ([newText length] > 0);
    
    return YES;
}

@end
