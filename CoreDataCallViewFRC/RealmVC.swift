//
//  RealmVC.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/21/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//

import UIKit
import RealmSwift
import CoreData

private let reuseIdentifier = "ItemCell"

class RealmVC: UICollectionViewController {
    var datasource: Results<RmItem>?
    var notificationToken: NotificationToken? = nil
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        self.datasource = realm.objects(RmItem.self)
        
        // Observe Results Notifications
        notificationToken = self.datasource?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else { return }
            switch changes {
            case .initial(_):
                collectionView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                collectionView.performBatchUpdates({
                    self?.collectionView?.reloadItems(at: modifications.map { IndexPath(row: $0, section: 0) })
                    self?.collectionView?.insertItems(at: insertions.map { IndexPath(row: $0, section: 0) })
                    self?.collectionView?.deleteItems(at: deletions.map { IndexPath(row: $0, section: 0) })
                }, completion: { (completed: Bool) in
                    
                    let lastIndex = (self?.datasource?.count ?? 1) - 1
                    print("Total: \(lastIndex)")
                    let indexPath = IndexPath(item: lastIndex, section: 0)
                    self?.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                    do {
                        try self?.container?.viewContext.save()
                    } catch {
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror.localizedDescription), \(nserror.userInfo)")
                    }
                    
                    self?.collectionView?.reloadData()
                })
                break
            case let .error(error):
                print(error.localizedDescription)
            }
        }
        
        
        print("\(self.datasource?.count)")
        print(container?.persistentStoreDescriptions.first?.url)
        container?.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let nibCategory = UINib(nibName: reuseIdentifier, bundle: nil)
        self.collectionView!.register(nibCategory, forCellWithReuseIdentifier: reuseIdentifier)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.datasource?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        
        guard let dataSource = self.datasource,
            dataSource.count > indexPath.row else {
                return cell
        }
        
        let item = dataSource[indexPath.row]
        //print(item.title)

        // Configure the cell
        DispatchQueue.main.async{
            cell.configure(with: item)
        }
    
        return cell
    }

    
    @IBAction func populateDataSources(_ sender: UIBarButtonItem) {
        if let container = self.container {
            container.viewContext.automaticallyMergesChangesFromParent = true
            let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            backgroundContext.parent = container.viewContext
            generateRandomObjects(backgroundContext: backgroundContext)
        }
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
