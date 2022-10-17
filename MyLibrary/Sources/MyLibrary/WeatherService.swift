import Alamofire


public protocol WeatherService {
    func getTemperature() async throws -> Int
}

enum BaseURL: String {
    case server = "https://api.openweathermap.org"
    case mockServer = "http://localhost:3000"
}

class WeatherServiceImpl: WeatherService {
    let url = "\(BaseURL.server.rawValue)/data/2.5/weather?q=corvallis&units=metric&appid=17c25699e36c43321a7fdd99c2fbe828"

    
    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

struct Weather: Decodable {
    let main: Main
    
    struct Main: Decodable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
        let humidity: Double
    }
}

