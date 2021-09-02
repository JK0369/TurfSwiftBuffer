//
//  ViewController.swift
//  TurfSwiftBuffer
//
//  Created by JK0369 on 09/02/2021.
//  Copyright (c) 2021 JK0369. All rights reserved.
//

import UIKit
import TurfSwiftBuffer
import CoreLocation
import MapKit

class ViewController: UIViewController {

    lazy var mapView: MKMapView = {
        let view = MKMapView()

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        let polygon = [CLLocationCoordinate2D(latitude: 37.98109102966798, longitude: 127.39635998969223),
                        CLLocationCoordinate2D(latitude: 36.829155530408705, longitude: 126.49548108344223),
                        CLLocationCoordinate2D(latitude: 34.61747168678542, longitude: 126.50646741156723),
                        CLLocationCoordinate2D(latitude: 35.023333179322684, longitude: 128.41808850531723),
                        CLLocationCoordinate2D(latitude: 36.53841205716619, longitude: 129.28600842719223),
                        CLLocationCoordinate2D(latitude: 37.48583761259624, longitude: 128.52795178656723)]

        for i in 0..<polygon.count {
            let point = MKPointAnnotation()
            point.title = "\(i)"
            point.coordinate = polygon[i]
            mapView.addAnnotation(point)
        }

        /// 35km
        let bufferDistance: Double = 35_000
        let bufferedPolygon = BufferCalculator.makeBufferedCoordinate([polygon], bufferDistnace: bufferDistance, isInsideBuffer: false)

        for i in 0..<bufferedPolygon.count {
            for j in 0..<bufferedPolygon[i].count {
                let point = MKPointAnnotation()
                point.title = "buffered(\(i))"
                point.coordinate = bufferedPolygon[i][j]
                mapView.addAnnotation(point)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

