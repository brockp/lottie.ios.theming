//
//  DownloadViewController.swift
//  SwiftLottie
//
//  Created by Brock Carrington Prescott on 10/27/21.
//

import UIKit
import Lottie

// ENUM targeting frames for each stage of animation
enum DownloadKeyFrames: CGFloat {
    case startProgress = 0
    case endProgress = 90
    case completion = 118
}

class DownloadViewController: UIViewController {
    
    @IBOutlet weak var progressAnimationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressAnimationView.backgroundColor = .clear
        
        startProgress()
    }
    
    // Three staged animation functions
    
    // Start first stage from frame 0 to frame 0
    private func startProgress() {
        progressAnimationView.play(
            fromFrame: 0,
            toFrame: DownloadKeyFrames.startProgress.rawValue,
            loopMode: .none) {
            [weak self]
            (_) in
            // Invoke second stage (below)
            self?.download()
        }
    }
    
    // Start second stage from frame 0 to frame 90
    private func startDownload() {
        progressAnimationView.play(
            fromFrame: DownloadKeyFrames.startProgress.rawValue,
            toFrame: DownloadKeyFrames.endProgress.rawValue,
            loopMode: .none) {
            [weak self]
            (_) in
            // Invoke third stage (below)
            self?.endProgress()
        }
    }
    
    // Start progress function that calls a download to trigger multi-stage animation
    private func progress(to progress: CGFloat) {
        let progressRange =
            DownloadKeyFrames.endProgress.rawValue -
            DownloadKeyFrames.startProgress.rawValue
        
        let progressFrame = progressRange*progress
        let currentFrame = progressFrame + DownloadKeyFrames.startProgress.rawValue
        
        progressAnimationView.currentFrame = currentFrame
    }
    
    // Start third stage from frame 90 to frame 118
    private func endProgress() {
        progressAnimationView.play(
            fromFrame: DownloadKeyFrames.endProgress.rawValue,
            toFrame: DownloadKeyFrames.completion.rawValue,
            loopMode: .none) {
            (_) in
        }
    }
}


// Simulate actual download to trigger the multi-staged animation above
extension DownloadViewController: URLSessionDownloadDelegate {
    
    private func download() {
        let url = URL(string: "https://archive.org/download/kittenscatsbooko00grov/kittenscatsbooko00grov.epub")!
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentDownloaded: CGFloat = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.progress(to: percentDownloaded)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
            self.endProgress()
        }
    }
}
