import XCTest
import Combine
@testable import APUtils

final class CollectionTests: XCTestCase {
    
    func testCollectiohn_occurences_withStrings() throws {
        // Given
        let collection = ["Jim", "Kevin", "Pam", "Dwight", "Dwight", "Kevin", "Angela", "Kevin"]
        
        // Then
        XCTAssertEqual(collection.occurences(of: "Jim"), 1)
        XCTAssertEqual(collection.occurences(of: "Pam"), 1)
        XCTAssertEqual(collection.occurences(of: "Dwight"), 2)
        XCTAssertEqual(collection.occurences(of: "Kevin"), 3)
        XCTAssertEqual(collection.occurences(of: "Angela"), 1)
        XCTAssertEqual(collection.occurences(of: "Creed"), 0)
    }
    
    func testCollection_occurences_withStruct() throws {
        // Given
        struct Employee: Hashable {
            let name: String
            let department: String
        }
        let jim = Employee(name: "Jim", department: "Sellings")
        let kevin = Employee(name: "Kevin", department: "Accounting")
        let pam = Employee(name: "Pam", department: "Reception")
        let dwight = Employee(name: "Dwight", department: "Sellings")
        let angela = Employee(name: "Angela", department: "Accounting")
        let creed = Employee(name: "Creed", department: "Nothing")
        
        let collection: [Employee] = [jim, kevin, pam, dwight, dwight, kevin, angela, kevin]
        
        // Then
        XCTAssertEqual(collection.occurences(of: jim), 1)
        XCTAssertEqual(collection.occurences(of: pam), 1)
        XCTAssertEqual(collection.occurences(of: dwight), 2)
        XCTAssertEqual(collection.occurences(of: kevin), 3)
        XCTAssertEqual(collection.occurences(of: angela), 1)
        XCTAssertEqual(collection.occurences(of: creed), 0)
    }
    
    
    func testCollection_safeAccess() throws {
        // Given
        let collection = [1,2,3,4]
        
        // Then
        XCTAssertEqual(collection[safe: 0], 1)
        XCTAssertEqual(collection[safe: 1], 2)
        XCTAssertEqual(collection[safe: 2], 3)
        XCTAssertEqual(collection[safe: 3], 4)
        XCTAssertNil(collection[safe: 4])
    }
    
    func testCollection_defaultSubsrcript() throws {
        // Given
        let collection = ["Dwight", "Jim", "Pam"]
        let someStringClosure: () -> String = {
            var s = "Andy"
            s += " "
            s += "Bernard"
            return s
        }
        
        // Then
        XCTAssertEqual(collection[0, default: "Michael"], "Dwight")
        XCTAssertEqual(collection[1, default: "Michael"], "Jim")
        XCTAssertEqual(collection[2, default: "Michael"], "Pam")
        XCTAssertEqual(collection[3, default: "Michael"], "Michael")
        XCTAssertEqual(collection[4, default: someStringClosure()], "Andy Bernard")
        
    }
    
    func testCollection_mergeToAnyPublisher() {
        // Given
        let publisher1 = Just(1)
        let publisher2 = Just(2)
        let publisher3 = Just(3)
        let mergedPublisher = [publisher1, publisher2, publisher3].mergeToAnyPublisher()
        let expectation = expectation(description: "publisher")
        // Then
        let cancellable = mergedPublisher
            .sink { completion in
                switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        XCTFail("Unexpected error " + error.localizedDescription)
                }
            } receiveValue: { value in
                XCTAssertTrue(
                    value == 1 ||
                    value == 2 ||
                    value == 3
                )
            }
        // When
        wait(for: [expectation], timeout: 2)
        cancellable.cancel()
    }
}
