//
//  CoinChartView.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-23.
//

import SwiftUI

struct CoinChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0.0
        minY = data.min() ?? 0.0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = (priceChange > 0) ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeokoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background {
                   chartViewBackground
                }
                .overlay(alignment: .leading) {
                    chartYAxis
                        .padding(.horizontal, 4)
            }
            
           chartDateLabels
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }
    }
}

struct CoinChartView_Previews: PreviewProvider {
    static var previews: some View {
        CoinChartView(coin: dev.coin)
    }
}

extension CoinChartView {
    private var chartView: some View {
        GeometryReader { geometry in // so that the chart can be dynamic sized
            Path { path in
                for index in data.indices {
                    
                    // Width: 300
                    // items in arrays: 100
                    // each item's x point = 300/100 = 3
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    // maxY = 60,000
                    // minY = 50,000
                    // 60,000 - 50,000 = 10,000 - yAxis
                    // 52, 000 - data point
                    // 52000 - 50000 = 2000/ 10000 = 20%
                    
                    let yAxis = maxY - minY
                    // Coordinate system is inverted
                    // 0 at the top, 100 at the bottom
                    // 20% => 1 - 20%
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
        }
    }
    
    private var chartViewBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
