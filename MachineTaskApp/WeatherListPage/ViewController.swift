//
//  ViewController.swift
//  E2WeatherApp
//
//  Created by Manikandan on 12/03/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    var productCount = 100 // Set the product count dynamically
    var bannerScrollView: UIScrollView!
    var currentPageIndex = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Header
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 50))
        headerLabel.text = "App Name"
        headerLabel.textAlignment = .center
        view.addSubview(headerLabel)
        
        // Banner Image
        bannerScrollView = UIScrollView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 200))
        bannerScrollView.isPagingEnabled = true
        view.addSubview(bannerScrollView)
        
        var xPosition: CGFloat = 0
        for i in 1...5 {
            let imageView = UIImageView(frame: CGRect(x: xPosition, y: 0, width: view.frame.width, height: 200))
            imageView.image = UIImage(named: "image\(i)") // Replace with actual image names
            bannerScrollView.addSubview(imageView)
            
            xPosition += view.frame.width
        }
        bannerScrollView.contentSize = CGSize(width: view.frame.width * 5, height: 200)
        
        // Start auto sliding
        startAutoSlide()
        
        // Products and Videos
        var yPosition: CGFloat = 320
        var productIndex = 1
        
        let productScrollView = UIScrollView(frame: CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height - yPosition))
        view.addSubview(productScrollView)
        
        for i in stride(from: 0, to: productCount, by: 4) {
            // Product Section
            let productLabel1 = UILabel(frame: CGRect(x: 20, y: yPosition, width: (view.frame.width - 40) / 4, height: 30))
            productLabel1.text = "\(i + 1)"
            productLabel1.numberOfLines = 0
            productLabel1.textAlignment = .center
            productLabel1.backgroundColor = .gray
            productScrollView.addSubview(productLabel1)
            
            let productLabel2 = UILabel(frame: CGRect(x: view.frame.width / 4 + 20, y: yPosition, width: (view.frame.width - 40) / 4, height: 30))
            productLabel2.text = "\(i + 2)"
            productLabel2.numberOfLines = 0
            productLabel2.textAlignment = .center
            productLabel2.backgroundColor = .gray
            productScrollView.addSubview(productLabel2)
            
            let productLabel3 = UILabel(frame: CGRect(x: view.frame.width / 2 + 20, y: yPosition, width: (view.frame.width - 40) / 4, height: 30))
            productLabel3.text = "\(i + 3)"
            productLabel3.numberOfLines = 0
            productLabel3.textAlignment = .center
            productLabel3.backgroundColor = .gray
            productScrollView.addSubview(productLabel3)
            
            let productLabel4 = UILabel(frame: CGRect(x: view.frame.width * 3 / 4 + 20, y: yPosition, width: (view.frame.width - 40) / 4, height: 30))
            productLabel4.text = "\(i + 4)"
            productLabel4.numberOfLines = 0
            productLabel4.textAlignment = .center
            productLabel4.backgroundColor = .gray
            productScrollView.addSubview(productLabel4)
            
            // Video Section
            let videoScrollView = UIScrollView(frame: CGRect(x: 0, y: yPosition + 40, width: view.frame.width, height: 150))
            productScrollView.addSubview(videoScrollView)
            
            var xVideoPosition: CGFloat = 20
            for j in 1...20 {
                let videoLabel = UILabel(frame: CGRect(x: xVideoPosition, y: 0, width: 100, height: 150))
                videoLabel.text = "Section \(productIndex) V\(j)"
                videoLabel.backgroundColor = UIColor(red: CGFloat(j) / 20.0, green: 0.7, blue: 0.7, alpha: 1.0) // Adjust color here
                videoLabel.textAlignment = .center
                videoLabel.layer.cornerRadius = 5 // Add corner radius for rounded corners
                videoLabel.clipsToBounds = true
                videoScrollView.addSubview(videoLabel)
                
                xVideoPosition += 120 // Adjust spacing between video labels
            }
            videoScrollView.contentSize = CGSize(width: xVideoPosition, height: 150)
            
            yPosition += 200
            productIndex += 1
        }
        productScrollView.contentSize = CGSize(width: view.frame.width, height: yPosition)
    }
    
    // Start auto sliding
    func startAutoSlide() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoSlide), userInfo: nil, repeats: true)
    }
    
    // Auto slide function
    @objc func autoSlide() {
        currentPageIndex += 1
        let nextPage = currentPageIndex % 5
        let contentOffset = CGPoint(x: CGFloat(nextPage) * bannerScrollView.frame.width, y: 0)
        bannerScrollView.setContentOffset(contentOffset, animated: true)
    }
    
    // Invalidate timer when user starts scrolling manually
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    // Resume auto sliding when user stops scrolling manually
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAutoSlide()
    }
    
    // Update current page index when scrolling ends
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCurrentPageIndex()
    }
    
    // Update current page index when scrolling ends (if scrolling was animated)
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateCurrentPageIndex()
    }
    
    // Update current page index based on scroll view content offset
    func updateCurrentPageIndex() {
        let pageIndex = Int(bannerScrollView.contentOffset.x / bannerScrollView.frame.width)
        currentPageIndex = pageIndex
    }
    
    // Invalidate timer when view disappears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
}

