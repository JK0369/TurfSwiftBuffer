# TurfSwiftBuffer

[![CI Status](https://img.shields.io/travis/JK0369/TurfSwiftBuffer.svg?style=flat)](https://travis-ci.org/JK0369/TurfSwiftBuffer)
[![Version](https://img.shields.io/cocoapods/v/TurfSwiftBuffer.svg?style=flat)](https://cocoapods.org/pods/TurfSwiftBuffer)
[![License](https://img.shields.io/cocoapods/l/TurfSwiftBuffer.svg?style=flat)](https://cocoapods.org/pods/TurfSwiftBuffer)
[![Platform](https://img.shields.io/cocoapods/p/TurfSwiftBuffer.svg?style=flat)](https://cocoapods.org/pods/TurfSwiftBuffer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- dependency: [Turf framework](https://github.com/mapbox/turf-swift)

## Installation

TurfSwiftBuffer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TurfSwiftBuffer'
```

## Using

- Given polygon coordinates, transform them into coordinates with an internal buffer.
```
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
        let bufferedPolygon = BufferCalculator.makeBufferedCoordinate([polygon], bufferDistnace: bufferDistance)

        for i in 0..<bufferedPolygon.count {
            for j in 0..<bufferedPolygon[i].count {
                let point = MKPointAnnotation()
                point.title = "buffered(\(i))"
                point.coordinate = bufferedPolygon[i][j]
                mapView.addAnnotation(point)
            }
        }
    }
}
```
- ![스크린샷 2021-09-02 오후 5 54 44](https://user-images.githubusercontent.com/43035817/131815276-71202c7b-ae31-4f49-a5f8-04d0f8c8dd4b.png)


## Author

Jongkwon.kim, palatable7@naver.com

## License

TurfSwiftBuffer is available under the MIT license. See the LICENSE file for more info.
