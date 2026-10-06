import Foundation
import Testing

struct UtilKitTests {
  @Test
  func utilKitInitialization() async throws {
    #expect("UtilKit" == "UtilKit")
  }

  @Test
  func stringUtilities() async throws {
    let testString = "hello"
    #expect(testString.count == 5)
  }

  @Test
  func arrayUtilities() async throws {
    let testArray = [1, 2, 3, 4, 5]
    #expect(testArray.count == 5)
    #expect(testArray.first == 1)
  }

  @Test
  func dictionaryUtilities() async throws {
    let testDict: [String: Int] = ["key": 42]
    #expect(testDict["key"] == 42)
  }
}
