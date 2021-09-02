//
//  BufferCalculator.swift
//  TurfSwiftBuffer
//
//  Created by 김종권 on 2021/09/02.
//

import Turf
import CoreLocation

public class BufferCalculator {
    public typealias PolygonCoordinate = [CLLocationCoordinate2D]

    static public func makeBufferedCoordinate(_ polygonCoordinates: [PolygonCoordinate], bufferDistnace: Double) -> [PolygonCoordinate] {
        var bufferedCoordinates: [PolygonCoordinate] = [[]]

        polygonCoordinates.forEach { polygonCoordinate in
            var currentIndex = 0
            let count = polygonCoordinate.count
            var calculatedPolygon: PolygonCoordinate = []

            while currentIndex < count {
                var leftIndex = ((currentIndex - 1) + count) % count
                let rightIndex = ((currentIndex + 1) + count) % count

                var leftCoordinate = polygonCoordinate[leftIndex]
                let originCoordinate = polygonCoordinate[currentIndex]
                let rightCoordinate = polygonCoordinate[rightIndex]

                if originCoordinate != leftCoordinate, originCoordinate != rightCoordinate {
                    /// point where polygon coordinates do not overlap
                    let targetVector = getCenterVector(origin: originCoordinate,
                                                       left: leftCoordinate,
                                                       right: rightCoordinate,
                                                       bufferDistance: bufferDistnace,
                                                       polygonCoordinate: polygonCoordinate)

                    calculatedPolygon.append(targetVector)
                } else if originCoordinate != rightCoordinate {
                    /// If there is an overlapping point among polygon coordinates
                    leftIndex = ((leftIndex - 1) + count) % count
                    leftCoordinate = polygonCoordinate[leftIndex]
                    let targetVector = getCenterVector(origin: originCoordinate,
                                                       left: leftCoordinate,
                                                       right: rightCoordinate,
                                                       bufferDistance: bufferDistnace,
                                                       polygonCoordinate: polygonCoordinate)

                    calculatedPolygon.append(targetVector)
                }
                currentIndex += 1
            }

            bufferedCoordinates.append(calculatedPolygon)
        }
        return bufferedCoordinates
    }

    /// Returns a vector consisting of the sum of left and right vectors with origin as the starting point.
    static private func getCenterVector(origin: CLLocationCoordinate2D,
                                 left: CLLocationCoordinate2D,
                                 right: CLLocationCoordinate2D,
                                 bufferDistance: Double,
                                 polygonCoordinate: PolygonCoordinate) -> CLLocationCoordinate2D {

        let intermidiateLeftVector = (left - origin) / (origin.distance(to: left))
        let intermidiateRightVector = (right - origin) / (origin.distance(to: right))
        let targetDirectionVector = intermidiateLeftVector + intermidiateRightVector

        var targetVector = origin + (targetDirectionVector / (origin.distance(to: origin + targetDirectionVector)) * bufferDistance)

        // When a vector is obtained out of the coverage area, point symmetry
        if !contains(point: targetVector, for: [polygonCoordinate]) {
            targetVector = origin + (-targetDirectionVector / (origin.distance(to: origin + targetDirectionVector)) * bufferDistance)
        }

        return targetVector
    }

    static public func contains(point: CLLocationCoordinate2D, for coordinates: [PolygonCoordinate]) -> Bool {
        let polygon = Polygon(coordinates)
        return polygon.contains(point)
    }
}

/// Define the operator needed to calculate the coordinate values
extension CLLocationCoordinate2D {
    static func + (left: CLLocationCoordinate2D, right: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let latitude = left.latitude + right.latitude
        let longitude = left.longitude + right.longitude
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func + (coordinate: CLLocationCoordinate2D, operand: Double) -> CLLocationCoordinate2D {
        let latitude = coordinate.latitude + operand
        let longitude = coordinate.longitude + operand
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static prefix func - (coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: -coordinate.latitude, longitude: -coordinate.longitude)
    }

    static func - (left: CLLocationCoordinate2D, right: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let latitude = left.latitude - right.latitude
        let longitude = left.longitude - right.longitude
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func / (coordinate: CLLocationCoordinate2D, operand: Double) -> CLLocationCoordinate2D {
        let latitude = coordinate.latitude / operand
        let longitude = coordinate.longitude / operand
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func * (coordinate: CLLocationCoordinate2D, operand: Double) -> CLLocationCoordinate2D {
        let latitude = coordinate.latitude * operand
        let longitude = coordinate.longitude * operand
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

