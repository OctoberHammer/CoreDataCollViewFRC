//
//  MainVC.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/19/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//https://www.youtube.com/watch?v=0JJJ2WGpw_I

import UIKit
import CoreData

private let reuseIdentifier = "ItemCell"

class MainVC: UICollectionViewController, NSFetchedResultsControllerDelegate {
    let sayHello = "Hello"
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    lazy var fetchedResultController: NSFetchedResultsController<Item>? = {

        if let context = self.container?.viewContext {
            let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
            fetchRequest.sortDescriptors = []//NSSortDescriptor(key: "title", ascending: true)
            let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            frc.delegate = self
            return frc
        } else {
            return nil
        }
    }()

    
    
    
    override func viewDidLoad() {
 
        super.viewDidLoad()


        let nibCategory = UINib(nibName: reuseIdentifier, bundle: nil)
        self.collectionView!.register(nibCategory, forCellWithReuseIdentifier: reuseIdentifier)

        print(container?.persistentStoreDescriptions.first?.url)
        container?.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        do {
            try self.fetchedResultController?.performFetch()
            print(self.fetchedResultController?.fetchedObjects?.count ?? 0)
        } catch let err {
            print(err.localizedDescription)
        }
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
        if let count = self.fetchedResultController?.fetchedObjects?.count {
            return count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        let item = self.fetchedResultController?.object(at: indexPath) as! Item
        //print(item.title)
        // Configure the cell
        DispatchQueue.main.async{
            cell.configure(with: item)
        }
        return cell
    }

    
    @IBAction func populateCoreData(_ sender: UIBarButtonItem) {
        if let container = self.container {
            container.viewContext.automaticallyMergesChangesFromParent = true
            let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            backgroundContext.parent = container.viewContext
            generateRandomObjects(backgroundContext: backgroundContext)
        }
    }
    
    var blockOperations: [BlockOperation] = []
   
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            
            blockOperations.append(BlockOperation(block: {
                if let newIndexPath = newIndexPath {
                    self.collectionView?.insertItems(at: [newIndexPath])
                }
            })
            )
        }
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.performBatchUpdates({
            for everyOperation in self.blockOperations {
                everyOperation.start()
            }
        }, completion: {(completed) in
            
            let lastIndex = (self.fetchedResultController?.sections![0].numberOfObjects ?? 1) - 1
            print("Total: \(lastIndex)")
            let indexPath = IndexPath(item: lastIndex, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
            do {
                try self.container?.viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror.localizedDescription), \(nserror.userInfo)")
            }
        })
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
