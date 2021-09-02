//
//  CLLocationCoordinate2D.swift
//  Pods
//
//  Created by 김종권 on 2021/09/02.
//

import CoreLocation

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
