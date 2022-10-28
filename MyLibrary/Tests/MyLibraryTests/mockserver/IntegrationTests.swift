//
//  IntegrationTests.swift
//  
//
//  Created by Kate G on 10/26/22.
//

import XCTest
@testable import MyLibrary

final class IntegrationTests: XCTestCase {
    
    func testWeatherService() async throws {
        
        // Given
        
        let url = "https://api.openweathermap.org/data/2.5/weather?q=corvallis&units=metric&appid=17c25699e36c43321a7fdd99c2fbe828"
        let weather = WeatherServiceImpl()
        
        // When
        
        let temp = try await weather.getTemperature()

        
        // Then
        
        XCTAssertEqual(temp, 11)
    }
    
}
