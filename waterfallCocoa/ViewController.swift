//
//  ViewController.swift
//  waterfallCocoa
//
//  Created by Raymond Lam on 6/15/15.
//  Copyright (c) 2015 Raymond Lam. All rights reserved.
//

import Foundation
import UIKit
import CollectionViewWaterfallLayout
import AVFoundation
import NilColorKit


class ViewController: UIViewController, UICollectionViewDataSource, CollectionViewWaterfallLayoutDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var demoUIImage: UIImageView!
    
    // Obtain random image set with random width and heights
    lazy var imageSet: [UIImage] = {
        var _imageSet = [UIImage]()
        for x in 0...100{
            let array = [600,800,900]
            let array2 = [1000,1200,1400]
            let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
            let randomIndex2 = Int(arc4random_uniform(UInt32(array2.count)))
            let urlString:String = "http://localhost:5000/depot/media/2b2cd70f-0a3b-11e5-97bf-685b358e848d"
            //let urlString:String = String(format: "http://lorempixel.com/%@/%@/", String(array[randomIndex]),String(array2[randomIndex2]))
            let image = UIImage(data: NSData(contentsOfURL: NSURL(string: urlString)!)!)
            print(urlString)
            print("\(x)\n")
            _imageSet.append(image!)
        }
        return _imageSet
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let layout = CollectionViewWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        layout.headerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.headerHeight = 100
        layout.footerHeight = 20
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.columnCount = 2
       
 
        collectionView.collectionViewLayout = layout
        collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionFooter, withReuseIdentifier: "Footer")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        collectionView.layer.masksToBounds = false
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSet.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
//        
//        if let label = cell.contentView.viewWithTag(1) as? UILabel {
//            
//            //label.text = String(stringInterpolationSegment: imageSet[indexPath.row].size)
//            
//            // Get title
//            label.text = String(indexPath.row)
//            
//            
//        }
        if let imageView = cell.contentView.viewWithTag(2) as? UIImageView {
            
            imageView.image = imageSet[indexPath.row]
        
        }
        
        
        var titleHeight:CGFloat = 44
        
        //print("\(cell.bounds)")
        var top = cell.bounds.height
        
        var titleView = UILabel(frame: CGRectMake(0, top-titleHeight, cell.bounds.width, titleHeight))
        titleView.text = "Title"
        titleView.tag = 34
        titleView.textAlignment = .Center
        titleView.backgroundColor = UIColor.whiteColor()
        titleView.textColor = UIColor.darkGrayColor()
        cell.contentView.addSubview(titleView)

        
        var animation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "opacity")
        animation.duration = 4.0
        animation.autoreverses = true
        
        cell.layer.addAnimation(animation, forKey: "opacity")
        
        cell.frame.size = CGSize(width: cell.bounds.width, height: cell.bounds.height)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView? = nil
        
        if kind == CollectionViewWaterfallElementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as? UICollectionReusableView
            if let view = reusableView {
                view.backgroundColor = UIColor.redColor()
            }
        }
        else if kind == CollectionViewWaterfallElementKindSectionFooter {
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Footer", forIndexPath: indexPath) as? UICollectionReusableView
            if let view = reusableView {
                view.backgroundColor = UIColor.blueColor()
            }
        }
        
        return reusableView!
    }
    
    // MARK: WaterfallLayoutDelegate
    
    func collectionView(collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        let thisLayout = layout as! CollectionViewWaterfallLayout
        
        
        
        
        var globalImage = imageSet[indexPath.row]
        print("\(indexPath.row)\n")
        var originalSize = imageSet[indexPath.row].size
        print("originalSize: \(originalSize)\n")
//        
//        var newHeight = globalImage.size.height+CGFloat(44)
//        var newerSize = CGSize(width: globalImage.size.width, height: newHeight)
//        
//        print("newerSize: \(newerSize) \n")
        
        

        var collectionViewContentSize = thisLayout.collectionViewContentSize()
        print("collectionViewContentSize: \(collectionViewContentSize)\n\n\n")


        return originalSize
    }

    

    

}

