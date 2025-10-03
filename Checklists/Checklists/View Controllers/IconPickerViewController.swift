//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by Tina  on 24.08.25.
//

import UIKit

protocol IconPickerViewControllerDelegate: AnyObject {
  func iconPicker(_ picker: IconPickerViewController, didPick iconName: String)
}

class IconPickerViewController: UITableViewController {
  weak var delegate: IconPickerViewControllerDelegate?
  private let icons = ["No Icon", "Appointments", "Birthdays", "Chores", "Drinks", "Folder", "Groceries", "Inbox", "Photos", "Trips"]

  // MARK: - Table View Delegates
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return icons.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
    let iconName = icons[indexPath.row]
    cell.textLabel?.text = iconName
    cell.imageView?.image = UIImage(named: iconName)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let iconName = icons[indexPath.row]
    delegate?.iconPicker(self, didPick: iconName)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
