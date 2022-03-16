//
//  SpiderWebChartView.swift
//  Superheroes
//
//  Created by Adam Cseke on 2022. 03. 11..
//  Copyright © 2022. levivig. All rights reserved.
//

import Charts
import UIKit

class SpiderWebChartView: UIView {
    
    private var dataSet: RadarChartDataSet!
    private var chartView: RadarChartView!
    private let screenSize = UIScreen.main.bounds.width
    
    public var entries: [Double] = [] {
        didSet {
            dataSet = RadarChartDataSet(entries: [
            RadarChartDataEntry(value: entries[0]),
            RadarChartDataEntry(value: entries[1]),
            RadarChartDataEntry(value: entries[2]),
            RadarChartDataEntry(value: entries[3]),
            RadarChartDataEntry(value: entries[4]),
            RadarChartDataEntry(value: entries[5])
            ])
            dataSet.colors = [Colors.orange.color]
            dataSet.fillColor = Colors.orange.color.withAlphaComponent(0.6)
            dataSet.drawFilledEnabled = true
            dataSet.lineWidth = 2
            dataSet.valueFormatter = DataSetValueFormatter()
            let data = RadarChartData(dataSet: dataSet)
            chartView.data = data
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        snp.makeConstraints { make in
            make.height.equalTo(screenSize)
            make.width.equalTo(screenSize)
        }
        configureRadarChartView()
    }
    
    private func configureRadarChartView() {
        chartView = RadarChartView()
        chartView.delegate = self
        chartView.webLineWidth = 1.5
        chartView.innerWebLineWidth = 1.5
        chartView.webColor = .lightGray
        chartView.innerWebColor = .lightGray
        chartView.rotationEnabled = false
        chartView.legend.enabled = false
        chartView.animate(xAxisDuration: 1.6, yAxisDuration: 1.6, easingOption: .easeInBack)
        
        addSubview(chartView)
        
        chartView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(screenSize)
        }
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = FontFamily.Gotham.medium.font(size: 16)
        xAxis.labelTextColor = .label
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = XAxisFormatter()

        let yAxis = chartView.yAxis
        yAxis.labelCount = 5
        yAxis.drawTopYLabelEntryEnabled = false
        yAxis.drawBottomYLabelEntryEnabled = false
        yAxis.axisMinimum = 0
        yAxis.valueFormatter = YAxisFormatter()
    }
}

extension SpiderWebChartView: ChartViewDelegate {
    
}

class DataSetValueFormatter: IValueFormatter {
    
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        ""
    }
}

class XAxisFormatter: IAxisValueFormatter {
    
    let titles = [L10n.DetailViewController.Powerstats.intelligence,
                  L10n.DetailViewController.Powerstats.strength,
                  L10n.DetailViewController.Powerstats.speed,
                  L10n.DetailViewController.Powerstats.duranility,
                  L10n.DetailViewController.Powerstats.power,
                  L10n.DetailViewController.Powerstats.combat
    ].map() { "\($0)" }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        titles[Int(value) % titles.count]
    }
}

class YAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        ""
    }
}
