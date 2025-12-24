//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Nestor Camela on 23/12/2025.
//

import Testing
import Foundation
@testable import WeatherApp

struct WeatherAppTests {
    //Network tests
    @Test("Check API_KEY")
    func testApiKey(){
        #expect(Bundle.main.infoDictionary?["API_KEY"] != nil)
    }
    
    @Test("Testing weather data fetching")
     func testGetWeather() async throws {
         let vm = ViewModel()
         try await vm.getWeather(coord: Coord(lat: -34.6036232292415, lon:  -58.38166983895168))
         #expect(vm.response?.weather.count ?? 0 > 0)
     }
    
    @Test("Testing not Auth URL")
    func testNot200() async throws {
        do {
            let queryParams = [URLQueryItem(name: "lat", value: "\(-34.6036232292415)"),
                               URLQueryItem(name: "lon", value: "\(-58.38166983895168)"),
                               URLQueryItem(name: "units", value: "metric")]
            _ = try await NetworkManager<Response>.getData(path: "notAuthURL", queryParams: queryParams)
        } catch {
            #expect(error as? NetworkUseCase == NetworkUseCase.notAuthorized)
        }
        
    }
}
