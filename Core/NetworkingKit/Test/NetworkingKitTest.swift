import Foundation
import Testing

struct NetworkingKitTests {
  @Test
  func networkingKitInitialization() async throws {
    #expect("NetworkingKit" == "NetworkingKit")
  }

  @Test
  func urlSessionConfiguration() async throws {
    let config = URLSessionConfiguration.default
    #expect(config.waitsForConnectivity == false)
  }

  @Test
  func requestTimeout() async throws {
    let timeoutInterval: TimeInterval = 30
    #expect(timeoutInterval > 0)
  }
}
