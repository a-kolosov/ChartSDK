//
//  ViewController.swift
//  ChartSDK
//
//  Created by Anton Kolosov on 11/29/2019.
//  Copyright (c) 2019 Anton Kolosov. All rights reserved.
//

import UIKit
import ChartSDK

class ViewController: UIViewController {
    @IBOutlet weak var pieChartView: PieChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        pieChartView.sectors = generateData()
        pieChartView.sectorSeparatorStyle = .line(width: 4, color: .white)
        pieChartView.radius = 100
    }

    @IBAction func onGenerateDataButton(_ sender: Any) {
        pieChartView.sectors = generateData()
    }
    
    private func generateData() -> [PieChart.SectorData] {
        var percents = [Float]()
        
        while percents.reduce(0, {x, y in x + y}) < 1 {
            let random = Float.random(in: 0.1...0.5)
            percents.append(random)
        }
        
        percents.removeLast()
        let lastValue = 1 - percents.reduce(0, {x, y in x + y})
        percents.append(lastValue)
        
        var colors = [UIColor]()
        var strings = [String]()
        for i in 0..<percents.count {
            let red = CGFloat.random(in: 0...254) / 255.0
            let green = CGFloat.random(in: 0...254) / 255.0
            let blue = CGFloat.random(in: 0...254) / 255.0
            
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            colors.append(color)
            
            let string = String(format: "%.f", percents[i] * 100) + " %"
            strings.append(string)
        }
        
        var sectors = [PieChart.SectorData]()
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 12.0),
            .foregroundColor: UIColor.black
        ]
        for i in 0..<percents.count {
            let string = NSAttributedString(string: strings[i], attributes: attributes)
            let sector = PieChart.SectorData(percentage: percents[i], color: colors[i], text: string)
            sectors.append(sector)
        }
        
        return sectors
    }
}

