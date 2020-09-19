//
//  NewFeatureVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 8/31/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit

class NewFeatureVC: UIViewController {

    var timer = Timer()
      var counter = 0
    
    var imgArr = ["1_Educative_screen","2_Educative_screen","3_Educative_screen","4_Educative_screen","5_Educative_screen","img6"]

    
    
    @IBOutlet weak var btnDismiss: UIButton!
    @IBOutlet weak var viewContents: UIView!
    @IBOutlet weak var listCollectionView: UICollectionView!{
        didSet {
            self.listCollectionView.delegate = self
            self.listCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var pageController: UIPageControl!
    
    
 
    fileprivate var currentPage: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewContents.shadow(UIView: self.viewContents)
   
        
        pageController.numberOfPages = imgArr.count
        pageController.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
    }

    @IBAction func didTapDismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pageCpntrollerAction(_ sender: UIPageControl) {
        
    }
    

    @objc func changeImage() {
     
     if counter < imgArr.count {
         let index = IndexPath.init(item: counter, section: 0)
         self.listCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
         pageController.currentPage = counter
         counter += 1
     } else {
         counter = 0
         let index = IndexPath.init(item: counter, section: 0)
         self.listCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
         pageController.currentPage = counter
         counter = 1
     }
         
     }
    
    
    
//    @objc
//    func scrollAutomatically(_ timer1: Timer) {
//        scrollItem()
//    }
    
//    private func scrollItem() {
//        if let coll  = self.listCollectionView {
//            for cell in coll.visibleCells {
//                if let indexPath = coll.indexPath(for: cell) {
//                    if ((indexPath.row)  < (self.imgArr.count)  - 1) {
//
//                        let indexPath1 = IndexPath.init(row: (indexPath.row) + 1, section: (indexPath.section))
//                        self.pageController.currentPage = indexPath1.item
//                        coll.scrollToItem(at: indexPath1, at: .centeredHorizontally, animated: true)
//                    } else {
//                        let indexPath1s = IndexPath.init(row: 0, section: 0)
//                        self.pageController.currentPage = indexPath1s.item
//                        coll.scrollToItem(at: indexPath1s, at: .centeredHorizontally, animated: true)
//                    }
//                }
//            }
//        }
//    }
}

//****Collection View delegate & UICollectionViewDataSource.
extension NewFeatureVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "NewFeatureCollectionViewCell", for: indexPath) as? NewFeatureCollectionViewCell  else { return UICollectionViewCell()}
        cell.imgView.image = UIImage(named: self.imgArr[indexPath.row])
        return cell
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if (scrollView == listCollectionView) {
//            pageController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        }
//    }
    
    // scroll view events
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageSide = self.listCollectionView.frame.width
        let offset = scrollView.contentOffset.x
        currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
            //Int(floor((offset - pageSide / 2) / pageSide) + 1)
        pageController.currentPage = currentPage
        print("currentPage " + currentPage.description)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
            if collectionView == listCollectionView {
                self.pageController.currentPage = indexPath.item
            }
        }
    
}
