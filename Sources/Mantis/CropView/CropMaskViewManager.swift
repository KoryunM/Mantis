//
//  CropMaskViewManager.swift
//  Mantis
//
//  Created by Echo on 10/28/18.
//  Copyright © 2018 Echo. All rights reserved.
//

import UIKit

final class CropMaskViewManager {
    private let visualEffectView: CropMaskProtocol
    private(set) var maskViews: [CropMaskProtocol]
    
    init(visualEffectView: CropMaskProtocol) {
        self.visualEffectView = visualEffectView
        maskViews = [visualEffectView]
    }
        
    private func showDimmingBackground() {
        visualEffectView.alpha = 0
    }

    private func showVisualEffectBackground() {
        self.visualEffectView.alpha = 1
    }
}

extension CropMaskViewManager: CropMaskViewManagerProtocol {
    func setup(in view: UIView, cropRatio: CGFloat = 1.0) {
        maskViews.forEach { maskView in
            maskView.initialize(cropRatio: cropRatio)
            maskView.isUserInteractionEnabled = false
            view.addSubview(maskView)
        }

        showVisualEffectBackground()
    }
    
    func removeMaskViews() {
        maskViews.forEach { $0.removeFromSuperview() }
    }
    
    func showDimmingBackground(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.1) {
                self.showDimmingBackground()
            }
        } else {
            showDimmingBackground()
        }
    }
    
    func showVisualEffectBackground(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.5) {
                self.showVisualEffectBackground()
            }
        } else {
            showVisualEffectBackground()
        }
    }
    
    func adaptMaskTo(match cropRect: CGRect, cropRatio: CGFloat) {
        maskViews.forEach { $0.adaptMaskTo(match: cropRect, cropRatio: cropRatio) }
    }
}
