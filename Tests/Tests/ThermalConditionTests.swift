import XCTest
@testable import ThermalView

final class ThermalConditionTests: XCTestCase {
    func testProcessInfoMapping() {
        XCTAssertEqual(ThermalCondition(.nominal), .nominal)
        XCTAssertEqual(ThermalCondition(.fair), .fair)
        XCTAssertEqual(ThermalCondition(.serious), .serious)
        XCTAssertEqual(ThermalCondition(.critical), .critical)
    }

    func testUserFacingContentIsPresent() {
        for condition in ThermalCondition.allCases {
            XCTAssertFalse(condition.displayTitle.isEmpty)
            XCTAssertFalse(condition.shortStatus.isEmpty)
            XCTAssertFalse(condition.recommendation.isEmpty)
            XCTAssertFalse(condition.technicalName.isEmpty)
            XCTAssertFalse(condition.iconName.isEmpty)
        }
    }

    func testProgressIsInVisibleRange() {
        for condition in ThermalCondition.allCases {
            XCTAssertGreaterThan(condition.progress, 0)
            XCTAssertLessThanOrEqual(condition.progress, 1)
        }
    }
}
