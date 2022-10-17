import XCTest
@testable import MyLibrary


final class MyLibraryTests: XCTestCase {
    
    func testFilepath() {
        let filePath = Bundle.module.path(forResource: "data", ofType: "json")
        XCTAssertNotNil(filePath)
    }
    
    
    
    func testTemperature() throws{
        
        //given
        let filePath = try XCTUnwrap(Bundle.module.path(forResource: "data", ofType: "json"))
        let jsonString = try String (contentsOfFile: filePath)
        let jsonData = Data(jsonString.utf8)
        let jsonDecoder = JSONDecoder()
        
        //when
        let weather = try jsonDecoder.decode(Weather.self, from: jsonData)
        let temp = weather.main.temp
        let temp_min = weather.main.temp_min
        let temp_max = weather.main.temp_max
        let humidity = weather.main.humidity
        
        //then
        XCTAssertTrue(temp >= temp_min && temp <= temp_max && humidity < 90, "current temperature is out of range")
        
    }
    
    
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )
        
        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        
        // When
        let isLuckyNumber = await myLibrary.isLucky(8)
        
        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }
    
    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )
        
        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        
        // When
        let isLuckyNumber = await myLibrary.isLucky(0)
        
        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }
    
    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )
        
        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        
        // When
        let isLuckyNumber = await myLibrary.isLucky(7)
        
        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }
    
    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )
        
        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        
        // When
        let isLuckyNumber = await myLibrary.isLucky(7)
        
        // Then
        XCTAssertNil(isLuckyNumber)
    }
    
}
