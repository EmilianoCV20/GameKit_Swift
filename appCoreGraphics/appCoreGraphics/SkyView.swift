//
//  GameScene.swift
//  appCoreGraphics
//
//  Created by Emiliano Cepeda on 02/12/24.
//

import UIKit

class SkyView: UIView {
    private var rageLevel: RageLevel = .happy
    
    func setRageLevel(_ rageLevel: RageLevel) {
        self.rageLevel = rageLevel
        setNeedsDisplay()
    }
    
    private func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
        return CGFloat.pi * degrees/180.0
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        drawSky(in: rect, rageLevel: rageLevel, context: context, colorSpace: colorSpace)
        drawMountains(in: rect, in: context, with: colorSpace)
        drawGrass(in: rect, in: context, with: colorSpace)
        drawFlowers(in: rect, rageLevel: rageLevel, in: context, with: colorSpace)
    }
    
    private func drawSky(in rect: CGRect, rageLevel: RageLevel, context: CGContext, colorSpace: CGColorSpace) {
        let baseColor: UIColor
        let middleStop: UIColor
        let farStop: UIColor
        
        switch rageLevel {
        case .happy:
            baseColor = UIColor(red: 0 / 255.0, green: 158.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
            middleStop = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
            farStop = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        case .somewhatHappy:
            baseColor = UIColor(red: 0 / 255.0, green: 158.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
            middleStop = UIColor(red: 144.0 / 255.0, green: 152.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0)
            farStop = UIColor(red: 96.0 / 255.0, green: 111.0 / 255.0, blue: 144.0 / 255.0, alpha: 1.0)
        case .neutral:
            baseColor = UIColor(red: 148.0 / 255.0, green: 158.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
            middleStop = UIColor(red: 127.0 / 255.0, green: 138.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
            farStop = UIColor(red: 96.0 / 255.0, green: 111.0 / 255.0, blue: 144.0 / 255.0, alpha: 1.0)
        case .somewhatAngry:
            baseColor = UIColor(red: 255.0 / 255.0, green: 147.0 / 255.0, blue: 167.0 / 255.0, alpha: 1.0)
            middleStop = UIColor(red: 127.0 / 255.0, green: 138.0 / 255.0, blue: 166.0 / 255.0, alpha: 1.0)
            farStop = UIColor(red: 107.0 / 255.0, green: 107.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
        case .angry:
            baseColor = UIColor(red: 255.0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
            middleStop = UIColor(red: 140.0 / 255.0, green: 33.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
            farStop = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
        }
        
        context.saveGState()
        defer { context.restoreGState() }
        
        let gradientColors = [baseColor.cgColor, middleStop.cgColor, farStop.cgColor]
        let locations: [CGFloat] = [0.0, 0.1, 0.25]
        
        let startPoint = CGPoint(x: rect.size.height/2, y: 0)
        let endPoint = CGPoint(x: rect.size.height/2, y: rect.size.width)
        
        if let gradient = CGGradient.init(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: locations) {
            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        }
    }
    
    private func drawMountains(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
        let rectWidth = rect.size.width
        
        // Define colors based on rage level
        let darkColor: UIColor
        let lightColor: UIColor
        
        switch rageLevel {
        case .happy:
            darkColor = UIColor(red: 1.0 / 255.0, green: 93.0 / 255.0, blue: 67.0 / 255.0, alpha: 1)
            lightColor = UIColor(red: 63.0 / 255.0, green: 109.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        case .somewhatHappy:
            darkColor = UIColor(red: 63.0 / 255.0, green: 109.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
            lightColor = UIColor(red: 100.0 / 255.0, green: 140.0 / 255.0, blue: 100.0 / 255.0, alpha: 1)
        case .neutral:
            darkColor = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1)
            lightColor = UIColor(red: 140.0 / 255.0, green: 140.0 / 255.0, blue: 140.0 / 255.0, alpha: 1)
        case .somewhatAngry:
            darkColor = UIColor(red: 139.0 / 255.0, green: 50.0 / 255.0, blue: 10.0 / 255.0, alpha: 1)
            lightColor = UIColor(red: 180.0 / 255.0, green: 133.0 / 255.0, blue: 63.0 / 255.0, alpha: 1)
        case .angry:
            darkColor = UIColor(red: 139.0 / 255.0, green: 25.0 / 255.0, blue: 25.0 / 255.0, alpha: 1)
            lightColor = UIColor(red: 255.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
        }
        
        guard let mountainGrad = CGGradient(colorsSpace: colorSpace, colors: [darkColor.cgColor, lightColor.cgColor] as CFArray, locations: [0.1, 0.2]) else {
            return
        }
        
        let mountainStart = CGPoint(x: rect.size.height / 2, y: 100)
        let mountainEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)
        
        context.saveGState()
        defer { context.restoreGState() }
        
        // Random factor for variation
        func randomOffset(range: CGFloat) -> CGFloat {
            return CGFloat.random(in: -range...range)
        }
        
        // Background Mountains
        let backgroundMountains = CGMutablePath()
        backgroundMountains.move(to: CGPoint(x: -5, y: 157))
        backgroundMountains.addQuadCurve(to: CGPoint(x: 77, y: 157 + randomOffset(range: 10)),
                                         control: CGPoint(x: 30, y: 129 + randomOffset(range: 15)))
        backgroundMountains.addCurve(to: CGPoint(x: 303, y: 125 + randomOffset(range: 20)),
                                      control1: CGPoint(x: 190, y: 210 + randomOffset(range: 20)),
                                      control2: CGPoint(x: 200, y: 70 + randomOffset(range: 20)))
        backgroundMountains.addQuadCurve(to: CGPoint(x: 350, y: 150 + randomOffset(range: 10)),
                                         control: CGPoint(x: 340, y: 150))
        backgroundMountains.addQuadCurve(to: CGPoint(x: 410, y: 145 + randomOffset(range: 10)),
                                         control: CGPoint(x: 380, y: 155))
        backgroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 165 + randomOffset(range: 15)),
                                      control1: CGPoint(x: rectWidth - 90, y: 100),
                                      control2: CGPoint(x: rectWidth - 50, y: 190))
        backgroundMountains.addLine(to: CGPoint(x: rectWidth - 10, y: rect.size.width))
        backgroundMountains.addLine(to: CGPoint(x: -5, y: rect.size.width))
        backgroundMountains.closeSubpath()
        
        // Background Mountain Drawing
        context.addPath(backgroundMountains)
        context.clip()
        context.drawLinearGradient(mountainGrad, start: mountainStart, end: mountainEnd, options: [])
        
        // Foreground Mountains
        let foregroundMountains = CGMutablePath()
        foregroundMountains.move(to: CGPoint(x: -5, y: 190))
        foregroundMountains.addCurve(to: CGPoint(x: 303, y: 190 + randomOffset(range: 15)),
                                      control1: CGPoint(x: 160, y: 250 + randomOffset(range: 20)),
                                      control2: CGPoint(x: 200, y: 140 + randomOffset(range: 15)))
        foregroundMountains.addCurve(to: CGPoint(x: rectWidth, y: 210 + randomOffset(range: 10)),
                                      control1: CGPoint(x: rectWidth - 150, y: 250 + randomOffset(range: 15)),
                                      control2: CGPoint(x: rectWidth - 50, y: 170))
        foregroundMountains.addLine(to: CGPoint(x: rectWidth, y: 230))
        foregroundMountains.addCurve(to: CGPoint(x: -5, y: 225),
                                      control1: CGPoint(x: 300, y: 260),
                                      control2: CGPoint(x: 140, y: 215))
        foregroundMountains.closeSubpath()
        
        // Foreground Mountain Drawing
        context.addPath(foregroundMountains)
        context.clip()
        context.setFillColor(darkColor.cgColor)
        context.fill(CGRect(x: 0, y: 170, width: rectWidth, height: 90))
    }


    
    private func drawGrass(in rect: CGRect, in context: CGContext, with colorSpace: CGColorSpace?) {
        context.saveGState()
        defer { context.restoreGState() }
        
        let grassStart = CGPoint(x: rect.size.height / 2, y: 100)
        let grassEnd = CGPoint(x: rect.size.height / 2, y: rect.size.width)
        let rectWidth = rect.size.width
        
        let grass = CGMutablePath()
        grass.move(to: CGPoint(x: rectWidth, y: 230), transform: .identity)
        grass.addCurve(to: CGPoint(x: 0, y: 225), control1: CGPoint(x: 300, y: 260), control2: CGPoint(x: 140, y: 215), transform: .identity)
        grass.addLine(to: CGPoint(x: 0, y: rect.size.width), transform: .identity)
        grass.addLine(to: CGPoint(x: rectWidth, y: rect.size.width), transform: .identity)
        
        context.addPath(grass)
        context.clip()
        
        let lightGreen = UIColor(red: 39.0 / 255.0, green: 171.0 / 255.0, blue: 95.0 / 255.0, alpha: 1)
        let darkGreen = UIColor(red: 0.0 / 255.0, green: 134.0 / 255.0, blue: 61.0 / 255.0, alpha: 1)
        
        let lightBrown = UIColor(red: 205.0 / 255.0, green: 133.0 / 255.0, blue: 63.0 / 255.0, alpha: 1)
        let Brown = UIColor(red: 139.0 / 255.0, green: 69.0 / 255.0, blue: 19.0 / 255.0, alpha: 1)
        
        let darkRed = UIColor(red: 139.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
        let Red = UIColor(red: 255.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
        
        let grassColors = [lightGreen.cgColor, darkGreen.cgColor]
        let grassLocations: [CGFloat] = [0.3, 0.4]
        if let grassGrad = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) {
            context.drawLinearGradient(grassGrad, start: grassStart, end: grassEnd, options: [])
        }
        
        switch rageLevel {
        case .happy:
            let grassColors = [lightGreen.cgColor, darkGreen.cgColor]
            let grassLocations: [CGFloat] = [0.3, 0.4]
            if let grassGrad = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) {
                context.drawLinearGradient(grassGrad, start: grassStart, end: grassEnd, options: [])
            }
        case .somewhatHappy:
            let grassColors = [lightGreen.cgColor, darkGreen.cgColor]
            let grassLocations: [CGFloat] = [0.3, 0.4]
            if let grassGrad = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) {
                context.drawLinearGradient(grassGrad, start: grassStart, end: grassEnd, options: [])
            }
        case .neutral:
            let grassColors = [lightBrown.cgColor, Brown.cgColor]
            let grassLocations: [CGFloat] = [0.3, 0.4]
            if let grassGrad = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) {
                context.drawLinearGradient(grassGrad, start: grassStart, end: grassEnd, options: [])
            }
        case .somewhatAngry:
            let grassColors = [lightBrown.cgColor, Brown.cgColor]
            let grassLocations: [CGFloat] = [0.3, 0.4]
            if let grassGrad = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) {
                context.drawLinearGradient(grassGrad, start: grassStart, end: grassEnd, options: [])
            }
        case .angry:
            let grassColors = [Red.cgColor, darkRed.cgColor]
            let grassLocations: [CGFloat] = [0.3, 0.4]
            if let grassGrad = CGGradient.init(colorsSpace: colorSpace, colors: grassColors as CFArray, locations: grassLocations) {
                context.drawLinearGradient(grassGrad, start: grassStart, end: grassEnd, options: [])
            }
        }
        
        context.setLineWidth(1)
        context.setFillColor(UIColor.white.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
    }
    
    private func drawPetal(in rect: CGRect, inDegrees degrees: Int, inContext context: CGContext) {
        context.saveGState()
        defer { context.restoreGState() }
        
        let flowerPetal = CGMutablePath()
        
        let midX = rect.midX
        let midY = rect.midY
        
        let transform = CGAffineTransform(translationX: -midX, y: -midY).concatenating(CGAffineTransform(rotationAngle:
                                                                                                            degreesToRadians(CGFloat(degrees)))).concatenating(CGAffineTransform(translationX: midX, y: midY))
        
        switch rageLevel {
        case .happy:
            flowerPetal.addEllipse(in: rect, transform: transform)
            context.addPath(flowerPetal)
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            context.setFillColor(UIColor.white.cgColor)
            context.addPath(flowerPetal)
            context.fillPath()
        case .somewhatHappy:
            flowerPetal.addEllipse(in: rect, transform: transform)
            context.addPath(flowerPetal)
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            context.setFillColor(UIColor.lightGray.cgColor)
            context.addPath(flowerPetal)
            context.fillPath()
        case .neutral:
            flowerPetal.addEllipse(in: rect, transform: transform)
            context.addPath(flowerPetal)
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            context.setFillColor(UIColor.gray.cgColor)
            context.addPath(flowerPetal)
            context.fillPath()
        case .somewhatAngry:
            flowerPetal.addEllipse(in: rect, transform: transform)
            context.addPath(flowerPetal)
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            context.setFillColor(UIColor.brown.cgColor)
            context.addPath(flowerPetal)
            context.fillPath()
        case .angry:
            flowerPetal.addEllipse(in: rect, transform: transform)
            context.addPath(flowerPetal)
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            context.setFillColor(UIColor.red.cgColor)
            context.addPath(flowerPetal)
            context.fillPath()
        }
        
    }
    
    private func drawFlowers(in rect: CGRect, rageLevel: RageLevel, in context: CGContext, with colorSpace: CGColorSpace?) {
        context.saveGState()
        defer { context.restoreGState() }
        
        let flowerSize = CGSize(width: 300, height: 300)
        guard let flowerLayer = CGLayer(context, size: flowerSize, auxiliaryInfo: nil) else {
            return
        }
        
        guard let flowerContext = flowerLayer.context else {
            return
        }
        
        // Draw petals of the flower
        drawPetal(in: CGRect(x: 125, y: 230, width: 9, height: 14), inDegrees: 0, inContext: flowerContext)
        drawPetal(in: CGRect(x: 115, y: 236, width: 10, height: 12), inDegrees: 300, inContext: flowerContext)
        drawPetal(in: CGRect(x: 120, y: 246, width: 9, height: 14), inDegrees: 5, inContext: flowerContext)
        drawPetal(in: CGRect(x: 128, y: 246, width: 9, height: 14), inDegrees: 350, inContext: flowerContext)
        drawPetal(in: CGRect(x: 133, y: 236, width: 11, height: 14), inDegrees: 80, inContext: flowerContext)
        
        let center = CGMutablePath()
        let ellipse = CGRect(x: 126, y: 242, width: 6, height: 6)
        center.addEllipse(in: ellipse, transform: .identity)
        
        let orangeColor = UIColor(red: 255 / 255.0, green: 174 / 255.0, blue: 49.0 / 255.0, alpha: 1.0)
        
        let brownColor = UIColor(red: 2/255.0, green: 160/255.0, blue: 100/255.0, alpha: 1.0)
        
        // Draw flower
        flowerContext.addPath(center)
        flowerContext.setStrokeColor(UIColor.black.cgColor)
        flowerContext.strokePath()
        flowerContext.setFillColor(orangeColor.cgColor)
        flowerContext.addPath(center)
        flowerContext.fillPath()
        flowerContext.move(to: CGPoint(x: 135, y: 249))
        context.setStrokeColor(UIColor.black.cgColor)
        flowerContext.addQuadCurve(to: CGPoint(x: 133, y: 270), control: CGPoint(x: 145, y: 250))
        flowerContext.strokePath()
        
        // Draw clones
        switch rageLevel {
        case .happy:
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
            context.translateBy(x: 20, y: 10)
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
            context.translateBy(x: -30, y: 5)
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
            context.translateBy(x: -20, y: -10)
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        case .somewhatHappy:
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
            context.translateBy(x: 20, y: 10)
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
            context.translateBy(x: -30, y: 5)
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        case .neutral:
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
            context.translateBy(x: 20, y: 10)
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        case .somewhatAngry:
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        case .angry:
            flowerContext.addPath(center)
            flowerContext.setStrokeColor(UIColor.orange.cgColor)
            flowerContext.strokePath()
            flowerContext.setFillColor(brownColor.cgColor)
            flowerContext.addPath(center)
            flowerContext.fillPath()
            flowerContext.move(to: CGPoint(x: 135, y: 249))
            context.setStrokeColor(UIColor.red.cgColor)
            flowerContext.addQuadCurve(to: CGPoint(x: 133, y: 270), control: CGPoint(x: 145, y: 250))
            flowerContext.strokePath()
            
            context.draw(flowerLayer, at: CGPoint(x: 0, y: 0))
        }
        
        
    }
}
