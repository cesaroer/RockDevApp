//
//  ChartsViewController.swift
//  RockDevApp
//
//  Created by Cesar on 17/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints

class ChartsViewController: UIViewController, ChartViewDelegate {
    
    //Declaramos una variable de una vista para la grafica
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        
        chartView.rightAxis.enabled = false
        let yAxis  = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .insideChart
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        
        chartView.animate(xAxisDuration: 1)
        
        
        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        setData()
        
    }
    
    
//MARK: Funcion del Delegado
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: yValues, label: "Calorias")
        
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 3
        set1.setColor(.white)
        set1.fill = Fill(color: .white)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 1.0),
        ChartDataEntry(x: 1.0, y: 7.0),
        ChartDataEntry(x: 2.0, y: 6.0),
        ChartDataEntry(x: 3.0, y: 12.0),
        ChartDataEntry(x: 4.0, y: 18.0),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 6.0, y: 11.0),
        ChartDataEntry(x: 7.0, y: 15.0),
        ChartDataEntry(x: 8.0, y: 17.0),
        ChartDataEntry(x: 9.0, y: 18.0),
        ChartDataEntry(x: 10.0, y: 10.0),
        ChartDataEntry(x: 11.0, y: 5.0),
        ChartDataEntry(x: 12.0, y: 6.0),
        ChartDataEntry(x: 13.0, y: 10.0),
        ChartDataEntry(x: 14.0, y: 10.0),
        ChartDataEntry(x: 15.0, y: 13.0)
        
    ]
    


}
