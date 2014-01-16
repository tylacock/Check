//
//  AddItemViewController.h
//  Checklists
//
//  Created by Lacock, Ty on 1/16/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;

@end


@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) id <ItemDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) ChecklistItem *itemToEdit;

- (IBAction)cancel;
- (IBAction)done;


@end
