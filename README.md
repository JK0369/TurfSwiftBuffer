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

## Logic

- Internal Buffer: Calculate using a vector the inner coordinates you want to find in a polygon of coordinates p1, p2, ... p6
  - ex) Inner coordinates of p1: obtained by adding the left p2 vector of p1 and the right p6 vector of p1
![image](https://user-images.githubusercontent.com/43035817/131820021-7048414d-f321-4d52-b10c-38ec48afc271.png)

- Method to get the inner coordinate of p1: `getCenterVector(origin:left:right:bufferDistance:polygonCoordinate:isInsideBuffer:)`
  - 1) Change each left and right vector to an origin vector of length 1
  - 2) Sum of left and right vectors
  - 3) Acquire the final internal coordinates by applying translation and the length of the vector
![image](https://user-images.githubusercontent.com/43035817/131820138-8be692d3-3e9b-429e-b597-6631c751961f.png)

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


```
  
|Inner buffer|Outter buffer|
|------|---|
|![스크린샷 2021-09-02 오후 5 54 44](https://user-images.githubusercontent.com/43035817/131815276-71202c7b-ae31-4f49-a5f8-04d0f8c8dd4b.png)|![스크린샷 2021-09-02 오후 6 19 37](https://user-images.githubusercontent.com/43035817/131819287-9c9f532e-e91c-4bab-880b-e9ba25d42e31.png)|
   
## Author

Jongkwon.kim, palatable7@naver.com

## License

TurfSwiftBuffer is available under the MIT license. See the LICENSE file for more info.
