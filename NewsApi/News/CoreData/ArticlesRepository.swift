//
//  ArticlesRepository.swift
//  NewsApi
//
//  Created by Nurzhigit Smailov on 7/16/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import CoreData
import UIKit

class ArticlesRepository {
    
    private static var managedContext: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Friend Core Data CRUD
    
    static func createArticle(author: String, title: String, description: String,
                              urlToImage: String, url: String, publishedAt: String) throws {
        guard let managedContext = self.managedContext else { return }
        let entity = NSEntityDescription.entity(forEntityName: "ArticleDB", in: managedContext)!
        let article = NSManagedObject(entity: entity, insertInto: managedContext)
        
        article.setValue(author, forKeyPath: "author")
        article.setValue(title, forKeyPath: "title")
        article.setValue(description, forKeyPath: "descriptionDB")
        
        article.setValue(urlToImage, forKeyPath: "urlToImage")
        article.setValue(url, forKeyPath: "url")
        article.setValue(publishedAt, forKeyPath: "publishedAt")
        
        try managedContext.save()
    }
    
    static func retrieveArticles(usingFilter filter: Filter = .none) -> [Articles] {
        guard let managedContext = self.managedContext else { return [] }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ArticleDB")
        
        switch filter {
            case .ascendingOrder:
                fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "author", ascending: true)]
            case .descendingOrder:
                fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "author", ascending: false)]
            case .search(let text):
                fetchRequest.predicate = NSPredicate(format: "author contains[c] %@", text)
            case .none:
                break
        }
        
        do {
            return try managedContext.fetch(fetchRequest).map {
                
                let author = ($0.value(forKey: "author") as? String) ?? ""
                let title = ($0.value(forKey: "title")  as? String) ?? ""
                let description = ($0.value(forKey: "descriptionDB")  as? String) ?? ""
                let urlToImage = ($0.value(forKey: "urlToImage")  as? String) ?? ""
                let url = ($0.value(forKey: "url")  as? String) ?? ""
                let publishedAt = ($0.value(forKey: "publishedAt")  as? String) ?? ""
                
                return Articles(author: author, title: title, description: description,
                                urlToImage: urlToImage, url: url, publishedAt: publishedAt)
            }
        } catch {
            return []
        }
    }
    
//    static func updateArticle(withName name: String, to newName: String) throws {
//        guard let managedContext = self.managedContext else { return }
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ArticleDB")
//        fetchRequest.predicate = NSPredicate(format: "author = %@", name)
//        let fetchResult = try managedContext.fetch(fetchRequest)
//        guard let message = fetchResult.first else { return }
//        message.setValue(newName, forKey: "author")
//        try managedContext.save()
//    }
    
    static func deleteArticle(withName name: String) throws {
        guard let managedContext = self.managedContext else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ArticleDB")
        fetchRequest.predicate = NSPredicate(format: "author = %@", name)
        let fetchResult = try managedContext.fetch(fetchRequest)
        guard let friend = fetchResult.first else { return }
        managedContext.delete(friend)
        try managedContext.save()
    }
}
